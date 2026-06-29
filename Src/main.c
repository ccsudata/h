#include <stdio.h>
#include <stdlib.h>
#include "stm32f1xx_hal.h"
#include "defines.h"
#include "setup.h"
#include "config.h"
#include "util.h"
#include "BLDC_controller.h"
#include "rtwtypes.h"
#include "comms.h"

void SystemClock_Config(void);

extern TIM_HandleTypeDef htim_left;
extern TIM_HandleTypeDef htim_right;
extern ADC_HandleTypeDef hadc1;
extern ADC_HandleTypeDef hadc2;
extern volatile adc_buf_t adc_buffer;
extern UART_HandleTypeDef huart2;
extern UART_HandleTypeDef huart3;

volatile uint8_t uart_buf[200];

extern P    rtP_Left;
extern P    rtP_Right;
extern ExtY rtY_Left;
extern ExtY rtY_Right;
extern ExtU rtU_Left;
extern ExtU rtU_Right;

extern uint8_t     inIdx;
extern uint8_t     inIdx_prev;
extern InputStruct input1[];
extern InputStruct input2[];

extern int16_t speedAvg;
extern int16_t speedAvgAbs;
extern volatile uint32_t timeoutCntGen;
extern volatile uint8_t  timeoutFlgGen;
extern uint8_t timeoutFlgADC;
extern uint8_t timeoutFlgSerial;

extern volatile int pwml;
extern volatile int pwmr;

extern uint8_t enable;
extern int16_t batVoltage;

uint8_t backwardDrive;
extern volatile uint32_t buzzerTimer;
volatile uint32_t main_loop_counter;
int16_t batVoltageCalib;
int16_t board_temp_deg_c;
int16_t left_dc_curr;
int16_t right_dc_curr;
int16_t dc_curr;
int16_t cmdL;
int16_t cmdR;

typedef struct{
  uint16_t  start;
  int16_t   cmd1;
  int16_t   cmd2;
  int16_t   speedR_meas;
  int16_t   speedL_meas;
  int16_t   batVoltage;
  int16_t   boardTemp;
  uint16_t  cmdLed;
  uint16_t  checksum;
} SerialFeedback;
static SerialFeedback Feedback;
static uint8_t sideboard_leds_R;
static int16_t speed;
static int16_t steer;
static int16_t steerRateFixdt;
static int16_t speedRateFixdt;
static int32_t steerFixdt;
static int32_t speedFixdt;
static uint32_t    buzzerTimer_prev = 0;
static uint32_t    inactivity_timeout_counter;
static MultipleTap MultipleTapBrake;
static uint16_t rate = RATE;

