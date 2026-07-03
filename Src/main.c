#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "stm32f1xx_hal.h"
#include "defines.h"
#include "setup.h"
#include "config.h"
#include "util.h"
#include "BLDC_controller.h"
#include "rtwtypes.h"
#include "comms.h"

void SystemClock_Config(void);

/* ------------------ 外部变量声明 (保持原样) ------------------ */
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

/* ------------------ 结构体与宏定义 (保持原样) ------------------ */
typedef struct {
    uint16_t start;
    int16_t  cmd1;
    int16_t  cmd2;
    int16_t  speedR_meas;
    int16_t  speedL_meas;
    int16_t  batVoltage;
    int16_t  boardTemp;
    uint16_t cmdLed;
    uint16_t checksum;
} SerialFeedback;
static SerialFeedback Feedback;

static sideboard_leds_R;
static int16_t speed;
static int16_t steer;
static int16_t steerRateFixdt;
static int16_t speedRateFixdt;
static int32_t steerFixdt;
static int32_t speedFixdt;
static uint32_t buzzerTimer_prev = 0;
static uint32_t inactivity_timeout_counter;
static MultipleTap MultipleTapBrake;
static uint16_t rate;

#ifndef BRAKE_PEDAL_THRESHOLD
#define BRAKE_PEDAL_THRESHOLD       45
#endif
#ifndef BRAKE_MIN_SPEED_RPM
#define BRAKE_MIN_SPEED_RPM         10
#endif
#ifndef BRAKE_SMOOTH_ZONE_RPM
#define BRAKE_SMOOTH_ZONE_RPM       150
#endif
#ifndef BRAKE_MAX_LIMIT
#define BRAKE_MAX_LIMIT             1000
#endif
#ifndef BRAKE_RAMP_STEP
#define BRAKE_RAMP_STEP             20
#endif
#ifndef REVERSE_SPEED_LIMIT
#define REVERSE_SPEED_LIMIT         200
#endif

#ifndef PEDAL_ZERO_THRESHOLD
#define PEDAL_ZERO_THRESHOLD        30
#endif
#ifndef LOW_SPEED_FOR_REVERSE
#define LOW_SPEED_FOR_REVERSE       20
#endif
#ifndef HARD_BRAKE_THRESHOLD
#define HARD_BRAKE_THRESHOLD       500
#endif

static int16_t  filteredBrakeCmd    = 0;
static uint8_t  brakeThrottleLock   = 0;
static uint8_t  reverseThrottleLock = 0;
static uint8_t  reverseActive       = 0;
static uint8_t  prevBrakePressed    = 0;
static uint32_t lastLogTick         = 0;

#define SIGN(x) (((x) > 0) ? 1 : (((x) < 0) ? -1 : 0))

/* ------------------ 重构新增：核心控制流状态变量 ------------------ */
static int16_t  rawBrake;
static int16_t  rawThrottle;
static uint8_t  brakePressed;
static int32_t  brakeTarget;
static int16_t  throttleCommand;
static int32_t  board_temp_adcFixdt;
static int16_t  board_temp_adcFilt;

/* ------------------ 重构静态模块函数声明 ------------------ */
static void Vehicle_UpdateSensors(void);
static void Vehicle_SafetyEnableCheck(void);
static void Vehicle_ManageLocksAndCruise(void);
static void Vehicle_ProcessReverseLogic(void);
static void Vehicle_CalcBrakeAndThrottle(void);
static void Vehicle_OutputMixingFilter(void);
static void Vehicle_ServiceTelemetry(void);
static void Vehicle_SafetyAndPowerManager(void);
static void Vehicle_MaintainState(void);

