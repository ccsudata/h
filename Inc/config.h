#ifndef CONFIG_H
#define CONFIG_H

#include "stm32f1xx_hal.h"

#define VARIANT_HOVERCAR        1

#define PWM_FREQ            16000
#define DEAD_TIME              48
#define DELAY_IN_MAIN_LOOP    5
#define TIMEOUT                20
#define A2BIT_CONV             50

#define ADC_CONV_TIME_1C5       (14)
#define ADC_CONV_TIME_7C5       (20)
#define ADC_CONV_TIME_13C5      (26)
#define ADC_CONV_TIME_28C5      (41)
#define ADC_CONV_TIME_41C5      (54)
#define ADC_CONV_TIME_55C5      (68)
#define ADC_CONV_TIME_71C5      (84)
#define ADC_CONV_TIME_239C5     (252)

#define ADC_CONV_CLOCK_CYCLES   (ADC_CONV_TIME_7C5)
#define ADC_CLOCK_DIV           (4)
#define ADC_TOTAL_CONV_TIME     (ADC_CLOCK_DIV * ADC_CONV_CLOCK_CYCLES)

#define BOARD_VARIANT           0

#define BAT_FILT_COEF           655
#define BAT_CALIB_REAL_VOLTAGE  3970
#define BAT_CALIB_ADC           1492
#define BAT_CELLS               10
#define BAT_LVL2_ENABLE         0
#define BAT_LVL1_ENABLE         0
#define BAT_DEAD_ENABLE         0
#define BAT_BLINK_INTERVAL      80
#define BAT_LVL5                (390 * BAT_CELLS * BAT_CALIB_ADC) / BAT_CALIB_REAL_VOLTAGE
#define BAT_LVL4                (380 * BAT_CELLS * BAT_CALIB_ADC) / BAT_CALIB_REAL_VOLTAGE
#define BAT_LVL3                (370 * BAT_CELLS * BAT_CALIB_ADC) / BAT_CALIB_REAL_VOLTAGE
#define BAT_LVL2                (360 * BAT_CELLS * BAT_CALIB_ADC) / BAT_CALIB_REAL_VOLTAGE
#define BAT_LVL1                (350 * BAT_CELLS * BAT_CALIB_ADC) / BAT_CALIB_REAL_VOLTAGE
#define BAT_DEAD                (337 * BAT_CELLS * BAT_CALIB_ADC) / BAT_CALIB_REAL_VOLTAGE

#define TEMP_FILT_COEF          655
#define TEMP_CAL_LOW_ADC        1655
#define TEMP_CAL_LOW_DEG_C      358
#define TEMP_CAL_HIGH_ADC       1588
#define TEMP_CAL_HIGH_DEG_C     489
#define TEMP_WARNING_ENABLE     0
#define TEMP_WARNING            600
#define TEMP_POWEROFF_ENABLE    0
#define TEMP_POWEROFF           650

#define COM_CTRL        0
#define SIN_CTRL        1
#define FOC_CTRL        2

#define OPEN_MODE       0
#define VLT_MODE        1
#define SPD_MODE        2
#define TRQ_MODE        3

#define MOTOR_LEFT_ENA
#define MOTOR_RIGHT_ENA

#define CTRL_TYP_SEL    FOC_CTRL
#define CTRL_MOD_REQ    VLT_MODE
#define DIAG_ENA        1

#define I_MOT_MAX       15
#define I_DC_MAX        17
#define N_MOT_MAX       1000

#define FIELD_WEAK_ENA  0
#define FIELD_WEAK_MAX  5
#define PHASE_ADV_MAX   25
#define FIELD_WEAK_HI   1000
#define FIELD_WEAK_LO   750

#define INACTIVITY_TIMEOUT        88
#define BEEPS_BACKWARD            1
#define ADC_MARGIN                100
#define ADC_PROTECT_TIMEOUT       100
#define ADC_PROTECT_THRESH        200
#define AUTO_CALIBRATION_ENA

#define DEFAULT_RATE                480
#define DEFAULT_FILTER              6553
#define DEFAULT_SPEED_COEFFICIENT   16384
#define DEFAULT_STEER_COEFFICIENT   8192

#define BUZZER_ENABLED

#define FLASH_WRITE_KEY         0x1109
#define CONTROL_ADC             0
#define FEEDBACK_SERIAL_USART3
#define CONTROL_SERIAL_USART3   1

#define DUAL_INPUTS

/* PRI_INPUT1 对应油门 (l_rx2)：类型 1(单向), 最小 1088, 中位 0(忽略), 最大 3213, 死区 40 */
/* PRI_INPUT2 对应刹车 (l_tx2)：类型 1(单向), 最小 1016, 中位 0(忽略), 最大 3125, 死区 40 */
#define PRI_INPUT1              2,  800, 1080, 3200, 60 /* PRI_INPUT1 对应油门转把：类型2, 最小700, 中位1024, 最大3197, 死区50 */
#define PRI_INPUT2              2,  800, 1015, 3125, 50
#define AUX_INPUT1              2, -1000, 0, 1000, 0
#define AUX_INPUT2              2, -1000, 0, 1000, 0

#define SPEED_COEFFICIENT       16384
#define STEER_COEFFICIENT       8192

#undef MULTI_MODE_DRIVE
#define MULTI_MODE_DRIVE_M1_MAX   175
#define MULTI_MODE_DRIVE_M1_RATE  250
#define MULTI_MODE_M1_I_MOT_MAX   4
#define MULTI_MODE_M1_N_MOT_MAX   30

#define MULTI_MODE_DRIVE_M2_MAX   500
#define MULTI_MODE_DRIVE_M2_RATE  300
#define MULTI_MODE_M2_I_MOT_MAX   8
#define MULTI_MODE_M2_N_MOT_MAX   80

#define MULTI_MODE_DRIVE_M3_MAX   1000
#define MULTI_MODE_DRIVE_M3_RATE  450
#define MULTI_MODE_M3_I_MOT_MAX   I_MOT_MAX
#define MULTI_MODE_M3_N_MOT_MAX   N_MOT_MAX

#define MULTIPLE_TAP_NR           2 * 2
#define MULTIPLE_TAP_HI           600
#define MULTIPLE_TAP_LO           200
#define MULTIPLE_TAP_TIMEOUT      2000

#define SERIAL_START_FRAME      0xABCD
#define SERIAL_BUFFER_SIZE      64
#define SERIAL_TIMEOUT          210

#define USART3_BAUD             115200
#define USART3_WORDLENGTH       UART_WORDLENGTH_8B

#define RATE                    DEFAULT_RATE
#define FILTER                  DEFAULT_FILTER
#define THROTTLE_ACCEL_RATE     DEFAULT_RATE
#define THROTTLE_RELEASE_RATE   160
#define INPUTS_NR               2
#define REVERSE_SPEED_LIMIT     200
#define BRAKE_MIN_SPEED_RPM     10
#define BRAKE_SMOOTH_ZONE_RPM   150
#define BRAKE_PEDAL_THRESHOLD   45
#define BRAKE_RAMP_STEP         20
#define BRAKE_MAX_LIMIT         1000

#endif