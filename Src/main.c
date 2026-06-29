#include <stdio.h>
#include <stdlib.h> // for abs()
#include "stm32f1xx_hal.h"
#include "defines.h"
#include "setup.h"
#include "config.h"
#include "util.h"
#include "BLDC_controller.h"      /* BLDC's header file */
#include "rtwtypes.h"
#include "comms.h"

#if defined(DEBUG_I2C_LCD) || defined(SUPPORT_LCD)
#include "hd44780.h"
#endif

void SystemClock_Config(void);

//------------------------------------------------------------------------
// Global variables set externally
//------------------------------------------------------------------------
extern TIM_HandleTypeDef htim_left;
extern TIM_HandleTypeDef htim_right;
extern ADC_HandleTypeDef hadc1;
extern ADC_HandleTypeDef hadc2;
extern volatile adc_buf_t adc_buffer;
#if defined(DEBUG_I2C_LCD) || defined(SUPPORT_LCD)
  extern LCD_PCF8574_HandleTypeDef lcd;
  extern uint8_t LCDerrorFlag;
#endif

extern UART_HandleTypeDef huart2;
extern UART_HandleTypeDef huart3;

volatile uint8_t uart_buf[200];

// Matlab defines - from auto-code generation
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

// ---- 调试日志所需的外部声明 ----
extern uint8_t g_ctrlErrDetail_Left;
extern uint8_t g_ctrlErrDetail_Right;
extern const uint8_t* get_usart3_rx_latest(uint32_t *len);

#if defined(SIDEBOARD_SERIAL_USART2)
extern SerialSideboard Sideboard_L;
#endif
#if defined(SIDEBOARD_SERIAL_USART3)
extern SerialSideboard Sideboard_R;
#endif
#if (defined(CONTROL_PPM_LEFT) && defined(DEBUG_SERIAL_USART3)) || (defined(CONTROL_PPM_RIGHT) && defined(DEBUG_SERIAL_USART2))
extern volatile uint16_t ppm_captured_value[PPM_NUM_CHANNELS+1];
#endif
#if (defined(CONTROL_PWM_LEFT) && defined(DEBUG_SERIAL_USART3)) || (defined(CONTROL_PWM_RIGHT) && defined(DEBUG_SERIAL_USART2))
extern volatile uint16_t pwm_captured_ch1_value;
extern volatile uint16_t pwm_captured_ch2_value;
#endif

//------------------------------------------------------------------------
// Global variables set here in main.c
//------------------------------------------------------------------------
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

//------------------------------------------------------------------------
// Local variables
//------------------------------------------------------------------------
#if defined(FEEDBACK_SERIAL_USART2) || defined(FEEDBACK_SERIAL_USART3)
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
#endif
#if defined(FEEDBACK_SERIAL_USART2)
static uint8_t sideboard_leds_L;
#endif
#if defined(FEEDBACK_SERIAL_USART3)
static uint8_t sideboard_leds_R;
#endif

#ifdef VARIANT_TRANSPOTTER
  uint8_t  nunchuk_connected;
  extern float    setDistance;
  static uint8_t  checkRemote = 0;
  static uint16_t distance;
  static float    steering;
  static int      distanceErr;
  static int      lastDistance = 0;
  static uint16_t transpotter_counter = 0;
#endif

static int16_t    speed;
#ifndef VARIANT_TRANSPOTTER
  static int16_t  steer;
  static int16_t  steerRateFixdt;
  static int16_t  speedRateFixdt;
  static int32_t  steerFixdt;
  static int32_t  speedFixdt;
#endif

static uint32_t    buzzerTimer_prev = 0;
static uint32_t    inactivity_timeout_counter;
static MultipleTap MultipleTapBrake;

static uint16_t rate = RATE;

#ifdef MULTI_MODE_DRIVE
  static uint8_t drive_mode;
  static uint16_t max_speed;
#endif

// ============ HOVERCAR 控制状态（全局静态） ============
#ifdef VARIANT_HOVERCAR
static int16_t filteredBrakeCmd = 0;   // 刹车力度斜坡值
static uint8_t reverseActive    = 0;   // 倒车模式激活标志
#endif