/* ==================================================================== */
/* MAIN 函数                              */
/* ==================================================================== */
int main(void)
{
    /* ------------------ 初始化代码 (完全保持原样) ------------------ */
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

    board_temp_adcFixdt = adc_buffer.temp << 16;
    board_temp_adcFilt  = adc_buffer.temp;

    while (HAL_GPIO_ReadPin(BUTTON_PORT, BUTTON_PIN)) { HAL_Delay(10); }

    /* ------------------ 重构后的主循环 ------------------ */
    while (1) {
        if (buzzerTimer - buzzerTimer_prev > 16 * DELAY_IN_MAIN_LOOP) {

            Vehicle_UpdateSensors();         /* 1. 数据读取与基础计算 */
            Vehicle_SafetyEnableCheck();     /* 2. 电机安全使能校验 */
            Vehicle_ManageLocksAndCruise();  /* 3. 油门锁定与巡航控制 */
            Vehicle_ProcessReverseLogic();   /* 4. 双击倒车状态机 */
            Vehicle_CalcBrakeAndThrottle();  /* 5. 刹车/油门综合命令求解 */
            Vehicle_OutputMixingFilter();    /* 6. 速率限制、低通滤波与双驱混控 */
            Vehicle_ServiceTelemetry();      /* 7. 调试日志异步串口输出 */
            Vehicle_SafetyAndPowerManager(); /* 8. 电压温度保护与报警状态机 */
            Vehicle_MaintainState();         /* 9. 状态保存与循环计数器维护 */

        }
    }
}

/* ==================================================================== */
/* 模块化函数实现                            */
/* ==================================================================== */

/**
  * @brief 读取基础指令并更新平均车速
  */
static void Vehicle_UpdateSensors(void)
{
    readCommand();
    calcAvgSpeed();

    /* 获取当前周期的原始输入 */
    rawBrake    = input1[inIdx].cmd;
    rawThrottle = input2[inIdx].cmd;
    brakePressed = (rawBrake > BRAKE_PEDAL_THRESHOLD) ? 1 : 0;
}

/**
  * @brief 校验安全条件以使能电机
  */
static void Vehicle_SafetyEnableCheck(void)
{
    if (enable == 0 && !rtY_Left.z_errCode && !rtY_Right.z_errCode &&
        ABS(input1[inIdx].cmd) < 50 && ABS(input2[inIdx].cmd) < 50) {
        beepShort(6);
        beepShort(4); 
        HAL_Delay(100);
        steerFixdt = speedFixdt = 0;
        enable = 1;
    }
}

/**
  * @brief 综合管理前进/倒车模式下的油门锁定及巡航控制
  */
static void Vehicle_ManageLocksAndCruise(void)
{
    /* 前进模式油门锁定 */
    if (!reverseActive && prevBrakePressed && !brakePressed && rawThrottle > PEDAL_ZERO_THRESHOLD) {
        brakeThrottleLock = 1;
    }
    if (brakeThrottleLock && rawThrottle < PEDAL_ZERO_THRESHOLD) {
        brakeThrottleLock = 0;
    }

    /* 倒车模式油门锁定 */
    if (reverseActive && prevBrakePressed && !brakePressed && rawThrottle > PEDAL_ZERO_THRESHOLD) {
        reverseThrottleLock = 1;
    }
    if (reverseThrottleLock && rawThrottle < PEDAL_ZERO_THRESHOLD) {
        reverseThrottleLock = 0;
    }

    /* 巡航控制状态机 */
    if (rawBrake > BRAKE_PEDAL_THRESHOLD) {
        cruiseControl(0);
    } else {
        if (inIdx == CONTROL_ADC && speedAvgAbs < 60 && rawThrottle > PEDAL_ZERO_THRESHOLD) {
            cruiseControl((uint8_t)rtP_Left.b_cruiseCtrlEna);
        }
    }
}

/**
  * @brief 处理双击检测状态机以及倒车模式切换
  */
static void Vehicle_ProcessReverseLogic(void)
{
    /* 始终使用真实的刹车值调用 multipleTapDet，保证双击只由刹车踏板自身动作触发 */
    multipleTapDet(rawBrake, HAL_GetTick(), &MultipleTapBrake);

    /* 倒车切换条件：低速、大力刹车（隐含在双击条件里）、油门松开 */
    if (MultipleTapBrake.b_multipleTap && 
        speedAvgAbs < LOW_SPEED_FOR_REVERSE && 
        rawThrottle < PEDAL_ZERO_THRESHOLD) {
        reverseActive = !reverseActive;
        reverseThrottleLock = 0;
        memset(&MultipleTapBrake, 0, sizeof(MultipleTapBrake));
    }

    /* 若条件不满足（车速过高或油门未松），则彻底清除双击状态，防止残留（防误触核心设计） */
    if (!(speedAvgAbs < LOW_SPEED_FOR_REVERSE && rawThrottle < PEDAL_ZERO_THRESHOLD)) {
        memset(&MultipleTapBrake, 0, sizeof(MultipleTapBrake));
    }
}

