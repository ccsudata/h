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

/* ---------- 刹车/倒车/锁定参数（可配置宏，未定义则用默认值） ---------- */
#ifndef BRAKE_PEDAL_THRESHOLD
#define BRAKE_PEDAL_THRESHOLD       30
#endif
#ifndef BRAKE_MIN_SPEED_RPM
#define BRAKE_MIN_SPEED_RPM         10
#endif
#ifndef BRAKE_SMOOTH_ZONE_RPM
#define BRAKE_SMOOTH_ZONE_RPM       60
#endif
#ifndef BRAKE_MAX_LIMIT
#define BRAKE_MAX_LIMIT             1000
#endif
#ifndef BRAKE_RAMP_STEP
#define BRAKE_RAMP_STEP             10
#endif
#ifndef REVERSE_SPEED_LIMIT
#define REVERSE_SPEED_LIMIT         250
#endif
#ifndef BRAKE_DEBOUNCE_TICKS
#define BRAKE_DEBOUNCE_TICKS        3
#endif

/* ---------- 刹车/倒车/锁定状态变量 ---------- */
static uint8_t  brakeConfirmed      = 0;
static int16_t  filteredBrakeCmd    = 0;
static uint8_t  brakeThrottleLock   = 0;
static uint8_t  reverseActive       = 0;
static uint8_t  prevBrakeConfirmed  = 0;
static uint8_t  brakeOnCnt          = 0;
static uint8_t  brakeOffCnt         = 0;
static uint32_t lastLogTick         = 0;