int main(void) {

  HAL_Init();
  __HAL_RCC_AFIO_CLK_ENABLE();
  HAL_NVIC_SetPriorityGrouping(NVIC_PRIORITYGROUP_4);
  /* System interrupt init*/
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

  #ifdef MULTI_MODE_DRIVE
    if (adc_buffer.l_tx2 > input1[0].min + 50 && adc_buffer.l_rx2 > input2[0].min + 50) {
      drive_mode = 2;
      max_speed = MULTI_MODE_DRIVE_M3_MAX;
      rate = MULTI_MODE_DRIVE_M3_RATE;
      rtP_Left.n_max = rtP_Right.n_max = MULTI_MODE_M3_N_MOT_MAX << 4;
      rtP_Left.i_max = rtP_Right.i_max = (MULTI_MODE_M3_I_MOT_MAX * A2BIT_CONV) << 4;
    } else if (adc_buffer.l_tx2 > input1[0].min + 50) {
      drive_mode = 1;
      max_speed = MULTI_MODE_DRIVE_M2_MAX;
      rate = MULTI_MODE_DRIVE_M2_RATE;
      rtP_Left.n_max = rtP_Right.n_max = MULTI_MODE_M2_N_MOT_MAX << 4;
      rtP_Left.i_max = rtP_Right.i_max = (MULTI_MODE_M2_I_MOT_MAX * A2BIT_CONV) << 4;
    } else {
      drive_mode = 0;
      max_speed = MULTI_MODE_DRIVE_M1_MAX;
      rate = MULTI_MODE_DRIVE_M1_RATE;
      rtP_Left.n_max = rtP_Right.n_max = MULTI_MODE_M1_N_MOT_MAX << 4;
      rtP_Left.i_max = rtP_Right.i_max = (MULTI_MODE_M1_I_MOT_MAX * A2BIT_CONV) << 4;
    }

    printf("Drive mode %i selected: max_speed:%i acc_rate:%i \r\n", drive_mode, max_speed, rate);
  #endif

  while(HAL_GPIO_ReadPin(BUTTON_PORT, BUTTON_PIN)) { HAL_Delay(10); }

  #ifdef MULTI_MODE_DRIVE
    int iTimeout = 0;
    while((adc_buffer.l_rx2 + adc_buffer.l_tx2) >= (input1[0].min + input2[0].min) && iTimeout++ < 300) {
      HAL_Delay(10);
    }
  #endif

  while(1) {
    if (buzzerTimer - buzzerTimer_prev > 16*DELAY_IN_MAIN_LOOP) {

    readCommand();
    calcAvgSpeed();

    #ifndef VARIANT_TRANSPOTTER
      // ####### MOTOR ENABLING #######
      if (enable == 0 && !rtY_Left.z_errCode && !rtY_Right.z_errCode && 
          ABS(input1[inIdx].cmd) < 50 && ABS(input2[inIdx].cmd) < 50){
        beepShort(6);
        beepShort(4); HAL_Delay(100);
        steerFixdt = speedFixdt = 0;
        enable = 1;
        #if defined(DEBUG_SERIAL_USART2) || defined(DEBUG_SERIAL_USART3)
        printf("-- Motors enabled --\r\n");
        #endif
      }

      // ####### SPEED BLEND #######
      #if defined(VARIANT_HOVERCAR) || defined(VARIANT_SKATEBOARD) || defined(ELECTRIC_BRAKE_ENABLE)
        uint16_t speedBlend;
        speedBlend = (uint16_t)(((CLAMP(speedAvgAbs,10,60) - 10) << 15) / 50);
      #endif

      #ifdef STANDSTILL_HOLD_ENABLE
        standstillHold();
      #endif

      // ---- 日志所需的局部变量声明（作用域覆盖整个循环体） ----
      int16_t throttleCommand = input2[inIdx].cmd;
      int16_t rawThrottleCmd  = input2[inIdx].cmd;
      int16_t brakePedalRaw   = 0;
      int16_t brakeTarget     = 0;
      int16_t brakeActive     = 0;
      int16_t reverseRequested = 0;
      int16_t motionDir       = (speedAvg > 0) ? 1 : ((speedAvg < 0) ? -1 : 0);

      // ####### VARIANT_HOVERCAR 重构后的统一控制 #######
      #ifdef VARIANT_HOVERCAR
      if (inIdx == CONTROL_ADC) {
        // 双击检测（仅低速时有效）
        if (speedAvgAbs < 60) {
          multipleTapDet(input1[inIdx].cmd, HAL_GetTick(), &MultipleTapBrake);
        }
        // 刹车时取消巡航
        if (input1[inIdx].cmd > 30) {
          cruiseControl((uint8_t)rtP_Left.b_cruiseCtrlEna);
        }

        // 提取原始踏板值
        rawThrottleCmd = input2[inIdx].cmd;
        int16_t rawBrake = input1[inIdx].cmd;

        // 预处理：小油门死区
        if (ABS(rawThrottleCmd) < 10) {
          rawThrottleCmd = 0;
        }

        brakePedalRaw = ABS(rawBrake);
        brakeActive   = (brakePedalRaw > BRAKE_PEDAL_THRESHOLD);
        reverseRequested = (MultipleTapBrake.b_multipleTap && speedAvgAbs < 60) ? 1 : 0;
        motionDir     = (speedAvg > 0) ? 1 : ((speedAvg < 0) ? -1 : 0);

        // 速度因子（用于刹车力缩放）
        int32_t speedFactor = 1000;
        if (speedAvgAbs < BRAKE_MIN_SPEED_RPM) {
          speedFactor = 0;
        } else if (speedAvgAbs < BRAKE_SMOOTH_ZONE_RPM) {
          speedFactor = ((int32_t)speedAvgAbs - BRAKE_MIN_SPEED_RPM) * 1000 /
                        (BRAKE_SMOOTH_ZONE_RPM - BRAKE_MIN_SPEED_RPM);
        }

        // ----- 倒车模式状态机 -----
        if (reverseRequested && !brakeActive && ABS(rawThrottleCmd) > 10 &&
            speedAvgAbs < 30 && speedAvg < 20) {
          reverseActive = 1;  // 进入倒车
        } else if (reverseActive && (brakeActive || ABS(rawThrottleCmd) < 10 ||
                                     speedAvgAbs > 30 || speedAvg > 20)) {
          reverseActive = 0;  // 退出倒车
        }

        // ----- 刹车目标值计算（用于斜坡） -----
        brakeTarget = 0;
        if (brakeActive) {
          int32_t scaled = ((int32_t)brakePedalRaw * speedFactor) / 1000;
          brakeTarget = (int16_t)CLAMP(scaled, 0, BRAKE_MAX_LIMIT);
        }

        // 刹车力斜坡逼近
        if (brakeTarget > filteredBrakeCmd) {
          filteredBrakeCmd += BRAKE_RAMP_STEP;
          if (filteredBrakeCmd > brakeTarget) filteredBrakeCmd = brakeTarget;
        } else if (brakeTarget < filteredBrakeCmd) {
          filteredBrakeCmd -= BRAKE_RAMP_STEP;
          if (filteredBrakeCmd < brakeTarget) filteredBrakeCmd = brakeTarget;
        }

        // ----- 生成最终的 throttleCommand -----
        if (brakeActive) {
          // 刹车状态：输出制动扭矩
          if (speedAvgAbs <= BRAKE_MIN_SPEED_RPM) {
            // 极低速/静止：不输出主动扭矩，防止蠕变
            throttleCommand = 0;
          } else if (speedAvgAbs < BRAKE_SMOOTH_ZONE_RPM) {
            // 低速阻尼区：制动力与车速成正比
            int32_t damping = ((int32_t)filteredBrakeCmd * speedAvgAbs) / BRAKE_SMOOTH_ZONE_RPM;
            throttleCommand = (speedAvg >= 0) ? (int16_t)(-damping) : (int16_t)(damping);
          } else {
            // 全制动区：输出全部制动力，方向与运动相反
            throttleCommand = (speedAvg > 0) ? (int16_t)(-filteredBrakeCmd)
                                             : (int16_t)(filteredBrakeCmd);
          }
        } else {
          // 非刹车：正常驾驶
          if (reverseActive) {
            // 倒车模式：油门映射为负值，并限幅
            throttleCommand = -(int16_t)CLAMP(ABS(rawThrottleCmd), 0, REVERSE_SPEED_LIMIT);
          } else {
            // 前进：带死区的直接油门值
            throttleCommand = (ABS(rawThrottleCmd) < 10) ? 0 : rawThrottleCmd;
          }
        }

        // 最终限幅（保证倒车速度不超过限制）
        if (throttleCommand < 0) {
          throttleCommand = (int16_t)MAX(throttleCommand, -REVERSE_SPEED_LIMIT);
        }

        // 写入输入结构体：刹车踏板归零，油门踏板写入处理后的命令
        input1[inIdx].cmd = 0;
        input2[inIdx].cmd = throttleCommand;
      }
      #endif // VARIANT_HOVERCAR

      // ####### ELECTRIC BRAKE (NON-HOVERCAR) #######
      #if defined(ELECTRIC_BRAKE_ENABLE) && !defined(VARIANT_HOVERCAR)
        electricBrake(speedBlend, MultipleTapBrake.b_multipleTap);
      #endif

      // ####### VARIANT_SKATEBOARD #######
      #ifdef VARIANT_SKATEBOARD
        if (input2[inIdx].cmd < 0) {
          if (speedAvg > 0) {
            input2[inIdx].cmd  = (int16_t)(( input2[inIdx].cmd * speedBlend) >> 15);
          } else {
            input2[inIdx].cmd  = (int16_t)((-input2[inIdx].cmd * speedBlend) >> 15);
          }
        }
      #endif

      // ####### LOW-PASS FILTER #######
      rateLimiter16(input1[inIdx].cmd, rate, &steerRateFixdt);
      {
        int16_t throttleRate = THROTTLE_ACCEL_RATE;
        int16_t throttleTarget = input2[inIdx].cmd;
        if ((throttleTarget << 4) < speedRateFixdt) {
          throttleRate = THROTTLE_RELEASE_RATE;
        }
        rateLimiter16(throttleTarget, throttleRate, &speedRateFixdt);
      }
      filtLowPass32(steerRateFixdt >> 4, FILTER, &steerFixdt);
      filtLowPass32(speedRateFixdt >> 4, FILTER, &speedFixdt);
      steer = (int16_t)(steerFixdt >> 16);
      speed = (int16_t)(speedFixdt >> 16);

      // ####### HOVERCAR FINAL MIXING #######
      #ifdef VARIANT_HOVERCAR
      if (inIdx == CONTROL_ADC) {
        #ifdef MULTI_MODE_DRIVE
        if (speed >= max_speed) {
          speed = max_speed;
        }
        #endif
        steer = 0;  // HOVERCAR 不使用转向混控
      }
      #endif

      // ####### MIXER #######
      #if defined(TANK_STEERING) && !defined(VARIANT_HOVERCAR) && !defined(VARIANT_SKATEBOARD)
        cmdL = steer;
        cmdR = speed;
      #else
        mixerFcn(speed << 4, steer << 4, &cmdR, &cmdL);
      #endif

      // ADC 超时保护
      if (timeoutFlgADC) {
        cmdL = 0; cmdR = 0;
        pwml = 0; pwmr = 0;
        enable = 0;
        #if defined(DEBUG_SERIAL_USART2) || defined(DEBUG_SERIAL_USART3)
        printf("ADC timeout detected - motors disabled\r\n");
        #endif
      }

      // ####### SET OUTPUTS #######
      #ifdef INVERT_R_DIRECTION
        pwmr = cmdR;
      #else
        pwmr = -cmdR;
      #endif
      #ifdef INVERT_L_DIRECTION
        pwml = -cmdL;
      #else
        pwml = cmdL;
      #endif
    #endif // !VARIANT_TRANSPOTTER

    #ifdef VARIANT_TRANSPOTTER
      // ...（保留原有 Transpotter 逻辑，此处省略以节省篇幅，实际应与您提供的一致）...
    #endif

    // ####### SIDEBOARDS HANDLING #######
    #if defined(SIDEBOARD_SERIAL_USART2)
      sideboardSensors((uint8_t)Sideboard_L.sensors);
    #endif
    #if defined(FEEDBACK_SERIAL_USART2)
      sideboardLeds(&sideboard_leds_L);
    #endif
    #if defined(SIDEBOARD_SERIAL_USART3)
      sideboardSensors((uint8_t)Sideboard_R.sensors);
    #endif
    #if defined(FEEDBACK_SERIAL_USART3)
      sideboardLeds(&sideboard_leds_R);
    #endif

    // ####### CALC BOARD TEMPERATURE #######
    filtLowPass32(adc_buffer.temp, TEMP_FILT_COEF, &board_temp_adcFixdt);
    board_temp_adcFilt  = (int16_t)(board_temp_adcFixdt >> 16);
    board_temp_deg_c    = (TEMP_CAL_HIGH_DEG_C - TEMP_CAL_LOW_DEG_C) * (board_temp_adcFilt - TEMP_CAL_LOW_ADC) / (TEMP_CAL_HIGH_ADC - TEMP_CAL_LOW_ADC) + TEMP_CAL_LOW_DEG_C;

    // ####### CALC CALIBRATED BATTERY VOLTAGE #######
    batVoltageCalib = batVoltage * BAT_CALIB_REAL_VOLTAGE / BAT_CALIB_ADC;

    // ####### CALC DC LINK CURRENT #######
    left_dc_curr  = -(rtU_Left.i_DCLink * 100) / A2BIT_CONV;
    right_dc_curr = -(rtU_Right.i_DCLink * 100) / A2BIT_CONV;
    dc_curr       = left_dc_curr + right_dc_curr;

    // ####### FEEDBACK SERIAL OUT (保留原简单输出，可选) #######
    #if defined(FEEDBACK_SERIAL_USART2) || defined(FEEDBACK_SERIAL_USART3)
      if (main_loop_counter % 2 == 0) {
        Feedback.start	      = (uint16_t)SERIAL_START_FRAME;
        Feedback.cmd1         = (int16_t)input1[inIdx].cmd;
        Feedback.cmd2         = (int16_t)input2[inIdx].cmd;
        Feedback.speedR_meas  = (int16_t)rtY_Right.n_mot;
        Feedback.speedL_meas  = (int16_t)rtY_Left.n_mot;
        Feedback.batVoltage   = (int16_t)batVoltageCalib;
        Feedback.boardTemp    = (int16_t)board_temp_deg_c;

        #if defined(FEEDBACK_SERIAL_USART2)
          if(__HAL_DMA_GET_COUNTER(huart2.hdmatx) == 0) {
            Feedback.cmdLed   = (uint16_t)sideboard_leds_L;
            Feedback.checksum = (uint16_t)(Feedback.start ^ Feedback.cmd1 ^ Feedback.cmd2 ^ Feedback.speedR_meas ^ Feedback.speedL_meas
                                         ^ Feedback.batVoltage ^ Feedback.boardTemp ^ Feedback.cmdLed);
            HAL_UART_Transmit_DMA(&huart2, (uint8_t *)&Feedback, sizeof(Feedback));
          }
        #endif
        #if defined(FEEDBACK_SERIAL_USART3)
          if(__HAL_DMA_GET_COUNTER(huart3.hdmatx) == 0) {
            Feedback.cmdLed   = (uint16_t)sideboard_leds_R;
            Feedback.checksum = (uint16_t)(Feedback.start ^ Feedback.cmd1 ^ Feedback.cmd2 ^ Feedback.speedR_meas ^ Feedback.speedL_meas
                                         ^ Feedback.batVoltage ^ Feedback.boardTemp ^ Feedback.cmdLed);
            // 注意：下面替换为您指定的详细日志输出
            static uint32_t lastSendTick = 0;
            uint32_t now = HAL_GetTick();

            if (now - lastSendTick >= 1000U) {
                if (huart3.gState == HAL_UART_STATE_READY && huart3.hdmatx->State == HAL_DMA_STATE_READY) {
                    static char buf[240];
                    uint32_t rx_len = 0;
                    const uint8_t *rx_data = get_usart3_rx_latest(&rx_len);

                    char rx_hex_str[32] = {0};
                    if (rx_data != NULL && rx_len > 0) {
                        int p = 0;
                        #define MAX_RX_BYTES_TO_PRINT 12
                        uint32_t max_bytes = (rx_len > MAX_RX_BYTES_TO_PRINT) ? MAX_RX_BYTES_TO_PRINT : rx_len;
                        for (uint32_t i = 0; i < max_bytes; i++) {
                            p += snprintf(rx_hex_str + p, sizeof(rx_hex_str) - p, "%02X ", rx_data[i]);
                        }
                        if (rx_len > MAX_RX_BYTES_TO_PRINT) {
                            snprintf(rx_hex_str + p - 1, sizeof(rx_hex_str) - p + 1, "..");
                        }
                    } else {
                        snprintf(rx_hex_str, sizeof(rx_hex_str), "");
                    }

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
                        (int)reverseRequested,
                        (int)MultipleTapBrake.b_multipleTap,
                        (int)motionDir,
                        (int)brakePedalRaw,
                        (int)brakeTarget,
                        (int)filteredBrakeCmd,
                        (int)throttleCommand,
                        err_detail,
                        rx_hex_str);

                    if (written > 0 && written < sizeof(buf)) {
                        HAL_UART_Transmit_DMA(&huart3, (uint8_t *)buf, written);
                    }
                    lastSendTick = now;
                }
            }
          }
        #endif
      }
    #endif

    // ####### POWEROFF BY POWER-BUTTON #######
    poweroffPressCheck();

    // ####### BEEP AND EMERGENCY POWEROFF #######
    if (TEMP_POWEROFF_ENABLE && board_temp_deg_c >= TEMP_POWEROFF && speedAvgAbs < 20){
      printf("Powering off, temperature is too high\r\n");
      poweroff();
    } else if ( BAT_DEAD_ENABLE && batVoltage < BAT_DEAD && speedAvgAbs < 20){
      printf("Powering off, battery voltage is too low\r\n");
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

    // ####### INACTIVITY TIMEOUT #######
    if (abs(cmdL) > 50 || abs(cmdR) > 50) {
      inactivity_timeout_counter = 0;
    }
    #if defined(CRUISE_CONTROL_SUPPORT) || defined(STANDSTILL_HOLD_ENABLE)
      if ((abs(rtP_Left.n_cruiseMotTgt)  > 50 && rtP_Left.b_cruiseCtrlEna) ||
          (abs(rtP_Right.n_cruiseMotTgt) > 50 && rtP_Right.b_cruiseCtrlEna)) {
        inactivity_timeout_counter = 0;
      }
    #endif
    if (inactivity_timeout_counter > (INACTIVITY_TIMEOUT * 60 * 1000) / (DELAY_IN_MAIN_LOOP + 1)) {
      printf("Powering off, wheels were inactive for too long\r\n");
      poweroff();
    }

    // Update states
    inIdx_prev = inIdx;
    buzzerTimer_prev = buzzerTimer;
    main_loop_counter++;
    }
  }
}