/**
  * @brief 计算动态刹车力与最终的油门/组合控制指令
  */
static void Vehicle_CalcBrakeAndThrottle(void)
{
    /* 计算刹车目标力 */
    int32_t speedFactor;
    if (speedAvgAbs < BRAKE_MIN_SPEED_RPM) {
        speedFactor = 0;
    } else if (speedAvgAbs < BRAKE_SMOOTH_ZONE_RPM) {
        speedFactor = (speedAvgAbs - BRAKE_MIN_SPEED_RPM) * 1000L / 
                      (BRAKE_SMOOTH_ZONE_RPM - BRAKE_MIN_SPEED_RPM);
    } else {
        speedFactor = 1000;
    }
    
    brakeTarget = (rawBrake * speedFactor) / 1000;
    if (brakeTarget < 0) brakeTarget = 0;
    if (brakeTarget > BRAKE_MAX_LIMIT) brakeTarget = BRAKE_MAX_LIMIT;

    /* 刹车力斜坡逼近 */
    if (filteredBrakeCmd < brakeTarget) {
        filteredBrakeCmd += BRAKE_RAMP_STEP;
        if (filteredBrakeCmd > brakeTarget) filteredBrakeCmd = brakeTarget;
    } else if (filteredBrakeCmd > brakeTarget) {
        filteredBrakeCmd -= BRAKE_RAMP_STEP;
        if (filteredBrakeCmd < brakeTarget) filteredBrakeCmd = brakeTarget;
    }

    /* 前进锁定缓慢释放刹车力 */
    if (brakeThrottleLock) {
        if (filteredBrakeCmd > 0) {
            filteredBrakeCmd -= BRAKE_RAMP_STEP;
            if (filteredBrakeCmd < 0) filteredBrakeCmd = 0;
        }
    }

    /* 综合油门命令计算 */
    throttleCommand = 0;

    if (brakePressed) {
        if (speedAvgAbs <= BRAKE_MIN_SPEED_RPM) {
            throttleCommand = 0;
        } else if (speedAvgAbs < BRAKE_SMOOTH_ZONE_RPM) {
            throttleCommand = (-SIGN(speedAvg) * filteredBrakeCmd * speedAvgAbs) / 
                              BRAKE_SMOOTH_ZONE_RPM;
        } else {
            throttleCommand = -SIGN(speedAvg) * filteredBrakeCmd;
        }
    } else if (brakeThrottleLock) {
        throttleCommand = 0;
    } else if (reverseActive && reverseThrottleLock) {
        throttleCommand = 0;
    } else if (reverseActive) {
        int32_t raw = rawThrottle / REVERSE_SPEED_RATIO;
        if (raw > REVERSE_SPEED_LIMIT) raw = REVERSE_SPEED_LIMIT;
        throttleCommand = -raw;
        if (throttleCommand < -REVERSE_SPEED_LIMIT) throttleCommand = -REVERSE_SPEED_LIMIT;
    } else {
        throttleCommand = rawThrottle;
    }

    /* 写入输入通道 */
    if (inIdx == CONTROL_ADC) {
        input1[inIdx].cmd = 0;
    }
    input2[inIdx].cmd = throttleCommand;
}

/**
  * @brief 运用一阶低通滤波、动态速率限制，并混控输出至 PWM 寄存器
  */
static void Vehicle_OutputMixingFilter(void)
{
    /* 命令平滑（区分加速/减速速率） */
    if (input2[inIdx].cmd < (speedRateFixdt >> 4)) {
        rate = THROTTLE_RELEASE_RATE;
    } else {
        rate = THROTTLE_ACCEL_RATE;
    }

    rateLimiter16(input1[inIdx].cmd, rate, &steerRateFixdt);
    rateLimiter16(input2[inIdx].cmd, rate, &speedRateFixdt);
    filtLowPass32(steerRateFixdt >> 4, FILTER, &steerFixdt);
    filtLowPass32(speedRateFixdt >> 4, FILTER, &speedFixdt);
    steer = (int16_t)(steerFixdt >> 16);
    speed = (int16_t)(speedFixdt >> 16);

    mixerFcn(speed << 4, steer << 4, &cmdR, &cmdL);
    pwmr = -cmdR;
    pwml =  cmdL;

    /* 侧边 LED 状态更新 */
    sideboardLeds(&sideboard_leds_R);
}