int main(void) {

  HAL_Init();
  __HAL_RCC_AFIO_CLK_ENABLE();
  HAL_NVIC_SetPriorityGrouping(NVIC_PRIORITYGROUP_4);
  HAL_NVIC_SetPriority(MemoryManagement_IRQn, 0, 0);
  HAL_NVIC_SetPriority(BusFault_IRQn, 0, 0);
  HAL_NVIC_SetPriority(UsageFault_IRQn, 0, 0);
  HAL_NVIC_SetPriority(SVCall_IRQn, 0, 0);
  HAL_NVIC_SetPriority(DebugMonitor_IRQn, 0, 0);
  HAL_NVIC_SetPriority(PendSV_IRQn, 0, 0);
  HAL_NVIC_SetPriority(SysTick_IRQn, 0, 0);

  SystemClock_Config();

  __HAL_RCC_DMA1_CLK_DISABLE();
  MX_GPIO_Init();
  MX_TIM_Init();
  MX_ADC1_Init();
  MX_ADC2_Init();
  BLDC_Init();

  HAL_GPIO_WritePin(OFF_PORT, OFF_PIN, GPIO_PIN_SET);
  Input_Lim_Init();
  Input_Init();

  HAL_ADC_Start(&hadc1);
  HAL_ADC_Start(&hadc2);

  poweronMelody();
  HAL_GPIO_WritePin(LED_PORT, LED_PIN, GPIO_PIN_SET);
  
  int32_t board_temp_adcFixdt = adc_buffer.temp << 16;
  int16_t board_temp_adcFilt  = adc_buffer.temp;

  while(HAL_GPIO_ReadPin(BUTTON_PORT, BUTTON_PIN)) { HAL_Delay(10); }

  while(1) {
    if (buzzerTimer - buzzerTimer_prev > 16*DELAY_IN_MAIN_LOOP) {

    readCommand();
    calcAvgSpeed();

    if (enable == 0 && !rtY_Left.z_errCode && !rtY_Right.z_errCode && 
        ABS(input1[inIdx].cmd) < 50 && ABS(input2[inIdx].cmd) < 50){
      beepShort(6);
      beepShort(4); HAL_Delay(100);
      steerFixdt = speedFixdt = 0;
      enable = 1;
    }

      uint16_t speedBlend;
      speedBlend = (uint16_t)(((CLAMP(speedAvgAbs,10,60) - 10) << 15) / 50);

      if (inIdx == CONTROL_ADC) {
        if (speedAvgAbs < 60) {
          multipleTapDet(input1[inIdx].cmd, HAL_GetTick(), &MultipleTapBrake);
        }

        if (input1[inIdx].cmd > 30) {
          input2[inIdx].cmd = (int16_t)((input2[inIdx].cmd * speedBlend) >> 15);
          cruiseControl((uint8_t)rtP_Left.b_cruiseCtrlEna);
        }
      }

      if (inIdx == CONTROL_ADC) {
        if (speedAvg > 0) {
          input1[inIdx].cmd = (int16_t)((-input1[inIdx].cmd * speedBlend) >> 15);
        } else {
          input1[inIdx].cmd = (int16_t)(( input1[inIdx].cmd * speedBlend) >> 15);
        }
      }

      rateLimiter16(input1[inIdx].cmd, rate, &steerRateFixdt);
      rateLimiter16(input2[inIdx].cmd, rate, &speedRateFixdt);
      filtLowPass32(steerRateFixdt >> 4, FILTER, &steerFixdt);
      filtLowPass32(speedRateFixdt >> 4, FILTER, &speedFixdt);
      steer = (int16_t)(steerFixdt >> 16);
      speed = (int16_t)(speedFixdt >> 16);

      if (inIdx == CONTROL_ADC) {
        if (!MultipleTapBrake.b_multipleTap) {
          speed = steer + speed;
        } else {
          speed = steer - speed;
        }
        steer = 0;
      }

        mixerFcn(speed << 4, steer << 4, &cmdR, &cmdL);

        pwmr = -cmdR;

        pwml = cmdL;

      sideboardLeds(&sideboard_leds_R);

    filtLowPass32(adc_buffer.temp, TEMP_FILT_COEF, &board_temp_adcFixdt);
    board_temp_adcFilt  = (int16_t)(board_temp_adcFixdt >> 16);
    board_temp_deg_c    = (TEMP_CAL_HIGH_DEG_C - TEMP_CAL_LOW_DEG_C) * (board_temp_adcFilt - TEMP_CAL_LOW_ADC) / (TEMP_CAL_HIGH_ADC - TEMP_CAL_LOW_ADC) + TEMP_CAL_LOW_DEG_C;

    batVoltageCalib = batVoltage * BAT_CALIB_REAL_VOLTAGE / BAT_CALIB_ADC;

    left_dc_curr  = -(rtU_Left.i_DCLink * 100) / A2BIT_CONV;
    right_dc_curr = -(rtU_Right.i_DCLink * 100) / A2BIT_CONV;
    dc_curr       = left_dc_curr + right_dc_curr;

      if (main_loop_counter % 2 == 0) {
        Feedback.start	        = (uint16_t)SERIAL_START_FRAME;
        Feedback.cmd1           = (int16_t)input1[inIdx].cmd;
        Feedback.cmd2           = (int16_t)input2[inIdx].cmd;
        Feedback.speedR_meas	  = (int16_t)rtY_Right.n_mot;
        Feedback.speedL_meas	  = (int16_t)rtY_Left.n_mot;
        Feedback.batVoltage	    = (int16_t)batVoltageCalib;
        Feedback.boardTemp	    = (int16_t)board_temp_deg_c;

          if(__HAL_DMA_GET_COUNTER(huart3.hdmatx) == 0) {
            Feedback.cmdLed     = (uint16_t)sideboard_leds_R;
            Feedback.checksum   = (uint16_t)(Feedback.start ^ Feedback.cmd1 ^ Feedback.cmd2 ^ Feedback.speedR_meas ^ Feedback.speedL_meas 
                                           ^ Feedback.batVoltage ^ Feedback.boardTemp ^ Feedback.cmdLed);

            HAL_UART_Transmit_DMA(&huart3, (uint8_t *)&Feedback, sizeof(Feedback));
          }
      }

    poweroffPressCheck();

    if (TEMP_POWEROFF_ENABLE && board_temp_deg_c >= TEMP_POWEROFF && speedAvgAbs < 20){
      poweroff();
    } else if ( BAT_DEAD_ENABLE && batVoltage < BAT_DEAD && speedAvgAbs < 20){
      poweroff();
    } else if (rtY_Left.z_errCode || rtY_Right.z_errCode) {
      enable = 0;
      beepCount(1, 24, 1);
    } else if (timeoutFlgADC) {
      beepCount(2, 24, 1);
    } else if (timeoutFlgSerial) {
      beepCount(3, 24, 1);
    } else if (timeoutFlgGen) {
      beepCount(4, 24, 1);
    } else if (TEMP_WARNING_ENABLE && board_temp_deg_c >= TEMP_WARNING) {
      beepCount(5, 24, 1);
    } else if (BAT_LVL1_ENABLE && batVoltage < BAT_LVL1) {
      beepCount(0, 10, 6);
    } else if (BAT_LVL2_ENABLE && batVoltage < BAT_LVL2) {
      beepCount(0, 10, 30);
    } else if (BEEPS_BACKWARD && (((cmdR < -50 || cmdL < -50) && speedAvg < 0) || MultipleTapBrake.b_multipleTap)) {
      beepCount(0, 5, 1);
      backwardDrive = 1;
    } else {
      beepCount(0, 0, 0);
      backwardDrive = 0;
    }

    inactivity_timeout_counter++;

    if (abs(cmdL) > 50 || abs(cmdR) > 50) {
      inactivity_timeout_counter = 0;
    }

    if (inactivity_timeout_counter > (INACTIVITY_TIMEOUT * 60 * 1000) / (DELAY_IN_MAIN_LOOP + 1)) {
      poweroff();
    }

    inIdx_prev = inIdx;
    buzzerTimer_prev = buzzerTimer;
    main_loop_counter++;
    }
  }
}