/* 辅助宏 */
#define SIGN(x) (((x) > 0) ? 1 : (((x) < 0) ? -1 : 0))

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

    /* ---- 新控制逻辑开始 ---- */

    /* 读取映射后的踏板值 (0-1000 范围)：PRI_INPUT1=油门, PRI_INPUT2=刹车 */
    int16_t rawThrottle = input1[inIdx].cmd;   /* 油门转把 */
    int16_t rawBrake    = input2[inIdx].cmd;   /* 刹车踏板 */

    /* ---------- 刹车信号防抖 ---------- */
    if (rawBrake > BRAKE_PEDAL_THRESHOLD) {
        if (brakeOnCnt < BRAKE_DEBOUNCE_TICKS) {
            brakeOnCnt++;
        }
        if (brakeOnCnt >= BRAKE_DEBOUNCE_TICKS) {
            brakeConfirmed = 1;
            brakeOffCnt = 0;
        }
    } else {
        if (brakeOffCnt < BRAKE_DEBOUNCE_TICKS) {
            brakeOffCnt++;
        }
        if (brakeOffCnt >= BRAKE_DEBOUNCE_TICKS) {
            brakeConfirmed = 0;
            brakeOnCnt = 0;
        }
    }

    /* ---------- 油门锁定（刹车释放下降沿） ---------- */
    if (prevBrakeConfirmed && !brakeConfirmed && rawThrottle > 10) {
        brakeThrottleLock = 1;
    }
    if (brakeThrottleLock && rawThrottle < 10) {
        brakeThrottleLock = 0;
    }

    /* ---------- 刹车时取消巡航 ---------- */
    if (rawBrake > 30) {
        cruiseControl(0);
    } else {
        /* 原巡航激活逻辑（可根据需求保留） */
        if (inIdx == CONTROL_ADC && speedAvgAbs < 60 && rawThrottle > 30) {
            cruiseControl((uint8_t)rtP_Left.b_cruiseCtrlEna);
        }
    }

    /* ---------- 双击检测（刹车踏板） ---------- */
    if (speedAvgAbs < 60 && rawBrake > BRAKE_PEDAL_THRESHOLD) {
        multipleTapDet(1, HAL_GetTick(), &MultipleTapBrake);
    } else {
        multipleTapDet(0, HAL_GetTick(), &MultipleTapBrake);
    }

    /* ---------- 倒车模式管理 ---------- */
    if (!reverseActive) {
        /* 进入条件 */
        if (speedAvgAbs < 60 &&
            MultipleTapBrake.b_multipleTap &&
            !brakeConfirmed &&
            !brakeThrottleLock &&
            rawThrottle > 10) {
            reverseActive = 1;
        }
    } else {
        /* 退出条件 */
        if (rawThrottle < 10 || brakeConfirmed || brakeThrottleLock) {
            reverseActive = 0;
            MultipleTapBrake.b_multipleTap = 0; /* 退出时清除双击标志 */
        }
    }

    /* ---------- 刹车目标力计算 ---------- */
    int32_t speedFactor;
    if (speedAvgAbs < BRAKE_MIN_SPEED_RPM) {
        speedFactor = 0;
    } else if (speedAvgAbs < BRAKE_SMOOTH_ZONE_RPM) {
        speedFactor = (speedAvgAbs - BRAKE_MIN_SPEED_RPM) * 1000L / (BRAKE_SMOOTH_ZONE_RPM - BRAKE_MIN_SPEED_RPM);
    } else {
        speedFactor = 1000;
    }

    int32_t brakeTarget = (rawBrake * speedFactor) / 1000;
    if (brakeTarget < 0) brakeTarget = 0;
    if (brakeTarget > BRAKE_MAX_LIMIT) brakeTarget = BRAKE_MAX_LIMIT;

    /* ---------- 刹车力斜坡逼近 ---------- */
    if (filteredBrakeCmd < brakeTarget) {
        filteredBrakeCmd += BRAKE_RAMP_STEP;
        if (filteredBrakeCmd > brakeTarget) filteredBrakeCmd = brakeTarget;
    } else if (filteredBrakeCmd > brakeTarget) {
        filteredBrakeCmd -= BRAKE_RAMP_STEP;
        if (filteredBrakeCmd < brakeTarget) filteredBrakeCmd = brakeTarget;
    }

    /* ---------- 综合油门命令计算（throttleCommand） ---------- */
    int16_t throttleCommand = 0;

    if (brakeConfirmed) {
        /* 制动优先 */
        if (speedAvgAbs <= BRAKE_MIN_SPEED_RPM) {
            throttleCommand = 0;
        } else if (speedAvgAbs < BRAKE_SMOOTH_ZONE_RPM) {
            throttleCommand = (-SIGN(speedAvg) * filteredBrakeCmd * speedAvgAbs) / BRAKE_SMOOTH_ZONE_RPM;
        } else {
            throttleCommand = -SIGN(speedAvg) * filteredBrakeCmd;
        }
    } else if (brakeThrottleLock) {
        /* 油门锁定 */
        throttleCommand = 0;
        /* 刹车力缓慢归零 */
        filteredBrakeCmd = 0;  /* 锁定触发后直接归零，亦可斜坡归零；这里简单清零保证平滑 */
    } else if (reverseActive) {
        /* 倒车模式 */
        int32_t limit = REVERSE_SPEED_LIMIT;
        int32_t raw = rawThrottle;
        if (raw > limit) raw = limit;
        throttleCommand = -raw;  /* 负值表示倒车 */
        if (throttleCommand < -REVERSE_SPEED_LIMIT) throttleCommand = -REVERSE_SPEED_LIMIT;
    } else {
        /* 正常前进 */
        if (rawThrottle < 10) {
            throttleCommand = 0;
        } else {
            throttleCommand = rawThrottle;
        }
    }

    /* ---------- 将最终命令写入输入通道 ---------- */
    /* input1 用作转向，在 ADC 模式下强制置零 */
    if (inIdx == CONTROL_ADC) {
        input1[inIdx].cmd = 0;
    }
    input2[inIdx].cmd = throttleCommand;

    /* ---------- 原有的命令平滑与混控 ---------- */
    rateLimiter16(input1[inIdx].cmd, rate, &steerRateFixdt);
    rateLimiter16(input2[inIdx].cmd, rate, &speedRateFixdt);
    filtLowPass32(steerRateFixdt >> 4, FILTER, &steerFixdt);
    filtLowPass32(speedRateFixdt >> 4, FILTER, &speedFixdt);
    steer = (int16_t)(steerFixdt >> 16);
    speed = (int16_t)(speedFixdt >> 16);

    /* 混控器生成左右轮命令（转向为0时直行） */
    mixerFcn(speed << 4, steer << 4, &cmdR, &cmdL);
    pwmr = -cmdR;
    pwml = cmdL;

    /* ---- 新控制逻辑结束 ---- */

    sideboardLeds(&sideboard_leds_R);

    filtLowPass32(adc_buffer.temp, TEMP_FILT_COEF, &board_temp_adcFixdt);
    board_temp_adcFilt  = (int16_t)(board_temp_adcFixdt >> 16);
    board_temp_deg_c    = (TEMP_CAL_HIGH_DEG_C - TEMP_CAL_LOW_DEG_C) * (board_temp_adcFilt - TEMP_CAL_LOW_ADC) / (TEMP_CAL_HIGH_ADC - TEMP_CAL_LOW_ADC) + TEMP_CAL_LOW_DEG_C;

    batVoltageCalib = batVoltage * BAT_CALIB_REAL_VOLTAGE / BAT_CALIB_ADC;

    left_dc_curr  = -(rtU_Left.i_DCLink * 100) / A2BIT_CONV;
    right_dc_curr = -(rtU_Right.i_DCLink * 100) / A2BIT_CONV;
    dc_curr       = left_dc_curr + right_dc_curr;

    /* ---------- 串口反馈（保留原有协议） ---------- */
    if (main_loop_counter % 2 == 0) {
        Feedback.start	        = (uint16_t)SERIAL_START_FRAME;
        Feedback.cmd1           = (int16_t)input1[inIdx].cmd;
        Feedback.cmd2           = (int16_t)input2[inIdx].cmd;
        Feedback.speedR_meas	  = (int16_t)rtY_Right.n_mot;
        Feedback.speedL_meas	  = (int16_t)rtY_Left.n_mot;
        Feedback.batVoltage	    = (int16_t)batVoltageCalib;
        Feedback.boardTemp	    = (int16_t)board_temp_deg_c;

        // ===== 改进：增加安全判断，防止未初始化时访问空指针 =====
        if (huart3.hdmatx != NULL &&
            huart3.gState == HAL_UART_STATE_READY &&
            huart3.hdmatx->State == HAL_DMA_STATE_READY) {
            Feedback.cmdLed     = (uint16_t)sideboard_leds_R;
            Feedback.checksum   = (uint16_t)(Feedback.start ^ Feedback.cmd1 ^ Feedback.cmd2 ^ Feedback.speedR_meas ^ Feedback.speedL_meas 
                                           ^ Feedback.batVoltage ^ Feedback.boardTemp ^ Feedback.cmdLed);

            HAL_UART_Transmit_DMA(&huart3, (uint8_t *)&Feedback, sizeof(Feedback));
        }
        // ===== 改进结束 =====
    }

    /* ---------- 调试日志：每秒通过 USART3 输出一次状态 ---------- */
    {
        uint32_t now = HAL_GetTick();
        if (now - lastLogTick >= 1000U) {
            if (huart3.gState == HAL_UART_STATE_READY &&
                huart3.hdmatx != NULL && huart3.hdmatx->State == HAL_DMA_STATE_READY) {

                static char buf[256];
                int motionDir = (speedAvg > 0) ? 1 : ((speedAvg < 0) ? -1 : 0);

                /* 获取接收数据（长度最多12字节） */
                char rx_hex_str[32] = {0};
#if defined(FEEDBACK_SERIAL_USART3)
                uint32_t rx_len = 0;
                const uint8_t *rx_data = get_usart3_rx_latest(&rx_len);
                if (rx_data != NULL && rx_len > 0) {
                    int p = 0;
                    uint32_t max_bytes = (rx_len > 12) ? 12 : rx_len;
                    for (uint32_t i = 0; i < max_bytes; i++) {
                        p += snprintf(rx_hex_str + p, sizeof(rx_hex_str) - p, "%02X ", rx_data[i]);
                    }
                    if (rx_len > 12) {
                        snprintf(rx_hex_str + p - 1, sizeof(rx_hex_str) - p + 1, "..");
                    }
                } else {
                    snprintf(rx_hex_str, sizeof(rx_hex_str), "");
                }
#else
                snprintf(rx_hex_str, sizeof(rx_hex_str), "");
#endif

                /* 错误码 */
                char err_detail[24] = {0};
                if (g_ctrlErrDetail_Left != 0U || g_ctrlErrDetail_Right != 0U) {
                    snprintf(err_detail, sizeof(err_detail), " errL:%02X errR:%02X",
                             (unsigned int)g_ctrlErrDetail_Left,
                             (unsigned int)g_ctrlErrDetail_Right);
                }

                int written = snprintf(buf, sizeof(buf),
                    "%lums L:%d R:%d TX2:%d RX2:%d fs:%d st:%d cL:%d cR:%d V:%d T:%d rev:%d tap:%d dir:%d br:%d bt:%d fbc:%d thr:%d%s [%s]\r\n",
                    (unsigned long)now,
                    (int)Feedback.speedL_meas,
                    (int)Feedback.speedR_meas,
                    (int)adc_buffer.l_tx2,
                    (int)adc_buffer.l_rx2,
                    (int)speed,
                    (int)steer,
                    (int)cmdL,
                    (int)cmdR,
                    (int)Feedback.batVoltage,
                    (int)Feedback.boardTemp,
                    (int)reverseActive,
                    (int)MultipleTapBrake.b_multipleTap,
                    motionDir,
                    (int)rawBrake,
                    (int)brakeTarget,
                    (int)filteredBrakeCmd,
                    (int)throttleCommand,
                    err_detail,
                    rx_hex_str);

                if (written > 0 && written < sizeof(buf)) {
                    HAL_UART_Transmit_DMA(&huart3, (uint8_t *)buf, written);
                }
                lastLogTick = now;
            }
        }
    }

    /* ---------- 错误与报警 ---------- */
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
    } else if (BEEPS_BACKWARD && (((cmdR < -50 || cmdL < -50) && speedAvg < 0) || MultipleTapBrake.b_multipleTap || reverseActive)) {
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

    /* 保存上一周期刹车状态（用于下降沿检测） */
    prevBrakeConfirmed = brakeConfirmed;

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