/**
  * @brief 定时构造并发送全通量调试日志 (1Hz 异步 DMA)
  */
static void Vehicle_ServiceTelemetry(void)
{
    /* 板载温度 & 电池电压定点数低通滤波与换算 */
    filtLowPass32(adc_buffer.temp, TEMP_FILT_COEF, &board_temp_adcFixdt);
    board_temp_adcFilt = (int16_t)(board_temp_adcFixdt >> 16);
    board_temp_deg_c   = (TEMP_CAL_HIGH_DEG_C - TEMP_CAL_LOW_DEG_C) * (board_temp_adcFilt - TEMP_CAL_LOW_ADC) / 
                         (TEMP_CAL_HIGH_ADC - TEMP_CAL_LOW_ADC) + TEMP_CAL_LOW_DEG_C;

    batVoltageCalib = batVoltage * BAT_CALIB_REAL_VOLTAGE / BAT_CALIB_ADC;

    left_dc_curr  = -(rtU_Left.i_DCLink * 100) / A2BIT_CONV;
    right_dc_curr = -(rtU_Right.i_DCLink * 100) / A2BIT_CONV;
    dc_curr       = left_dc_curr + right_dc_curr;

    /* 调试日志：每秒输出一次 */
    uint32_t now = HAL_GetTick();
    if (now - lastLogTick >= 1000U) {
        if (huart3.gState == HAL_UART_STATE_READY) {
            Feedback.speedL_meas = (int16_t)rtY_Left.n_mot;
            Feedback.speedR_meas = (int16_t)rtY_Right.n_mot;
            Feedback.batVoltage  = (int16_t)batVoltageCalib;
            Feedback.boardTemp   = (int16_t)board_temp_deg_c;
            Feedback.cmd1        = input1[inIdx].cmd;
            Feedback.cmd2        = input2[inIdx].cmd;

            int motionDir = (speedAvg > 0) ? 1 : ((speedAvg < 0) ? -1 : 0);

            char rx_hex_str[32] = "";
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
            }
#endif

            char err_detail[24] = "";
            if (g_ctrlErrDetail_Left != 0U || g_ctrlErrDetail_Right != 0U) {
                snprintf(err_detail, sizeof(err_detail), " errL:%02X errR:%02X",
                         (unsigned int)g_ctrlErrDetail_Left,
                         (unsigned int)g_ctrlErrDetail_Right);
            }

            static char buf[256];
            int written = snprintf(buf, sizeof(buf),
                "%lums L:%d R:%d TX2:%d RX2:%d fs:%d st:%d cL:%d cR:%d V:%d T:%d rev:%d tap:%d dir:%d br:%d bt:%d fbc:%d thr:%d rawT:%d%s [%s]\r\n",
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
                (int)rawThrottle,
                err_detail,
                rx_hex_str);

            if (written > 0 && written < sizeof(buf)) {
                HAL_UART_Transmit_DMA(&huart3, (uint8_t *)buf, written);
            }
            lastLogTick = now;
        }
    }
}

/**
  * @brief 系统层面的错误、报警、蜂鸣器音效及电源自动管理
  */
static void Vehicle_SafetyAndPowerManager(void)
{
    poweroffPressCheck();

    if (TEMP_POWEROFF_ENABLE && board_temp_deg_c >= TEMP_POWEROFF && speedAvgAbs < 20) {
        poweroff();
    } else if (BAT_DEAD_ENABLE && batVoltage < BAT_DEAD && speedAvgAbs < 20) {
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

    /* 静置无操作自动关机逻辑 */
    inactivity_timeout_counter++;
    if (abs(cmdL) > 50 || abs(cmdR) > 50) {
        inactivity_timeout_counter = 0;
    }
    if (inactivity_timeout_counter > (INACTIVITY_TIMEOUT * 60 * 1000) / (DELAY_IN_MAIN_LOOP + 1)) {
        poweroff();
    }
}

/**
  * @brief 周期末尾进行状态寄存及循环计数的维护
  */
static void Vehicle_MaintainState(void)
{
    prevBrakePressed = brakePressed;
    inIdx_prev = inIdx;
    buzzerTimer_prev = buzzerTimer;
    main_loop_counter++;
}

/* ==================================================================== */
/* 系统时钟配置 (完全保持原样)                    */
/* ==================================================================== */
void SystemClock_Config(void)
{
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