void SystemClock_Config(void) {
  RCC_OscInitTypeDef RCC_OscInitStruct;
  RCC_ClkInitTypeDef RCC_ClkInitStruct;
  RCC_PeriphCLKInitTypeDef PeriphClkInit;

  RCC_OscInitStruct.OscillatorType      = RCC_OSCILLATORTYPE_HSI;
  RCC_OscInitStruct.HSIState            = RCC_HSI_ON;
  RCC_OscInitStruct.HSICalibrationValue = 16;
  RCC_OscInitStruct.PLL.PLLState        = RCC_PLL_ON;
  RCC_OscInitStruct.PLL.PLLSource       = RCC_PLLSOURCE_HSI_DIV2;
  RCC_OscInitStruct.PLL.PLLMUL          = RCC_PLL_MUL16;
  HAL_RCC_OscConfig(&RCC_OscInitStruct);

  RCC_ClkInitStruct.ClockType           = RCC_CLOCKTYPE_HCLK | RCC_CLOCKTYPE_SYSCLK | RCC_CLOCKTYPE_PCLK1 | RCC_CLOCKTYPE_PCLK2;
  RCC_ClkInitStruct.SYSCLKSource        = RCC_SYSCLKSOURCE_PLLCLK;
  RCC_ClkInitStruct.AHBCLKDivider       = RCC_SYSCLK_DIV1;
  RCC_ClkInitStruct.APB1CLKDivider      = RCC_HCLK_DIV2;
  RCC_ClkInitStruct.APB2CLKDivider      = RCC_HCLK_DIV1;

  HAL_RCC_ClockConfig(&RCC_ClkInitStruct, FLASH_LATENCY_2);

  PeriphClkInit.PeriphClockSelection    = RCC_PERIPHCLK_ADC;
  PeriphClkInit.AdcClockSelection       = RCC_ADCPCLK2_DIV4;
  HAL_RCCEx_PeriphCLKConfig(&PeriphClkInit);

  HAL_SYSTICK_Config(HAL_RCC_GetHCLKFreq() / 1000);
  HAL_SYSTICK_CLKSourceConfig(SYSTICK_CLKSOURCE_HCLK);
  HAL_NVIC_SetPriority(SysTick_IRQn, 0, 0);
}