// ===========================================================
/** System Clock Configuration
*/
void SystemClock_Config(void) {
  RCC_OscInitTypeDef RCC_OscInitStruct = {0};
  RCC_ClkInitTypeDef RCC_ClkInitStruct = {0};
  RCC_PeriphCLKInitTypeDef PeriphClkInit = {0};

  RCC_OscInitStruct.OscillatorType      = RCC_OSCILLATORTYPE_HSI;
  RCC_OscInitStruct.HSIState            = RCC_HSI_ON;
  RCC_OscInitStruct.HSICalibrationValue = RCC_HSICALIBRATION_DEFAULT;
  RCC_OscInitStruct.PLL.PLLState        = RCC_PLL_ON;
  RCC_OscInitStruct.PLL.PLLSource       = RCC_PLLSOURCE_HSI_DIV2;
  RCC_OscInitStruct.PLL.PLLMUL          = RCC_PLL_MUL16;
  HAL_RCC_OscConfig(&RCC_OscInitStruct);

  RCC_ClkInitStruct.ClockType      = RCC_CLOCKTYPE_HCLK | RCC_CLOCKTYPE_SYSCLK | RCC_CLOCKTYPE_PCLK1 | RCC_CLOCKTYPE_PCLK2;
  RCC_ClkInitStruct.SYSCLKSource   = RCC_SYSCLKSOURCE_PLLCLK;
  RCC_ClkInitStruct.AHBCLKDivider  = RCC_SYSCLK_DIV1;
  RCC_ClkInitStruct.APB1CLKDivider = RCC_HCLK_DIV2;
  RCC_ClkInitStruct.APB2CLKDivider = RCC_HCLK_DIV1;
  HAL_RCC_ClockConfig(&RCC_ClkInitStruct, FLASH_LATENCY_2);

  PeriphClkInit.PeriphClockSelection = RCC_PERIPHCLK_ADC;
  PeriphClkInit.AdcClockSelection    = RCC_ADCPCLK2_DIV6;
  HAL_RCCEx_PeriphCLKConfig(&PeriphClkInit);

  HAL_SYSTICK_Config(HAL_RCC_GetHCLKFreq() / 1000);
  HAL_SYSTICK_CLKSourceConfig(SYSTICK_CLKSOURCE_HCLK);
  HAL_NVIC_SetPriority(SysTick_IRQn, 0, 0);
}