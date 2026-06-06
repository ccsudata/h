# 0 "Src/setup.c"
# 1 "/workspaces/h//"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "Src/setup.c"
# 38 "Src/setup.c"
# 1 "Inc/defines.h" 1
# 26 "Inc/defines.h"
# 1 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal.h" 1
# 48 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal.h"
# 1 "Inc/stm32f1xx_hal_conf.h" 1
# 218 "Inc/stm32f1xx_hal_conf.h"
# 1 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_rcc.h" 1
# 47 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_rcc.h"
# 1 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_def.h" 1
# 48 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_def.h"
# 1 "Drivers/CMSIS/Device/ST/STM32F1xx/Include/stm32f1xx.h" 1
# 151 "Drivers/CMSIS/Device/ST/STM32F1xx/Include/stm32f1xx.h"
# 1 "Drivers/CMSIS/Device/ST/STM32F1xx/Include/stm32f103xe.h" 1
# 87 "Drivers/CMSIS/Device/ST/STM32F1xx/Include/stm32f103xe.h"
typedef enum
{

  NonMaskableInt_IRQn = -14,
  HardFault_IRQn = -13,
  MemoryManagement_IRQn = -12,
  BusFault_IRQn = -11,
  UsageFault_IRQn = -10,
  SVCall_IRQn = -5,
  DebugMonitor_IRQn = -4,
  PendSV_IRQn = -2,
  SysTick_IRQn = -1,


  WWDG_IRQn = 0,
  PVD_IRQn = 1,
  TAMPER_IRQn = 2,
  RTC_IRQn = 3,
  FLASH_IRQn = 4,
  RCC_IRQn = 5,
  EXTI0_IRQn = 6,
  EXTI1_IRQn = 7,
  EXTI2_IRQn = 8,
  EXTI3_IRQn = 9,
  EXTI4_IRQn = 10,
  DMA1_Channel1_IRQn = 11,
  DMA1_Channel2_IRQn = 12,
  DMA1_Channel3_IRQn = 13,
  DMA1_Channel4_IRQn = 14,
  DMA1_Channel5_IRQn = 15,
  DMA1_Channel6_IRQn = 16,
  DMA1_Channel7_IRQn = 17,
  ADC1_2_IRQn = 18,
  USB_HP_CAN1_TX_IRQn = 19,
  USB_LP_CAN1_RX0_IRQn = 20,
  CAN1_RX1_IRQn = 21,
  CAN1_SCE_IRQn = 22,
  EXTI9_5_IRQn = 23,
  TIM1_BRK_IRQn = 24,
  TIM1_UP_IRQn = 25,
  TIM1_TRG_COM_IRQn = 26,
  TIM1_CC_IRQn = 27,
  TIM2_IRQn = 28,
  TIM3_IRQn = 29,
  TIM4_IRQn = 30,
  I2C1_EV_IRQn = 31,
  I2C1_ER_IRQn = 32,
  I2C2_EV_IRQn = 33,
  I2C2_ER_IRQn = 34,
  SPI1_IRQn = 35,
  SPI2_IRQn = 36,
  USART1_IRQn = 37,
  USART2_IRQn = 38,
  USART3_IRQn = 39,
  EXTI15_10_IRQn = 40,
  RTC_Alarm_IRQn = 41,
  USBWakeUp_IRQn = 42,
  TIM8_BRK_IRQn = 43,
  TIM8_UP_IRQn = 44,
  TIM8_TRG_COM_IRQn = 45,
  TIM8_CC_IRQn = 46,
  ADC3_IRQn = 47,
  FSMC_IRQn = 48,
  SDIO_IRQn = 49,
  TIM5_IRQn = 50,
  SPI3_IRQn = 51,
  UART4_IRQn = 52,
  UART5_IRQn = 53,
  TIM6_IRQn = 54,
  TIM7_IRQn = 55,
  DMA2_Channel1_IRQn = 56,
  DMA2_Channel2_IRQn = 57,
  DMA2_Channel3_IRQn = 58,
  DMA2_Channel4_5_IRQn = 59,
} IRQn_Type;





# 1 "Drivers/CMSIS/Include/core_cm3.h" 1
# 44 "Drivers/CMSIS/Include/core_cm3.h"
# 1 "/usr/lib/gcc/arm-none-eabi/13.2.1/include/stdint.h" 1 3 4
# 34 "/usr/lib/gcc/arm-none-eabi/13.2.1/include/stdint.h" 3 4

# 34 "/usr/lib/gcc/arm-none-eabi/13.2.1/include/stdint.h" 3 4
typedef signed char int8_t;


typedef short int int16_t;


typedef long int int32_t;


typedef long long int int64_t;


typedef unsigned char uint8_t;


typedef short unsigned int uint16_t;


typedef long unsigned int uint32_t;


typedef long long unsigned int uint64_t;




typedef signed char int_least8_t;
typedef short int int_least16_t;
typedef long int int_least32_t;
typedef long long int int_least64_t;
typedef unsigned char uint_least8_t;
typedef short unsigned int uint_least16_t;
typedef long unsigned int uint_least32_t;
typedef long long unsigned int uint_least64_t;



typedef int int_fast8_t;
typedef int int_fast16_t;
typedef int int_fast32_t;
typedef long long int int_fast64_t;
typedef unsigned int uint_fast8_t;
typedef unsigned int uint_fast16_t;
typedef unsigned int uint_fast32_t;
typedef long long unsigned int uint_fast64_t;




typedef int intptr_t;


typedef unsigned int uintptr_t;




typedef long long int intmax_t;
typedef long long unsigned int uintmax_t;
# 45 "Drivers/CMSIS/Include/core_cm3.h" 2
# 163 "Drivers/CMSIS/Include/core_cm3.h"
# 1 "Drivers/CMSIS/Include/core_cmInstr.h" 1
# 61 "Drivers/CMSIS/Include/core_cmInstr.h"
# 1 "Drivers/CMSIS/Include/cmsis_gcc.h" 1
# 40 "Drivers/CMSIS/Include/cmsis_gcc.h"
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wsign-conversion"
#pragma GCC diagnostic ignored "-Wconversion"
#pragma GCC diagnostic ignored "-Wunused-parameter"
# 58 "Drivers/CMSIS/Include/cmsis_gcc.h"
__attribute__( ( always_inline ) ) static inline void __enable_irq(void)
{
  __asm volatile ("cpsie i" : : : "memory");
}







__attribute__( ( always_inline ) ) static inline void __disable_irq(void)
{
  __asm volatile ("cpsid i" : : : "memory");
}







__attribute__( ( always_inline ) ) static inline uint32_t __get_CONTROL(void)
{
  uint32_t result;

  __asm volatile ("MRS %0, control" : "=r" (result) );
  return(result);
}







__attribute__( ( always_inline ) ) static inline void __set_CONTROL(uint32_t control)
{
  __asm volatile ("MSR control, %0" : : "r" (control) : "memory");
}







__attribute__( ( always_inline ) ) static inline uint32_t __get_IPSR(void)
{
  uint32_t result;

  __asm volatile ("MRS %0, ipsr" : "=r" (result) );
  return(result);
}







__attribute__( ( always_inline ) ) static inline uint32_t __get_APSR(void)
{
  uint32_t result;

  __asm volatile ("MRS %0, apsr" : "=r" (result) );
  return(result);
}
# 134 "Drivers/CMSIS/Include/cmsis_gcc.h"
__attribute__( ( always_inline ) ) static inline uint32_t __get_xPSR(void)
{
  uint32_t result;

  __asm volatile ("MRS %0, xpsr" : "=r" (result) );
  return(result);
}







__attribute__( ( always_inline ) ) static inline uint32_t __get_PSP(void)
{
  register uint32_t result;

  __asm volatile ("MRS %0, psp\n" : "=r" (result) );
  return(result);
}







__attribute__( ( always_inline ) ) static inline void __set_PSP(uint32_t topOfProcStack)
{
  __asm volatile ("MSR psp, %0\n" : : "r" (topOfProcStack) : "sp");
}







__attribute__( ( always_inline ) ) static inline uint32_t __get_MSP(void)
{
  register uint32_t result;

  __asm volatile ("MRS %0, msp\n" : "=r" (result) );
  return(result);
}
# 188 "Drivers/CMSIS/Include/cmsis_gcc.h"
__attribute__( ( always_inline ) ) static inline void __set_MSP(uint32_t topOfMainStack)
{
  __asm volatile ("MSR msp, %0\n" : : "r" (topOfMainStack) : "sp");
}







__attribute__( ( always_inline ) ) static inline uint32_t __get_PRIMASK(void)
{
  uint32_t result;

  __asm volatile ("MRS %0, primask" : "=r" (result) );
  return(result);
}







__attribute__( ( always_inline ) ) static inline void __set_PRIMASK(uint32_t priMask)
{
  __asm volatile ("MSR primask, %0" : : "r" (priMask) : "memory");
}
# 226 "Drivers/CMSIS/Include/cmsis_gcc.h"
__attribute__( ( always_inline ) ) static inline void __enable_fault_irq(void)
{
  __asm volatile ("cpsie f" : : : "memory");
}







__attribute__( ( always_inline ) ) static inline void __disable_fault_irq(void)
{
  __asm volatile ("cpsid f" : : : "memory");
}







__attribute__( ( always_inline ) ) static inline uint32_t __get_BASEPRI(void)
{
  uint32_t result;

  __asm volatile ("MRS %0, basepri" : "=r" (result) );
  return(result);
}







__attribute__( ( always_inline ) ) static inline void __set_BASEPRI(uint32_t value)
{
  __asm volatile ("MSR basepri, %0" : : "r" (value) : "memory");
}
# 274 "Drivers/CMSIS/Include/cmsis_gcc.h"
__attribute__( ( always_inline ) ) static inline void __set_BASEPRI_MAX(uint32_t value)
{
  __asm volatile ("MSR basepri_max, %0" : : "r" (value) : "memory");
}







__attribute__( ( always_inline ) ) static inline uint32_t __get_FAULTMASK(void)
{
  uint32_t result;

  __asm volatile ("MRS %0, faultmask" : "=r" (result) );
  return(result);
}







__attribute__( ( always_inline ) ) static inline void __set_FAULTMASK(uint32_t faultMask)
{
  __asm volatile ("MSR faultmask, %0" : : "r" (faultMask) : "memory");
}
# 373 "Drivers/CMSIS/Include/cmsis_gcc.h"
__attribute__((always_inline)) static inline void __NOP(void)
{
  __asm volatile ("nop");
}






__attribute__((always_inline)) static inline void __WFI(void)
{
  __asm volatile ("wfi");
}







__attribute__((always_inline)) static inline void __WFE(void)
{
  __asm volatile ("wfe");
}






__attribute__((always_inline)) static inline void __SEV(void)
{
  __asm volatile ("sev");
}
# 416 "Drivers/CMSIS/Include/cmsis_gcc.h"
__attribute__((always_inline)) static inline void __ISB(void)
{
  __asm volatile ("isb 0xF":::"memory");
}







__attribute__((always_inline)) static inline void __DSB(void)
{
  __asm volatile ("dsb 0xF":::"memory");
}







__attribute__((always_inline)) static inline void __DMB(void)
{
  __asm volatile ("dmb 0xF":::"memory");
}
# 450 "Drivers/CMSIS/Include/cmsis_gcc.h"
__attribute__((always_inline)) static inline uint32_t __REV(uint32_t value)
{

  return __builtin_bswap32(value);






}
# 469 "Drivers/CMSIS/Include/cmsis_gcc.h"
__attribute__((always_inline)) static inline uint32_t __REV16(uint32_t value)
{
  uint32_t result;

  __asm volatile ("rev16 %0, %1" : "=r" (result) : "r" (value) );
  return(result);
}
# 484 "Drivers/CMSIS/Include/cmsis_gcc.h"
__attribute__((always_inline)) static inline int32_t __REVSH(int32_t value)
{

  return (short)__builtin_bswap16(value);






}
# 504 "Drivers/CMSIS/Include/cmsis_gcc.h"
__attribute__((always_inline)) static inline uint32_t __ROR(uint32_t op1, uint32_t op2)
{
  return (op1 >> op2) | (op1 << (32U - op2));
}
# 526 "Drivers/CMSIS/Include/cmsis_gcc.h"
__attribute__((always_inline)) static inline uint32_t __RBIT(uint32_t value)
{
  uint32_t result;


   __asm volatile ("rbit %0, %1" : "=r" (result) : "r" (value) );
# 544 "Drivers/CMSIS/Include/cmsis_gcc.h"
  return(result);
}
# 565 "Drivers/CMSIS/Include/cmsis_gcc.h"
__attribute__((always_inline)) static inline uint8_t __LDREXB(volatile uint8_t *addr)
{
    uint32_t result;


   __asm volatile ("ldrexb %0, %1" : "=r" (result) : "Q" (*addr) );






   return ((uint8_t) result);
}
# 587 "Drivers/CMSIS/Include/cmsis_gcc.h"
__attribute__((always_inline)) static inline uint16_t __LDREXH(volatile uint16_t *addr)
{
    uint32_t result;


   __asm volatile ("ldrexh %0, %1" : "=r" (result) : "Q" (*addr) );






   return ((uint16_t) result);
}
# 609 "Drivers/CMSIS/Include/cmsis_gcc.h"
__attribute__((always_inline)) static inline uint32_t __LDREXW(volatile uint32_t *addr)
{
    uint32_t result;

   __asm volatile ("ldrex %0, %1" : "=r" (result) : "Q" (*addr) );
   return(result);
}
# 626 "Drivers/CMSIS/Include/cmsis_gcc.h"
__attribute__((always_inline)) static inline uint32_t __STREXB(uint8_t value, volatile uint8_t *addr)
{
   uint32_t result;

   __asm volatile ("strexb %0, %2, %1" : "=&r" (result), "=Q" (*addr) : "r" ((uint32_t)value) );
   return(result);
}
# 643 "Drivers/CMSIS/Include/cmsis_gcc.h"
__attribute__((always_inline)) static inline uint32_t __STREXH(uint16_t value, volatile uint16_t *addr)
{
   uint32_t result;

   __asm volatile ("strexh %0, %2, %1" : "=&r" (result), "=Q" (*addr) : "r" ((uint32_t)value) );
   return(result);
}
# 660 "Drivers/CMSIS/Include/cmsis_gcc.h"
__attribute__((always_inline)) static inline uint32_t __STREXW(uint32_t value, volatile uint32_t *addr)
{
   uint32_t result;

   __asm volatile ("strex %0, %2, %1" : "=&r" (result), "=Q" (*addr) : "r" (value) );
   return(result);
}






__attribute__((always_inline)) static inline void __CLREX(void)
{
  __asm volatile ("clrex" ::: "memory");
}
# 716 "Drivers/CMSIS/Include/cmsis_gcc.h"
__attribute__((always_inline)) static inline uint32_t __RRX(uint32_t value)
{
  uint32_t result;

  __asm volatile ("rrx %0, %1" : "=r" (result) : "r" (value) );
  return(result);
}
# 731 "Drivers/CMSIS/Include/cmsis_gcc.h"
__attribute__((always_inline)) static inline uint8_t __LDRBT(volatile uint8_t *addr)
{
    uint32_t result;


   __asm volatile ("ldrbt %0, %1" : "=r" (result) : "Q" (*addr) );






   return ((uint8_t) result);
}
# 753 "Drivers/CMSIS/Include/cmsis_gcc.h"
__attribute__((always_inline)) static inline uint16_t __LDRHT(volatile uint16_t *addr)
{
    uint32_t result;


   __asm volatile ("ldrht %0, %1" : "=r" (result) : "Q" (*addr) );






   return ((uint16_t) result);
}
# 775 "Drivers/CMSIS/Include/cmsis_gcc.h"
__attribute__((always_inline)) static inline uint32_t __LDRT(volatile uint32_t *addr)
{
    uint32_t result;

   __asm volatile ("ldrt %0, %1" : "=r" (result) : "Q" (*addr) );
   return(result);
}
# 790 "Drivers/CMSIS/Include/cmsis_gcc.h"
__attribute__((always_inline)) static inline void __STRBT(uint8_t value, volatile uint8_t *addr)
{
   __asm volatile ("strbt %1, %0" : "=Q" (*addr) : "r" ((uint32_t)value) );
}
# 802 "Drivers/CMSIS/Include/cmsis_gcc.h"
__attribute__((always_inline)) static inline void __STRHT(uint16_t value, volatile uint16_t *addr)
{
   __asm volatile ("strht %1, %0" : "=Q" (*addr) : "r" ((uint32_t)value) );
}
# 814 "Drivers/CMSIS/Include/cmsis_gcc.h"
__attribute__((always_inline)) static inline void __STRT(uint32_t value, volatile uint32_t *addr)
{
   __asm volatile ("strt %1, %0" : "=Q" (*addr) : "r" (value) );
}
# 1370 "Drivers/CMSIS/Include/cmsis_gcc.h"
#pragma GCC diagnostic pop
# 62 "Drivers/CMSIS/Include/core_cmInstr.h" 2
# 164 "Drivers/CMSIS/Include/core_cm3.h" 2
# 1 "Drivers/CMSIS/Include/core_cmFunc.h" 1
# 165 "Drivers/CMSIS/Include/core_cm3.h" 2
# 254 "Drivers/CMSIS/Include/core_cm3.h"
typedef union
{
  struct
  {
    uint32_t _reserved0:27;
    uint32_t Q:1;
    uint32_t V:1;
    uint32_t C:1;
    uint32_t Z:1;
    uint32_t N:1;
  } b;
  uint32_t w;
} APSR_Type;
# 288 "Drivers/CMSIS/Include/core_cm3.h"
typedef union
{
  struct
  {
    uint32_t ISR:9;
    uint32_t _reserved0:23;
  } b;
  uint32_t w;
} IPSR_Type;
# 306 "Drivers/CMSIS/Include/core_cm3.h"
typedef union
{
  struct
  {
    uint32_t ISR:9;
    uint32_t _reserved0:15;
    uint32_t T:1;
    uint32_t IT:2;
    uint32_t Q:1;
    uint32_t V:1;
    uint32_t C:1;
    uint32_t Z:1;
    uint32_t N:1;
  } b;
  uint32_t w;
} xPSR_Type;
# 352 "Drivers/CMSIS/Include/core_cm3.h"
typedef union
{
  struct
  {
    uint32_t nPRIV:1;
    uint32_t SPSEL:1;
    uint32_t _reserved1:30;
  } b;
  uint32_t w;
} CONTROL_Type;
# 383 "Drivers/CMSIS/Include/core_cm3.h"
typedef struct
{
  volatile uint32_t ISER[8U];
        uint32_t RESERVED0[24U];
  volatile uint32_t ICER[8U];
        uint32_t RSERVED1[24U];
  volatile uint32_t ISPR[8U];
        uint32_t RESERVED2[24U];
  volatile uint32_t ICPR[8U];
        uint32_t RESERVED3[24U];
  volatile uint32_t IABR[8U];
        uint32_t RESERVED4[56U];
  volatile uint8_t IP[240U];
        uint32_t RESERVED5[644U];
  volatile uint32_t STIR;
} NVIC_Type;
# 417 "Drivers/CMSIS/Include/core_cm3.h"
typedef struct
{
  volatile const uint32_t CPUID;
  volatile uint32_t ICSR;
  volatile uint32_t VTOR;
  volatile uint32_t AIRCR;
  volatile uint32_t SCR;
  volatile uint32_t CCR;
  volatile uint8_t SHP[12U];
  volatile uint32_t SHCSR;
  volatile uint32_t CFSR;
  volatile uint32_t HFSR;
  volatile uint32_t DFSR;
  volatile uint32_t MMFAR;
  volatile uint32_t BFAR;
  volatile uint32_t AFSR;
  volatile const uint32_t PFR[2U];
  volatile const uint32_t DFR;
  volatile const uint32_t ADR;
  volatile const uint32_t MMFR[4U];
  volatile const uint32_t ISAR[5U];
        uint32_t RESERVED0[5U];
  volatile uint32_t CPACR;
} SCB_Type;
# 644 "Drivers/CMSIS/Include/core_cm3.h"
typedef struct
{
        uint32_t RESERVED0[1U];
  volatile const uint32_t ICTR;

  volatile uint32_t ACTLR;



} SCnSCB_Type;
# 683 "Drivers/CMSIS/Include/core_cm3.h"
typedef struct
{
  volatile uint32_t CTRL;
  volatile uint32_t LOAD;
  volatile uint32_t VAL;
  volatile const uint32_t CALIB;
} SysTick_Type;
# 735 "Drivers/CMSIS/Include/core_cm3.h"
typedef struct
{
  volatile union
  {
    volatile uint8_t u8;
    volatile uint16_t u16;
    volatile uint32_t u32;
  } PORT [32U];
        uint32_t RESERVED0[864U];
  volatile uint32_t TER;
        uint32_t RESERVED1[15U];
  volatile uint32_t TPR;
        uint32_t RESERVED2[15U];
  volatile uint32_t TCR;
        uint32_t RESERVED3[29U];
  volatile uint32_t IWR;
  volatile const uint32_t IRR;
  volatile uint32_t IMCR;
        uint32_t RESERVED4[43U];
  volatile uint32_t LAR;
  volatile const uint32_t LSR;
        uint32_t RESERVED5[6U];
  volatile const uint32_t PID4;
  volatile const uint32_t PID5;
  volatile const uint32_t PID6;
  volatile const uint32_t PID7;
  volatile const uint32_t PID0;
  volatile const uint32_t PID1;
  volatile const uint32_t PID2;
  volatile const uint32_t PID3;
  volatile const uint32_t CID0;
  volatile const uint32_t CID1;
  volatile const uint32_t CID2;
  volatile const uint32_t CID3;
} ITM_Type;
# 838 "Drivers/CMSIS/Include/core_cm3.h"
typedef struct
{
  volatile uint32_t CTRL;
  volatile uint32_t CYCCNT;
  volatile uint32_t CPICNT;
  volatile uint32_t EXCCNT;
  volatile uint32_t SLEEPCNT;
  volatile uint32_t LSUCNT;
  volatile uint32_t FOLDCNT;
  volatile const uint32_t PCSR;
  volatile uint32_t COMP0;
  volatile uint32_t MASK0;
  volatile uint32_t FUNCTION0;
        uint32_t RESERVED0[1U];
  volatile uint32_t COMP1;
  volatile uint32_t MASK1;
  volatile uint32_t FUNCTION1;
        uint32_t RESERVED1[1U];
  volatile uint32_t COMP2;
  volatile uint32_t MASK2;
  volatile uint32_t FUNCTION2;
        uint32_t RESERVED2[1U];
  volatile uint32_t COMP3;
  volatile uint32_t MASK3;
  volatile uint32_t FUNCTION3;
} DWT_Type;
# 985 "Drivers/CMSIS/Include/core_cm3.h"
typedef struct
{
  volatile uint32_t SSPSR;
  volatile uint32_t CSPSR;
        uint32_t RESERVED0[2U];
  volatile uint32_t ACPR;
        uint32_t RESERVED1[55U];
  volatile uint32_t SPPR;
        uint32_t RESERVED2[131U];
  volatile const uint32_t FFSR;
  volatile uint32_t FFCR;
  volatile const uint32_t FSCR;
        uint32_t RESERVED3[759U];
  volatile const uint32_t TRIGGER;
  volatile const uint32_t FIFO0;
  volatile const uint32_t ITATBCTR2;
        uint32_t RESERVED4[1U];
  volatile const uint32_t ITATBCTR0;
  volatile const uint32_t FIFO1;
  volatile uint32_t ITCTRL;
        uint32_t RESERVED5[39U];
  volatile uint32_t CLAIMSET;
  volatile uint32_t CLAIMCLR;
        uint32_t RESERVED7[8U];
  volatile const uint32_t DEVID;
  volatile const uint32_t DEVTYPE;
} TPI_Type;
# 1235 "Drivers/CMSIS/Include/core_cm3.h"
typedef struct
{
  volatile uint32_t DHCSR;
  volatile uint32_t DCRSR;
  volatile uint32_t DCRDR;
  volatile uint32_t DEMCR;
} CoreDebug_Type;
# 1422 "Drivers/CMSIS/Include/core_cm3.h"
static inline void NVIC_SetPriorityGrouping(uint32_t PriorityGroup)
{
  uint32_t reg_value;
  uint32_t PriorityGroupTmp = (PriorityGroup & (uint32_t)0x07UL);

  reg_value = ((SCB_Type *) ((0xE000E000UL) + 0x0D00UL) )->AIRCR;
  reg_value &= ~((uint32_t)((0xFFFFUL << 16U) | (7UL << 8U)));
  reg_value = (reg_value |
                ((uint32_t)0x5FAUL << 16U) |
                (PriorityGroupTmp << 8U) );
  ((SCB_Type *) ((0xE000E000UL) + 0x0D00UL) )->AIRCR = reg_value;
}







static inline uint32_t NVIC_GetPriorityGrouping(void)
{
  return ((uint32_t)((((SCB_Type *) ((0xE000E000UL) + 0x0D00UL) )->AIRCR & (7UL << 8U)) >> 8U));
}







static inline void NVIC_EnableIRQ(IRQn_Type IRQn)
{
  ((NVIC_Type *) ((0xE000E000UL) + 0x0100UL) )->ISER[(((uint32_t)(int32_t)IRQn) >> 5UL)] = (uint32_t)(1UL << (((uint32_t)(int32_t)IRQn) & 0x1FUL));
}







static inline void NVIC_DisableIRQ(IRQn_Type IRQn)
{
  ((NVIC_Type *) ((0xE000E000UL) + 0x0100UL) )->ICER[(((uint32_t)(int32_t)IRQn) >> 5UL)] = (uint32_t)(1UL << (((uint32_t)(int32_t)IRQn) & 0x1FUL));
}
# 1476 "Drivers/CMSIS/Include/core_cm3.h"
static inline uint32_t NVIC_GetPendingIRQ(IRQn_Type IRQn)
{
  return((uint32_t)(((((NVIC_Type *) ((0xE000E000UL) + 0x0100UL) )->ISPR[(((uint32_t)(int32_t)IRQn) >> 5UL)] & (1UL << (((uint32_t)(int32_t)IRQn) & 0x1FUL))) != 0UL) ? 1UL : 0UL));
}







static inline void NVIC_SetPendingIRQ(IRQn_Type IRQn)
{
  ((NVIC_Type *) ((0xE000E000UL) + 0x0100UL) )->ISPR[(((uint32_t)(int32_t)IRQn) >> 5UL)] = (uint32_t)(1UL << (((uint32_t)(int32_t)IRQn) & 0x1FUL));
}







static inline void NVIC_ClearPendingIRQ(IRQn_Type IRQn)
{
  ((NVIC_Type *) ((0xE000E000UL) + 0x0100UL) )->ICPR[(((uint32_t)(int32_t)IRQn) >> 5UL)] = (uint32_t)(1UL << (((uint32_t)(int32_t)IRQn) & 0x1FUL));
}
# 1511 "Drivers/CMSIS/Include/core_cm3.h"
static inline uint32_t NVIC_GetActive(IRQn_Type IRQn)
{
  return((uint32_t)(((((NVIC_Type *) ((0xE000E000UL) + 0x0100UL) )->IABR[(((uint32_t)(int32_t)IRQn) >> 5UL)] & (1UL << (((uint32_t)(int32_t)IRQn) & 0x1FUL))) != 0UL) ? 1UL : 0UL));
}
# 1524 "Drivers/CMSIS/Include/core_cm3.h"
static inline void NVIC_SetPriority(IRQn_Type IRQn, uint32_t priority)
{
  if ((int32_t)(IRQn) < 0)
  {
    ((SCB_Type *) ((0xE000E000UL) + 0x0D00UL) )->SHP[(((uint32_t)(int32_t)IRQn) & 0xFUL)-4UL] = (uint8_t)((priority << (8U - 4U)) & (uint32_t)0xFFUL);
  }
  else
  {
    ((NVIC_Type *) ((0xE000E000UL) + 0x0100UL) )->IP[((uint32_t)(int32_t)IRQn)] = (uint8_t)((priority << (8U - 4U)) & (uint32_t)0xFFUL);
  }
}
# 1546 "Drivers/CMSIS/Include/core_cm3.h"
static inline uint32_t NVIC_GetPriority(IRQn_Type IRQn)
{

  if ((int32_t)(IRQn) < 0)
  {
    return(((uint32_t)((SCB_Type *) ((0xE000E000UL) + 0x0D00UL) )->SHP[(((uint32_t)(int32_t)IRQn) & 0xFUL)-4UL] >> (8U - 4U)));
  }
  else
  {
    return(((uint32_t)((NVIC_Type *) ((0xE000E000UL) + 0x0100UL) )->IP[((uint32_t)(int32_t)IRQn)] >> (8U - 4U)));
  }
}
# 1571 "Drivers/CMSIS/Include/core_cm3.h"
static inline uint32_t NVIC_EncodePriority (uint32_t PriorityGroup, uint32_t PreemptPriority, uint32_t SubPriority)
{
  uint32_t PriorityGroupTmp = (PriorityGroup & (uint32_t)0x07UL);
  uint32_t PreemptPriorityBits;
  uint32_t SubPriorityBits;

  PreemptPriorityBits = ((7UL - PriorityGroupTmp) > (uint32_t)(4U)) ? (uint32_t)(4U) : (uint32_t)(7UL - PriorityGroupTmp);
  SubPriorityBits = ((PriorityGroupTmp + (uint32_t)(4U)) < (uint32_t)7UL) ? (uint32_t)0UL : (uint32_t)((PriorityGroupTmp - 7UL) + (uint32_t)(4U));

  return (
           ((PreemptPriority & (uint32_t)((1UL << (PreemptPriorityBits)) - 1UL)) << SubPriorityBits) |
           ((SubPriority & (uint32_t)((1UL << (SubPriorityBits )) - 1UL)))
         );
}
# 1598 "Drivers/CMSIS/Include/core_cm3.h"
static inline void NVIC_DecodePriority (uint32_t Priority, uint32_t PriorityGroup, uint32_t* const pPreemptPriority, uint32_t* const pSubPriority)
{
  uint32_t PriorityGroupTmp = (PriorityGroup & (uint32_t)0x07UL);
  uint32_t PreemptPriorityBits;
  uint32_t SubPriorityBits;

  PreemptPriorityBits = ((7UL - PriorityGroupTmp) > (uint32_t)(4U)) ? (uint32_t)(4U) : (uint32_t)(7UL - PriorityGroupTmp);
  SubPriorityBits = ((PriorityGroupTmp + (uint32_t)(4U)) < (uint32_t)7UL) ? (uint32_t)0UL : (uint32_t)((PriorityGroupTmp - 7UL) + (uint32_t)(4U));

  *pPreemptPriority = (Priority >> SubPriorityBits) & (uint32_t)((1UL << (PreemptPriorityBits)) - 1UL);
  *pSubPriority = (Priority ) & (uint32_t)((1UL << (SubPriorityBits )) - 1UL);
}






static inline void NVIC_SystemReset(void)
{
  __DSB();

  ((SCB_Type *) ((0xE000E000UL) + 0x0D00UL) )->AIRCR = (uint32_t)((0x5FAUL << 16U) |
                           (((SCB_Type *) ((0xE000E000UL) + 0x0D00UL) )->AIRCR & (7UL << 8U)) |
                            (1UL << 2U) );
  __DSB();

  for(;;)
  {
    __NOP();
  }
}
# 1656 "Drivers/CMSIS/Include/core_cm3.h"
static inline uint32_t SysTick_Config(uint32_t ticks)
{
  if ((ticks - 1UL) > (0xFFFFFFUL ))
  {
    return (1UL);
  }

  ((SysTick_Type *) ((0xE000E000UL) + 0x0010UL) )->LOAD = (uint32_t)(ticks - 1UL);
  NVIC_SetPriority (SysTick_IRQn, (1UL << 4U) - 1UL);
  ((SysTick_Type *) ((0xE000E000UL) + 0x0010UL) )->VAL = 0UL;
  ((SysTick_Type *) ((0xE000E000UL) + 0x0010UL) )->CTRL = (1UL << 2U) |
                   (1UL << 1U) |
                   (1UL );
  return (0UL);
}
# 1686 "Drivers/CMSIS/Include/core_cm3.h"
extern volatile int32_t ITM_RxBuffer;
# 1698 "Drivers/CMSIS/Include/core_cm3.h"
static inline uint32_t ITM_SendChar (uint32_t ch)
{
  if (((((ITM_Type *) (0xE0000000UL) )->TCR & (1UL )) != 0UL) &&
      ((((ITM_Type *) (0xE0000000UL) )->TER & 1UL ) != 0UL) )
  {
    while (((ITM_Type *) (0xE0000000UL) )->PORT[0U].u32 == 0UL)
    {
      __NOP();
    }
    ((ITM_Type *) (0xE0000000UL) )->PORT[0U].u8 = (uint8_t)ch;
  }
  return (ch);
}
# 1719 "Drivers/CMSIS/Include/core_cm3.h"
static inline int32_t ITM_ReceiveChar (void)
{
  int32_t ch = -1;

  if (ITM_RxBuffer != 0x5AA55AA5U)
  {
    ch = ITM_RxBuffer;
    ITM_RxBuffer = 0x5AA55AA5U;
  }

  return (ch);
}
# 1739 "Drivers/CMSIS/Include/core_cm3.h"
static inline int32_t ITM_CheckChar (void)
{

  if (ITM_RxBuffer == 0x5AA55AA5U)
  {
    return (0);
  }
  else
  {
    return (1);
  }
}
# 168 "Drivers/CMSIS/Device/ST/STM32F1xx/Include/stm32f103xe.h" 2
# 1 "Drivers/CMSIS/Device/ST/STM32F1xx/Include/system_stm32f1xx.h" 1
# 69 "Drivers/CMSIS/Device/ST/STM32F1xx/Include/system_stm32f1xx.h"
extern uint32_t SystemCoreClock;
extern const uint8_t AHBPrescTable[16U];
extern const uint8_t APBPrescTable[8U];
# 97 "Drivers/CMSIS/Device/ST/STM32F1xx/Include/system_stm32f1xx.h"
extern void SystemInit(void);
extern void SystemCoreClockUpdate(void);
# 169 "Drivers/CMSIS/Device/ST/STM32F1xx/Include/stm32f103xe.h" 2
# 179 "Drivers/CMSIS/Device/ST/STM32F1xx/Include/stm32f103xe.h"
typedef struct
{
  volatile uint32_t SR;
  volatile uint32_t CR1;
  volatile uint32_t CR2;
  volatile uint32_t SMPR1;
  volatile uint32_t SMPR2;
  volatile uint32_t JOFR1;
  volatile uint32_t JOFR2;
  volatile uint32_t JOFR3;
  volatile uint32_t JOFR4;
  volatile uint32_t HTR;
  volatile uint32_t LTR;
  volatile uint32_t SQR1;
  volatile uint32_t SQR2;
  volatile uint32_t SQR3;
  volatile uint32_t JSQR;
  volatile uint32_t JDR1;
  volatile uint32_t JDR2;
  volatile uint32_t JDR3;
  volatile uint32_t JDR4;
  volatile uint32_t DR;
} ADC_TypeDef;

typedef struct
{
  volatile uint32_t SR;
  volatile uint32_t CR1;
  volatile uint32_t CR2;
  uint32_t RESERVED[16];
  volatile uint32_t DR;
} ADC_Common_TypeDef;





typedef struct
{
  uint32_t RESERVED0;
  volatile uint32_t DR1;
  volatile uint32_t DR2;
  volatile uint32_t DR3;
  volatile uint32_t DR4;
  volatile uint32_t DR5;
  volatile uint32_t DR6;
  volatile uint32_t DR7;
  volatile uint32_t DR8;
  volatile uint32_t DR9;
  volatile uint32_t DR10;
  volatile uint32_t RTCCR;
  volatile uint32_t CR;
  volatile uint32_t CSR;
  uint32_t RESERVED13[2];
  volatile uint32_t DR11;
  volatile uint32_t DR12;
  volatile uint32_t DR13;
  volatile uint32_t DR14;
  volatile uint32_t DR15;
  volatile uint32_t DR16;
  volatile uint32_t DR17;
  volatile uint32_t DR18;
  volatile uint32_t DR19;
  volatile uint32_t DR20;
  volatile uint32_t DR21;
  volatile uint32_t DR22;
  volatile uint32_t DR23;
  volatile uint32_t DR24;
  volatile uint32_t DR25;
  volatile uint32_t DR26;
  volatile uint32_t DR27;
  volatile uint32_t DR28;
  volatile uint32_t DR29;
  volatile uint32_t DR30;
  volatile uint32_t DR31;
  volatile uint32_t DR32;
  volatile uint32_t DR33;
  volatile uint32_t DR34;
  volatile uint32_t DR35;
  volatile uint32_t DR36;
  volatile uint32_t DR37;
  volatile uint32_t DR38;
  volatile uint32_t DR39;
  volatile uint32_t DR40;
  volatile uint32_t DR41;
  volatile uint32_t DR42;
} BKP_TypeDef;





typedef struct
{
  volatile uint32_t TIR;
  volatile uint32_t TDTR;
  volatile uint32_t TDLR;
  volatile uint32_t TDHR;
} CAN_TxMailBox_TypeDef;





typedef struct
{
  volatile uint32_t RIR;
  volatile uint32_t RDTR;
  volatile uint32_t RDLR;
  volatile uint32_t RDHR;
} CAN_FIFOMailBox_TypeDef;





typedef struct
{
  volatile uint32_t FR1;
  volatile uint32_t FR2;
} CAN_FilterRegister_TypeDef;





typedef struct
{
  volatile uint32_t MCR;
  volatile uint32_t MSR;
  volatile uint32_t TSR;
  volatile uint32_t RF0R;
  volatile uint32_t RF1R;
  volatile uint32_t IER;
  volatile uint32_t ESR;
  volatile uint32_t BTR;
  uint32_t RESERVED0[88];
  CAN_TxMailBox_TypeDef sTxMailBox[3];
  CAN_FIFOMailBox_TypeDef sFIFOMailBox[2];
  uint32_t RESERVED1[12];
  volatile uint32_t FMR;
  volatile uint32_t FM1R;
  uint32_t RESERVED2;
  volatile uint32_t FS1R;
  uint32_t RESERVED3;
  volatile uint32_t FFA1R;
  uint32_t RESERVED4;
  volatile uint32_t FA1R;
  uint32_t RESERVED5[8];
  CAN_FilterRegister_TypeDef sFilterRegister[14];
} CAN_TypeDef;





typedef struct
{
  volatile uint32_t DR;
  volatile uint8_t IDR;
  uint8_t RESERVED0;
  uint16_t RESERVED1;
  volatile uint32_t CR;
} CRC_TypeDef;





typedef struct
{
  volatile uint32_t CR;
  volatile uint32_t SWTRIGR;
  volatile uint32_t DHR12R1;
  volatile uint32_t DHR12L1;
  volatile uint32_t DHR8R1;
  volatile uint32_t DHR12R2;
  volatile uint32_t DHR12L2;
  volatile uint32_t DHR8R2;
  volatile uint32_t DHR12RD;
  volatile uint32_t DHR12LD;
  volatile uint32_t DHR8RD;
  volatile uint32_t DOR1;
  volatile uint32_t DOR2;
} DAC_TypeDef;





typedef struct
{
  volatile uint32_t IDCODE;
  volatile uint32_t CR;
}DBGMCU_TypeDef;





typedef struct
{
  volatile uint32_t CCR;
  volatile uint32_t CNDTR;
  volatile uint32_t CPAR;
  volatile uint32_t CMAR;
} DMA_Channel_TypeDef;

typedef struct
{
  volatile uint32_t ISR;
  volatile uint32_t IFCR;
} DMA_TypeDef;







typedef struct
{
  volatile uint32_t IMR;
  volatile uint32_t EMR;
  volatile uint32_t RTSR;
  volatile uint32_t FTSR;
  volatile uint32_t SWIER;
  volatile uint32_t PR;
} EXTI_TypeDef;





typedef struct
{
  volatile uint32_t ACR;
  volatile uint32_t KEYR;
  volatile uint32_t OPTKEYR;
  volatile uint32_t SR;
  volatile uint32_t CR;
  volatile uint32_t AR;
  volatile uint32_t RESERVED;
  volatile uint32_t OBR;
  volatile uint32_t WRPR;
} FLASH_TypeDef;





typedef struct
{
  volatile uint16_t RDP;
  volatile uint16_t USER;
  volatile uint16_t Data0;
  volatile uint16_t Data1;
  volatile uint16_t WRP0;
  volatile uint16_t WRP1;
  volatile uint16_t WRP2;
  volatile uint16_t WRP3;
} OB_TypeDef;





typedef struct
{
  volatile uint32_t BTCR[8];
} FSMC_Bank1_TypeDef;





typedef struct
{
  volatile uint32_t BWTR[7];
} FSMC_Bank1E_TypeDef;





typedef struct
{
  volatile uint32_t PCR2;
  volatile uint32_t SR2;
  volatile uint32_t PMEM2;
  volatile uint32_t PATT2;
  uint32_t RESERVED0;
  volatile uint32_t ECCR2;
  uint32_t RESERVED1;
  uint32_t RESERVED2;
  volatile uint32_t PCR3;
  volatile uint32_t SR3;
  volatile uint32_t PMEM3;
  volatile uint32_t PATT3;
  uint32_t RESERVED3;
  volatile uint32_t ECCR3;
} FSMC_Bank2_3_TypeDef;





typedef struct
{
  volatile uint32_t PCR4;
  volatile uint32_t SR4;
  volatile uint32_t PMEM4;
  volatile uint32_t PATT4;
  volatile uint32_t PIO4;
} FSMC_Bank4_TypeDef;





typedef struct
{
  volatile uint32_t CRL;
  volatile uint32_t CRH;
  volatile uint32_t IDR;
  volatile uint32_t ODR;
  volatile uint32_t BSRR;
  volatile uint32_t BRR;
  volatile uint32_t LCKR;
} GPIO_TypeDef;





typedef struct
{
  volatile uint32_t EVCR;
  volatile uint32_t MAPR;
  volatile uint32_t EXTICR[4];
  uint32_t RESERVED0;
  volatile uint32_t MAPR2;
} AFIO_TypeDef;




typedef struct
{
  volatile uint32_t CR1;
  volatile uint32_t CR2;
  volatile uint32_t OAR1;
  volatile uint32_t OAR2;
  volatile uint32_t DR;
  volatile uint32_t SR1;
  volatile uint32_t SR2;
  volatile uint32_t CCR;
  volatile uint32_t TRISE;
} I2C_TypeDef;





typedef struct
{
  volatile uint32_t KR;
  volatile uint32_t PR;
  volatile uint32_t RLR;
  volatile uint32_t SR;
} IWDG_TypeDef;





typedef struct
{
  volatile uint32_t CR;
  volatile uint32_t CSR;
} PWR_TypeDef;





typedef struct
{
  volatile uint32_t CR;
  volatile uint32_t CFGR;
  volatile uint32_t CIR;
  volatile uint32_t APB2RSTR;
  volatile uint32_t APB1RSTR;
  volatile uint32_t AHBENR;
  volatile uint32_t APB2ENR;
  volatile uint32_t APB1ENR;
  volatile uint32_t BDCR;
  volatile uint32_t CSR;


} RCC_TypeDef;





typedef struct
{
  volatile uint32_t CRH;
  volatile uint32_t CRL;
  volatile uint32_t PRLH;
  volatile uint32_t PRLL;
  volatile uint32_t DIVH;
  volatile uint32_t DIVL;
  volatile uint32_t CNTH;
  volatile uint32_t CNTL;
  volatile uint32_t ALRH;
  volatile uint32_t ALRL;
} RTC_TypeDef;





typedef struct
{
  volatile uint32_t POWER;
  volatile uint32_t CLKCR;
  volatile uint32_t ARG;
  volatile uint32_t CMD;
  volatile const uint32_t RESPCMD;
  volatile const uint32_t RESP1;
  volatile const uint32_t RESP2;
  volatile const uint32_t RESP3;
  volatile const uint32_t RESP4;
  volatile uint32_t DTIMER;
  volatile uint32_t DLEN;
  volatile uint32_t DCTRL;
  volatile const uint32_t DCOUNT;
  volatile const uint32_t STA;
  volatile uint32_t ICR;
  volatile uint32_t MASK;
  uint32_t RESERVED0[2];
  volatile const uint32_t FIFOCNT;
  uint32_t RESERVED1[13];
  volatile uint32_t FIFO;
} SDIO_TypeDef;





typedef struct
{
  volatile uint32_t CR1;
  volatile uint32_t CR2;
  volatile uint32_t SR;
  volatile uint32_t DR;
  volatile uint32_t CRCPR;
  volatile uint32_t RXCRCR;
  volatile uint32_t TXCRCR;
  volatile uint32_t I2SCFGR;
  volatile uint32_t I2SPR;
} SPI_TypeDef;




typedef struct
{
  volatile uint32_t CR1;
  volatile uint32_t CR2;
  volatile uint32_t SMCR;
  volatile uint32_t DIER;
  volatile uint32_t SR;
  volatile uint32_t EGR;
  volatile uint32_t CCMR1;
  volatile uint32_t CCMR2;
  volatile uint32_t CCER;
  volatile uint32_t CNT;
  volatile uint32_t PSC;
  volatile uint32_t ARR;
  volatile uint32_t RCR;
  volatile uint32_t CCR1;
  volatile uint32_t CCR2;
  volatile uint32_t CCR3;
  volatile uint32_t CCR4;
  volatile uint32_t BDTR;
  volatile uint32_t DCR;
  volatile uint32_t DMAR;
  volatile uint32_t OR;
}TIM_TypeDef;






typedef struct
{
  volatile uint32_t SR;
  volatile uint32_t DR;
  volatile uint32_t BRR;
  volatile uint32_t CR1;
  volatile uint32_t CR2;
  volatile uint32_t CR3;
  volatile uint32_t GTPR;
} USART_TypeDef;





typedef struct
{
  volatile uint16_t EP0R;
  volatile uint16_t RESERVED0;
  volatile uint16_t EP1R;
  volatile uint16_t RESERVED1;
  volatile uint16_t EP2R;
  volatile uint16_t RESERVED2;
  volatile uint16_t EP3R;
  volatile uint16_t RESERVED3;
  volatile uint16_t EP4R;
  volatile uint16_t RESERVED4;
  volatile uint16_t EP5R;
  volatile uint16_t RESERVED5;
  volatile uint16_t EP6R;
  volatile uint16_t RESERVED6;
  volatile uint16_t EP7R;
  volatile uint16_t RESERVED7[17];
  volatile uint16_t CNTR;
  volatile uint16_t RESERVED8;
  volatile uint16_t ISTR;
  volatile uint16_t RESERVED9;
  volatile uint16_t FNR;
  volatile uint16_t RESERVEDA;
  volatile uint16_t DADDR;
  volatile uint16_t RESERVEDB;
  volatile uint16_t BTABLE;
  volatile uint16_t RESERVEDC;
} USB_TypeDef;






typedef struct
{
  volatile uint32_t CR;
  volatile uint32_t CFR;
  volatile uint32_t SR;
} WWDG_TypeDef;
# 152 "Drivers/CMSIS/Device/ST/STM32F1xx/Include/stm32f1xx.h" 2
# 169 "Drivers/CMSIS/Device/ST/STM32F1xx/Include/stm32f1xx.h"
typedef enum
{
  RESET = 0,
  SET = !RESET
} FlagStatus, ITStatus;

typedef enum
{
  DISABLE = 0,
  ENABLE = !DISABLE
} FunctionalState;


typedef enum
{
  ERROR = 0,
  SUCCESS = !ERROR
} ErrorStatus;
# 218 "Drivers/CMSIS/Device/ST/STM32F1xx/Include/stm32f1xx.h"
# 1 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal.h" 1
# 219 "Drivers/CMSIS/Device/ST/STM32F1xx/Include/stm32f1xx.h" 2
# 49 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_def.h" 2



# 1 "/usr/include/newlib/stdio.h" 1 3
# 29 "/usr/include/newlib/stdio.h" 3
# 1 "/usr/include/newlib/_ansi.h" 1 3
# 10 "/usr/include/newlib/_ansi.h" 3
# 1 "/usr/include/newlib/newlib.h" 1 3
# 10 "/usr/include/newlib/newlib.h" 3
# 1 "/usr/include/newlib/_newlib_version.h" 1 3
# 11 "/usr/include/newlib/newlib.h" 2 3
# 11 "/usr/include/newlib/_ansi.h" 2 3
# 1 "/usr/include/newlib/sys/config.h" 1 3



# 1 "/usr/include/newlib/machine/ieeefp.h" 1 3
# 5 "/usr/include/newlib/sys/config.h" 2 3
# 1 "/usr/include/newlib/sys/features.h" 1 3
# 6 "/usr/include/newlib/sys/config.h" 2 3
# 12 "/usr/include/newlib/_ansi.h" 2 3
# 30 "/usr/include/newlib/stdio.h" 2 3





# 1 "/usr/include/newlib/sys/cdefs.h" 1 3
# 45 "/usr/include/newlib/sys/cdefs.h" 3
# 1 "/usr/include/newlib/machine/_default_types.h" 1 3
# 41 "/usr/include/newlib/machine/_default_types.h" 3

# 41 "/usr/include/newlib/machine/_default_types.h" 3
typedef signed char __int8_t;

typedef unsigned char __uint8_t;
# 55 "/usr/include/newlib/machine/_default_types.h" 3
typedef short int __int16_t;

typedef short unsigned int __uint16_t;
# 77 "/usr/include/newlib/machine/_default_types.h" 3
typedef long int __int32_t;

typedef long unsigned int __uint32_t;
# 103 "/usr/include/newlib/machine/_default_types.h" 3
typedef long long int __int64_t;

typedef long long unsigned int __uint64_t;
# 134 "/usr/include/newlib/machine/_default_types.h" 3
typedef signed char __int_least8_t;

typedef unsigned char __uint_least8_t;
# 160 "/usr/include/newlib/machine/_default_types.h" 3
typedef short int __int_least16_t;

typedef short unsigned int __uint_least16_t;
# 182 "/usr/include/newlib/machine/_default_types.h" 3
typedef long int __int_least32_t;

typedef long unsigned int __uint_least32_t;
# 200 "/usr/include/newlib/machine/_default_types.h" 3
typedef long long int __int_least64_t;

typedef long long unsigned int __uint_least64_t;
# 214 "/usr/include/newlib/machine/_default_types.h" 3
typedef long long int __intmax_t;







typedef long long unsigned int __uintmax_t;







typedef int __intptr_t;

typedef unsigned int __uintptr_t;
# 46 "/usr/include/newlib/sys/cdefs.h" 2 3

# 1 "/usr/lib/gcc/arm-none-eabi/13.2.1/include/stddef.h" 1 3 4
# 214 "/usr/lib/gcc/arm-none-eabi/13.2.1/include/stddef.h" 3 4
typedef unsigned int size_t;
# 48 "/usr/include/newlib/sys/cdefs.h" 2 3
# 36 "/usr/include/newlib/stdio.h" 2 3
# 1 "/usr/lib/gcc/arm-none-eabi/13.2.1/include/stddef.h" 1 3 4
# 145 "/usr/lib/gcc/arm-none-eabi/13.2.1/include/stddef.h" 3 4
typedef int ptrdiff_t;
# 329 "/usr/lib/gcc/arm-none-eabi/13.2.1/include/stddef.h" 3 4
typedef unsigned int wchar_t;
# 425 "/usr/lib/gcc/arm-none-eabi/13.2.1/include/stddef.h" 3 4
typedef struct {
  long long __max_align_ll __attribute__((__aligned__(__alignof__(long long))));
  long double __max_align_ld __attribute__((__aligned__(__alignof__(long double))));
# 436 "/usr/lib/gcc/arm-none-eabi/13.2.1/include/stddef.h" 3 4
} max_align_t;
# 37 "/usr/include/newlib/stdio.h" 2 3



# 1 "/usr/lib/gcc/arm-none-eabi/13.2.1/include/stdarg.h" 1 3 4
# 40 "/usr/lib/gcc/arm-none-eabi/13.2.1/include/stdarg.h" 3 4
typedef __builtin_va_list __gnuc_va_list;
# 41 "/usr/include/newlib/stdio.h" 2 3





typedef __gnuc_va_list va_list;
# 60 "/usr/include/newlib/stdio.h" 3
# 1 "/usr/include/newlib/sys/reent.h" 1 3
# 13 "/usr/include/newlib/sys/reent.h" 3
# 1 "/usr/include/newlib/_ansi.h" 1 3
# 14 "/usr/include/newlib/sys/reent.h" 2 3
# 1 "/usr/lib/gcc/arm-none-eabi/13.2.1/include/stddef.h" 1 3 4
# 15 "/usr/include/newlib/sys/reent.h" 2 3

# 1 "/usr/include/newlib/sys/_types.h" 1 3
# 24 "/usr/include/newlib/sys/_types.h" 3
# 1 "/usr/lib/gcc/arm-none-eabi/13.2.1/include/stddef.h" 1 3 4
# 359 "/usr/lib/gcc/arm-none-eabi/13.2.1/include/stddef.h" 3 4
typedef unsigned int wint_t;
# 25 "/usr/include/newlib/sys/_types.h" 2 3


# 1 "/usr/include/newlib/machine/_types.h" 1 3
# 28 "/usr/include/newlib/sys/_types.h" 2 3


typedef long __blkcnt_t;



typedef long __blksize_t;



typedef __uint64_t __fsblkcnt_t;



typedef __uint32_t __fsfilcnt_t;



typedef long _off_t;





typedef int __pid_t;



typedef short __dev_t;



typedef unsigned short __uid_t;


typedef unsigned short __gid_t;



typedef __uint32_t __id_t;







typedef unsigned short __ino_t;
# 90 "/usr/include/newlib/sys/_types.h" 3
typedef __uint32_t __mode_t;





__extension__ typedef long long _off64_t;





typedef _off_t __off_t;


typedef _off64_t __loff_t;


typedef long __key_t;







typedef long _fpos_t;
# 131 "/usr/include/newlib/sys/_types.h" 3
typedef unsigned int __size_t;
# 147 "/usr/include/newlib/sys/_types.h" 3
typedef signed int _ssize_t;
# 158 "/usr/include/newlib/sys/_types.h" 3
typedef _ssize_t __ssize_t;



typedef struct
{
  int __count;
  union
  {
    wint_t __wch;
    unsigned char __wchb[4];
  } __value;
} _mbstate_t;




typedef void *_iconv_t;






typedef unsigned long __clock_t;






typedef __int_least64_t __time_t;





typedef unsigned long __clockid_t;


typedef long __daddr_t;



typedef unsigned long __timer_t;


typedef __uint8_t __sa_family_t;



typedef __uint32_t __socklen_t;


typedef int __nl_item;
typedef unsigned short __nlink_t;
typedef long __suseconds_t;
typedef unsigned long __useconds_t;







typedef __builtin_va_list __va_list;
# 17 "/usr/include/newlib/sys/reent.h" 2 3






typedef unsigned long __ULong;
# 35 "/usr/include/newlib/sys/reent.h" 3
# 1 "/usr/include/newlib/sys/lock.h" 1 3
# 11 "/usr/include/newlib/sys/lock.h" 3
typedef int _LOCK_T;
typedef int _LOCK_RECURSIVE_T;
# 36 "/usr/include/newlib/sys/reent.h" 2 3
typedef _LOCK_RECURSIVE_T _flock_t;







struct _reent;

struct __locale_t;






struct _Bigint
{
  struct _Bigint *_next;
  int _k, _maxwds, _sign, _wds;
  __ULong _x[1];
};


struct __tm
{
  int __tm_sec;
  int __tm_min;
  int __tm_hour;
  int __tm_mday;
  int __tm_mon;
  int __tm_year;
  int __tm_wday;
  int __tm_yday;
  int __tm_isdst;
};







struct _on_exit_args {
 void * _fnargs[32];
 void * _dso_handle[32];

 __ULong _fntypes;


 __ULong _is_cxa;
};
# 99 "/usr/include/newlib/sys/reent.h" 3
struct _atexit {
 struct _atexit *_next;
 int _ind;

 void (*_fns[32])(void);
        struct _on_exit_args _on_exit_args;
};
# 116 "/usr/include/newlib/sys/reent.h" 3
struct __sbuf {
 unsigned char *_base;
 int _size;
};
# 153 "/usr/include/newlib/sys/reent.h" 3
struct __sFILE {
  unsigned char *_p;
  int _r;
  int _w;
  short _flags;
  short _file;
  struct __sbuf _bf;
  int _lbfsize;






  void * _cookie;

  int (*_read) (struct _reent *, void *,
        char *, int);
  int (*_write) (struct _reent *, void *,
         const char *,
         int);
  _fpos_t (*_seek) (struct _reent *, void *, _fpos_t, int);
  int (*_close) (struct _reent *, void *);


  struct __sbuf _ub;
  unsigned char *_up;
  int _ur;


  unsigned char _ubuf[3];
  unsigned char _nbuf[1];


  struct __sbuf _lb;


  int _blksize;
  _off_t _offset;


  struct _reent *_data;



  _flock_t _lock;

  _mbstate_t _mbstate;
  int _flags2;
};
# 270 "/usr/include/newlib/sys/reent.h" 3
typedef struct __sFILE __FILE;



extern __FILE __sf[3];

struct _glue
{
  struct _glue *_next;
  int _niobs;
  __FILE *_iobs;
};

extern struct _glue __sglue;
# 306 "/usr/include/newlib/sys/reent.h" 3
struct _rand48 {
  unsigned short _seed[3];
  unsigned short _mult[3];
  unsigned short _add;




};
# 568 "/usr/include/newlib/sys/reent.h" 3
struct _reent
{
  int _errno;




  __FILE *_stdin, *_stdout, *_stderr;

  int _inc;
  char _emergency[25];




  struct __locale_t *_locale;





  void (*__cleanup) (struct _reent *);


  struct _Bigint *_result;
  int _result_k;
  struct _Bigint *_p5s;
  struct _Bigint **_freelist;


  int _cvtlen;
  char *_cvtbuf;

  union
    {
      struct
        {



          char * _strtok_last;
          char _asctime_buf[26];
          struct __tm _localtime_buf;
          int _gamma_signgam;
          __extension__ unsigned long long _rand_next;
          struct _rand48 _r48;
          _mbstate_t _mblen_state;
          _mbstate_t _mbtowc_state;
          _mbstate_t _wctomb_state;
          char _l64a_buf[8];
          char _signal_buf[24];
          int _getdate_err;
          _mbstate_t _mbrlen_state;
          _mbstate_t _mbrtowc_state;
          _mbstate_t _mbsrtowcs_state;
          _mbstate_t _wcrtomb_state;
          _mbstate_t _wcsrtombs_state;
   int _h_errno;
# 634 "/usr/include/newlib/sys/reent.h" 3
        } _reent;







    } _new;







  void (**_sig_func)(int);
};
# 782 "/usr/include/newlib/sys/reent.h" 3
extern struct _reent *_impure_ptr ;





extern struct _reent _impure_data ;
# 900 "/usr/include/newlib/sys/reent.h" 3
extern struct _atexit *__atexit;
extern struct _atexit __atexit0;

extern void (*__stdio_exit_handler) (void);

void _reclaim_reent (struct _reent *);

extern int _fwalk_sglue (struct _reent *, int (*)(struct _reent *, __FILE *),
    struct _glue *);
# 61 "/usr/include/newlib/stdio.h" 2 3





typedef __FILE FILE;



typedef _fpos_t fpos_t;





typedef __off_t off_t;




typedef _ssize_t ssize_t;



# 1 "/usr/include/newlib/sys/stdio.h" 1 3
# 86 "/usr/include/newlib/stdio.h" 2 3
# 187 "/usr/include/newlib/stdio.h" 3
char * ctermid (char *);




FILE * tmpfile (void);
char * tmpnam (char *);

char * tempnam (const char *, const char *) __attribute__((__malloc__)) __attribute__((__warn_unused_result__));

int fclose (FILE *);
int fflush (FILE *);
FILE * freopen (const char *restrict, const char *restrict, FILE *restrict);
void setbuf (FILE *restrict, char *restrict);
int setvbuf (FILE *restrict, char *restrict, int, size_t);
int fprintf (FILE *restrict, const char *restrict, ...)
               __attribute__ ((__format__ (__printf__, 2, 3)));
int fscanf (FILE *restrict, const char *restrict, ...)
               __attribute__ ((__format__ (__scanf__, 2, 3)));
int printf (const char *restrict, ...)
               __attribute__ ((__format__ (__printf__, 1, 2)));
int scanf (const char *restrict, ...)
               __attribute__ ((__format__ (__scanf__, 1, 2)));
int sscanf (const char *restrict, const char *restrict, ...)
               __attribute__ ((__format__ (__scanf__, 2, 3)));
int vfprintf (FILE *restrict, const char *restrict, __gnuc_va_list)
               __attribute__ ((__format__ (__printf__, 2, 0)));
int vprintf (const char *, __gnuc_va_list)
               __attribute__ ((__format__ (__printf__, 1, 0)));
int vsprintf (char *restrict, const char *restrict, __gnuc_va_list)
               __attribute__ ((__format__ (__printf__, 2, 0)));
int fgetc (FILE *);
char * fgets (char *restrict, int, FILE *restrict);
int fputc (int, FILE *);
int fputs (const char *restrict, FILE *restrict);
int getc (FILE *);
int getchar (void);
char * gets (char *);
int putc (int, FILE *);
int putchar (int);
int puts (const char *);
int ungetc (int, FILE *);
size_t fread (void *restrict, size_t _size, size_t _n, FILE *restrict);
size_t fwrite (const void *restrict , size_t _size, size_t _n, FILE *);



int fgetpos (FILE *restrict, fpos_t *restrict);

int fseek (FILE *, long, int);



int fsetpos (FILE *, const fpos_t *);

long ftell ( FILE *);
void rewind (FILE *);
void clearerr (FILE *);
int feof (FILE *);
int ferror (FILE *);
void perror (const char *);

FILE * fopen (const char *restrict _name, const char *restrict _type);
int sprintf (char *restrict, const char *restrict, ...)
               __attribute__ ((__format__ (__printf__, 2, 3)));
int remove (const char *);
int rename (const char *, const char *);
# 263 "/usr/include/newlib/stdio.h" 3
int fseeko (FILE *, off_t, int);
off_t ftello (FILE *);







int snprintf (char *restrict, size_t, const char *restrict, ...)
               __attribute__ ((__format__ (__printf__, 3, 4)));
int vsnprintf (char *restrict, size_t, const char *restrict, __gnuc_va_list)
               __attribute__ ((__format__ (__printf__, 3, 0)));
int vfscanf (FILE *restrict, const char *restrict, __gnuc_va_list)
               __attribute__ ((__format__ (__scanf__, 2, 0)));
int vscanf (const char *, __gnuc_va_list)
               __attribute__ ((__format__ (__scanf__, 1, 0)));
int vsscanf (const char *restrict, const char *restrict, __gnuc_va_list)
               __attribute__ ((__format__ (__scanf__, 2, 0)));
# 290 "/usr/include/newlib/stdio.h" 3
int asiprintf (char **, const char *, ...)
               __attribute__ ((__format__ (__printf__, 2, 3)));
char * asniprintf (char *, size_t *, const char *, ...)
               __attribute__ ((__format__ (__printf__, 3, 4)));
char * asnprintf (char *restrict, size_t *restrict, const char *restrict, ...)
               __attribute__ ((__format__ (__printf__, 3, 4)));

int diprintf (int, const char *, ...)
               __attribute__ ((__format__ (__printf__, 2, 3)));

int fiprintf (FILE *, const char *, ...)
               __attribute__ ((__format__ (__printf__, 2, 3)));
int fiscanf (FILE *, const char *, ...)
               __attribute__ ((__format__ (__scanf__, 2, 3)));
int iprintf (const char *, ...)
               __attribute__ ((__format__ (__printf__, 1, 2)));
int iscanf (const char *, ...)
               __attribute__ ((__format__ (__scanf__, 1, 2)));
int siprintf (char *, const char *, ...)
               __attribute__ ((__format__ (__printf__, 2, 3)));
int siscanf (const char *, const char *, ...)
               __attribute__ ((__format__ (__scanf__, 2, 3)));
int sniprintf (char *, size_t, const char *, ...)
               __attribute__ ((__format__ (__printf__, 3, 4)));
int vasiprintf (char **, const char *, __gnuc_va_list)
               __attribute__ ((__format__ (__printf__, 2, 0)));
char * vasniprintf (char *, size_t *, const char *, __gnuc_va_list)
               __attribute__ ((__format__ (__printf__, 3, 0)));
char * vasnprintf (char *, size_t *, const char *, __gnuc_va_list)
               __attribute__ ((__format__ (__printf__, 3, 0)));
int vdiprintf (int, const char *, __gnuc_va_list)
               __attribute__ ((__format__ (__printf__, 2, 0)));
int vfiprintf (FILE *, const char *, __gnuc_va_list)
               __attribute__ ((__format__ (__printf__, 2, 0)));
int vfiscanf (FILE *, const char *, __gnuc_va_list)
               __attribute__ ((__format__ (__scanf__, 2, 0)));
int viprintf (const char *, __gnuc_va_list)
               __attribute__ ((__format__ (__printf__, 1, 0)));
int viscanf (const char *, __gnuc_va_list)
               __attribute__ ((__format__ (__scanf__, 1, 0)));
int vsiprintf (char *, const char *, __gnuc_va_list)
               __attribute__ ((__format__ (__printf__, 2, 0)));
int vsiscanf (const char *, const char *, __gnuc_va_list)
               __attribute__ ((__format__ (__scanf__, 2, 0)));
int vsniprintf (char *, size_t, const char *, __gnuc_va_list)
               __attribute__ ((__format__ (__printf__, 3, 0)));
# 345 "/usr/include/newlib/stdio.h" 3
FILE * fdopen (int, const char *);

int fileno (FILE *);


int pclose (FILE *);
FILE * popen (const char *, const char *);



void setbuffer (FILE *, char *, int);
int setlinebuf (FILE *);



int getw (FILE *);
int putw (int, FILE *);


int getc_unlocked (FILE *);
int getchar_unlocked (void);
void flockfile (FILE *);
int ftrylockfile (FILE *);
void funlockfile (FILE *);
int putc_unlocked (int, FILE *);
int putchar_unlocked (int);
# 380 "/usr/include/newlib/stdio.h" 3
int dprintf (int, const char *restrict, ...)
               __attribute__ ((__format__ (__printf__, 2, 3)));

FILE * fmemopen (void *restrict, size_t, const char *restrict);


FILE * open_memstream (char **, size_t *);
int vdprintf (int, const char *restrict, __gnuc_va_list)
               __attribute__ ((__format__ (__printf__, 2, 0)));



int renameat (int, const char *, int, const char *);
# 402 "/usr/include/newlib/stdio.h" 3
int _asiprintf_r (struct _reent *, char **, const char *, ...)
               __attribute__ ((__format__ (__printf__, 3, 4)));
char * _asniprintf_r (struct _reent *, char *, size_t *, const char *, ...)
               __attribute__ ((__format__ (__printf__, 4, 5)));
char * _asnprintf_r (struct _reent *, char *restrict, size_t *restrict, const char *restrict, ...)
               __attribute__ ((__format__ (__printf__, 4, 5)));
int _asprintf_r (struct _reent *, char **restrict, const char *restrict, ...)
               __attribute__ ((__format__ (__printf__, 3, 4)));
int _diprintf_r (struct _reent *, int, const char *, ...)
               __attribute__ ((__format__ (__printf__, 3, 4)));
int _dprintf_r (struct _reent *, int, const char *restrict, ...)
               __attribute__ ((__format__ (__printf__, 3, 4)));
int _fclose_r (struct _reent *, FILE *);
int _fcloseall_r (struct _reent *);
FILE * _fdopen_r (struct _reent *, int, const char *);
int _fflush_r (struct _reent *, FILE *);
int _fgetc_r (struct _reent *, FILE *);
int _fgetc_unlocked_r (struct _reent *, FILE *);
char * _fgets_r (struct _reent *, char *restrict, int, FILE *restrict);
char * _fgets_unlocked_r (struct _reent *, char *restrict, int, FILE *restrict);




int _fgetpos_r (struct _reent *, FILE *, fpos_t *);
int _fsetpos_r (struct _reent *, FILE *, const fpos_t *);

int _fiprintf_r (struct _reent *, FILE *, const char *, ...)
               __attribute__ ((__format__ (__printf__, 3, 4)));
int _fiscanf_r (struct _reent *, FILE *, const char *, ...)
               __attribute__ ((__format__ (__scanf__, 3, 4)));
FILE * _fmemopen_r (struct _reent *, void *restrict, size_t, const char *restrict);
FILE * _fopen_r (struct _reent *, const char *restrict, const char *restrict);
FILE * _freopen_r (struct _reent *, const char *restrict, const char *restrict, FILE *restrict);
int _fprintf_r (struct _reent *, FILE *restrict, const char *restrict, ...)
               __attribute__ ((__format__ (__printf__, 3, 4)));
int _fpurge_r (struct _reent *, FILE *);
int _fputc_r (struct _reent *, int, FILE *);
int _fputc_unlocked_r (struct _reent *, int, FILE *);
int _fputs_r (struct _reent *, const char *restrict, FILE *restrict);
int _fputs_unlocked_r (struct _reent *, const char *restrict, FILE *restrict);
size_t _fread_r (struct _reent *, void *restrict, size_t _size, size_t _n, FILE *restrict);
size_t _fread_unlocked_r (struct _reent *, void *restrict, size_t _size, size_t _n, FILE *restrict);
int _fscanf_r (struct _reent *, FILE *restrict, const char *restrict, ...)
               __attribute__ ((__format__ (__scanf__, 3, 4)));
int _fseek_r (struct _reent *, FILE *, long, int);
int _fseeko_r (struct _reent *, FILE *, _off_t, int);
long _ftell_r (struct _reent *, FILE *);
_off_t _ftello_r (struct _reent *, FILE *);
void _rewind_r (struct _reent *, FILE *);
size_t _fwrite_r (struct _reent *, const void *restrict, size_t _size, size_t _n, FILE *restrict);
size_t _fwrite_unlocked_r (struct _reent *, const void *restrict, size_t _size, size_t _n, FILE *restrict);
int _getc_r (struct _reent *, FILE *);
int _getc_unlocked_r (struct _reent *, FILE *);
int _getchar_r (struct _reent *);
int _getchar_unlocked_r (struct _reent *);
char * _gets_r (struct _reent *, char *);
int _iprintf_r (struct _reent *, const char *, ...)
               __attribute__ ((__format__ (__printf__, 2, 3)));
int _iscanf_r (struct _reent *, const char *, ...)
               __attribute__ ((__format__ (__scanf__, 2, 3)));
FILE * _open_memstream_r (struct _reent *, char **, size_t *);
void _perror_r (struct _reent *, const char *);
int _printf_r (struct _reent *, const char *restrict, ...)
               __attribute__ ((__format__ (__printf__, 2, 3)));
int _putc_r (struct _reent *, int, FILE *);
int _putc_unlocked_r (struct _reent *, int, FILE *);
int _putchar_unlocked_r (struct _reent *, int);
int _putchar_r (struct _reent *, int);
int _puts_r (struct _reent *, const char *);
int _remove_r (struct _reent *, const char *);
int _rename_r (struct _reent *,
      const char *_old, const char *_new);
int _scanf_r (struct _reent *, const char *restrict, ...)
               __attribute__ ((__format__ (__scanf__, 2, 3)));
int _siprintf_r (struct _reent *, char *, const char *, ...)
               __attribute__ ((__format__ (__printf__, 3, 4)));
int _siscanf_r (struct _reent *, const char *, const char *, ...)
               __attribute__ ((__format__ (__scanf__, 3, 4)));
int _sniprintf_r (struct _reent *, char *, size_t, const char *, ...)
               __attribute__ ((__format__ (__printf__, 4, 5)));
int _snprintf_r (struct _reent *, char *restrict, size_t, const char *restrict, ...)
               __attribute__ ((__format__ (__printf__, 4, 5)));
int _sprintf_r (struct _reent *, char *restrict, const char *restrict, ...)
               __attribute__ ((__format__ (__printf__, 3, 4)));
int _sscanf_r (struct _reent *, const char *restrict, const char *restrict, ...)
               __attribute__ ((__format__ (__scanf__, 3, 4)));
char * _tempnam_r (struct _reent *, const char *, const char *);
FILE * _tmpfile_r (struct _reent *);
char * _tmpnam_r (struct _reent *, char *);
int _ungetc_r (struct _reent *, int, FILE *);
int _vasiprintf_r (struct _reent *, char **, const char *, __gnuc_va_list)
               __attribute__ ((__format__ (__printf__, 3, 0)));
char * _vasniprintf_r (struct _reent*, char *, size_t *, const char *, __gnuc_va_list)
               __attribute__ ((__format__ (__printf__, 4, 0)));
char * _vasnprintf_r (struct _reent*, char *, size_t *, const char *, __gnuc_va_list)
               __attribute__ ((__format__ (__printf__, 4, 0)));
int _vasprintf_r (struct _reent *, char **, const char *, __gnuc_va_list)
               __attribute__ ((__format__ (__printf__, 3, 0)));
int _vdiprintf_r (struct _reent *, int, const char *, __gnuc_va_list)
               __attribute__ ((__format__ (__printf__, 3, 0)));
int _vdprintf_r (struct _reent *, int, const char *restrict, __gnuc_va_list)
               __attribute__ ((__format__ (__printf__, 3, 0)));
int _vfiprintf_r (struct _reent *, FILE *, const char *, __gnuc_va_list)
               __attribute__ ((__format__ (__printf__, 3, 0)));
int _vfiscanf_r (struct _reent *, FILE *, const char *, __gnuc_va_list)
               __attribute__ ((__format__ (__scanf__, 3, 0)));
int _vfprintf_r (struct _reent *, FILE *restrict, const char *restrict, __gnuc_va_list)
               __attribute__ ((__format__ (__printf__, 3, 0)));
int _vfscanf_r (struct _reent *, FILE *restrict, const char *restrict, __gnuc_va_list)
               __attribute__ ((__format__ (__scanf__, 3, 0)));
int _viprintf_r (struct _reent *, const char *, __gnuc_va_list)
               __attribute__ ((__format__ (__printf__, 2, 0)));
int _viscanf_r (struct _reent *, const char *, __gnuc_va_list)
               __attribute__ ((__format__ (__scanf__, 2, 0)));
int _vprintf_r (struct _reent *, const char *restrict, __gnuc_va_list)
               __attribute__ ((__format__ (__printf__, 2, 0)));
int _vscanf_r (struct _reent *, const char *restrict, __gnuc_va_list)
               __attribute__ ((__format__ (__scanf__, 2, 0)));
int _vsiprintf_r (struct _reent *, char *, const char *, __gnuc_va_list)
               __attribute__ ((__format__ (__printf__, 3, 0)));
int _vsiscanf_r (struct _reent *, const char *, const char *, __gnuc_va_list)
               __attribute__ ((__format__ (__scanf__, 3, 0)));
int _vsniprintf_r (struct _reent *, char *, size_t, const char *, __gnuc_va_list)
               __attribute__ ((__format__ (__printf__, 4, 0)));
int _vsnprintf_r (struct _reent *, char *restrict, size_t, const char *restrict, __gnuc_va_list)
               __attribute__ ((__format__ (__printf__, 4, 0)));
int _vsprintf_r (struct _reent *, char *restrict, const char *restrict, __gnuc_va_list)
               __attribute__ ((__format__ (__printf__, 3, 0)));
int _vsscanf_r (struct _reent *, const char *restrict, const char *restrict, __gnuc_va_list)
               __attribute__ ((__format__ (__scanf__, 3, 0)));



int fpurge (FILE *);
ssize_t __getdelim (char **, size_t *, int, FILE *);
ssize_t __getline (char **, size_t *, FILE *);


void clearerr_unlocked (FILE *);
int feof_unlocked (FILE *);
int ferror_unlocked (FILE *);
int fileno_unlocked (FILE *);
int fflush_unlocked (FILE *);
int fgetc_unlocked (FILE *);
int fputc_unlocked (int, FILE *);
size_t fread_unlocked (void *restrict, size_t _size, size_t _n, FILE *restrict);
size_t fwrite_unlocked (const void *restrict , size_t _size, size_t _n, FILE *);
# 583 "/usr/include/newlib/stdio.h" 3
int __srget_r (struct _reent *, FILE *);
int __swbuf_r (struct _reent *, int, FILE *);
# 607 "/usr/include/newlib/stdio.h" 3
FILE *funopen (const void *__cookie,
  int (*__readfn)(void *__cookie, char *__buf,
    int __n),
  int (*__writefn)(void *__cookie, const char *__buf,
     int __n),
  fpos_t (*__seekfn)(void *__cookie, fpos_t __off, int __whence),
  int (*__closefn)(void *__cookie));
FILE *_funopen_r (struct _reent *, const void *__cookie,
  int (*__readfn)(void *__cookie, char *__buf,
    int __n),
  int (*__writefn)(void *__cookie, const char *__buf,
     int __n),
  fpos_t (*__seekfn)(void *__cookie, fpos_t __off, int __whence),
  int (*__closefn)(void *__cookie));
# 691 "/usr/include/newlib/stdio.h" 3
static __inline__ int __sputc_r(struct _reent *_ptr, int _c, FILE *_p) {




 if (--_p->_w >= 0 || (_p->_w >= _p->_lbfsize && (char)_c != '\n'))
  return (*_p->_p++ = _c);
 else
  return (__swbuf_r(_ptr, _c, _p));
}
# 745 "/usr/include/newlib/stdio.h" 3
static __inline int
_getchar_unlocked(void)
{
 struct _reent *_ptr;

 _ptr = _impure_ptr;
 return ((--(((_ptr)->_stdin))->_r < 0 ? __srget_r(_ptr, ((_ptr)->_stdin)) : (int)(*(((_ptr)->_stdin))->_p++)));
}

static __inline int
_putchar_unlocked(int _c)
{
 struct _reent *_ptr;

 _ptr = _impure_ptr;
 return (__sputc_r(_ptr, _c, ((_ptr)->_stdout)));
}
# 801 "/usr/include/newlib/stdio.h" 3

# 53 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_def.h" 2







# 59 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_def.h"
typedef enum
{
  HAL_OK = 0x00U,
  HAL_ERROR = 0x01U,
  HAL_BUSY = 0x02U,
  HAL_TIMEOUT = 0x03U
} HAL_StatusTypeDef;




typedef enum
{
  HAL_UNLOCKED = 0x00U,
  HAL_LOCKED = 0x01U
} HAL_LockTypeDef;
# 48 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_rcc.h" 2
# 66 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_rcc.h"
typedef struct
{
  uint32_t PLLState;


  uint32_t PLLSource;


  uint32_t PLLMUL;

} RCC_PLLInitTypeDef;




typedef struct
{
  uint32_t ClockType;


  uint32_t SYSCLKSource;


  uint32_t AHBCLKDivider;


  uint32_t APB1CLKDivider;


  uint32_t APB2CLKDivider;

} RCC_ClkInitTypeDef;
# 1161 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_rcc.h"
# 1 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_rcc_ex.h" 1
# 246 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_rcc_ex.h"
typedef struct
{
  uint32_t OscillatorType;







  uint32_t HSEState;


  uint32_t HSEPredivValue;


  uint32_t LSEState;


  uint32_t HSIState;


  uint32_t HSICalibrationValue;


  uint32_t LSIState;


  RCC_PLLInitTypeDef PLL;




} RCC_OscInitTypeDef;
# 301 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_rcc_ex.h"
typedef struct
{
  uint32_t PeriphClockSelection;


  uint32_t RTCClockSelection;


  uint32_t AdcClockSelection;




  uint32_t I2s2ClockSelection;


  uint32_t I2s3ClockSelection;
# 330 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_rcc_ex.h"
  uint32_t UsbClockSelection;



} RCC_PeriphCLKInitTypeDef;
# 1877 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_rcc_ex.h"
HAL_StatusTypeDef HAL_RCCEx_PeriphCLKConfig(RCC_PeriphCLKInitTypeDef *PeriphClkInit);
void HAL_RCCEx_GetPeriphCLKConfig(RCC_PeriphCLKInitTypeDef *PeriphClkInit);
uint32_t HAL_RCCEx_GetPeriphCLKFreq(uint32_t PeriphClk);
# 1162 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_rcc.h" 2
# 1173 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_rcc.h"
void HAL_RCC_DeInit(void);
HAL_StatusTypeDef HAL_RCC_OscConfig(RCC_OscInitTypeDef *RCC_OscInitStruct);
HAL_StatusTypeDef HAL_RCC_ClockConfig(RCC_ClkInitTypeDef *RCC_ClkInitStruct, uint32_t FLatency);
# 1186 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_rcc.h"
void HAL_RCC_MCOConfig(uint32_t RCC_MCOx, uint32_t RCC_MCOSource, uint32_t RCC_MCODiv);
void HAL_RCC_EnableCSS(void);
void HAL_RCC_DisableCSS(void);
uint32_t HAL_RCC_GetSysClockFreq(void);
uint32_t HAL_RCC_GetHCLKFreq(void);
uint32_t HAL_RCC_GetPCLK1Freq(void);
uint32_t HAL_RCC_GetPCLK2Freq(void);
void HAL_RCC_GetOscConfig(RCC_OscInitTypeDef *RCC_OscInitStruct);
void HAL_RCC_GetClockConfig(RCC_ClkInitTypeDef *RCC_ClkInitStruct, uint32_t *pFLatency);


void HAL_RCC_NMI_IRQHandler(void);


void HAL_RCC_CSSCallback(void);
# 219 "Inc/stm32f1xx_hal_conf.h" 2



# 1 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_gpio.h" 1
# 65 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_gpio.h"
typedef struct
{
  uint32_t Pin;


  uint32_t Mode;


  uint32_t Pull;


  uint32_t Speed;

}GPIO_InitTypeDef;




typedef enum
{
  GPIO_PIN_RESET = 0U,
  GPIO_PIN_SET
}GPIO_PinState;
# 231 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_gpio.h"
# 1 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_gpio_ex.h" 1
# 900 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_gpio_ex.h"
void HAL_GPIOEx_ConfigEventout(uint32_t GPIO_PortSource, uint32_t GPIO_PinSource);
void HAL_GPIOEx_EnableEventout(void);
void HAL_GPIOEx_DisableEventout(void);
# 232 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_gpio.h" 2
# 242 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_gpio.h"
void HAL_GPIO_Init(GPIO_TypeDef *GPIOx, GPIO_InitTypeDef *GPIO_Init);
void HAL_GPIO_DeInit(GPIO_TypeDef *GPIOx, uint32_t GPIO_Pin);
# 252 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_gpio.h"
GPIO_PinState HAL_GPIO_ReadPin(GPIO_TypeDef* GPIOx, uint16_t GPIO_Pin);
void HAL_GPIO_WritePin(GPIO_TypeDef* GPIOx, uint16_t GPIO_Pin, GPIO_PinState PinState);
void HAL_GPIO_TogglePin(GPIO_TypeDef* GPIOx, uint16_t GPIO_Pin);
HAL_StatusTypeDef HAL_GPIO_LockPin(GPIO_TypeDef* GPIOx, uint16_t GPIO_Pin);
void HAL_GPIO_EXTI_IRQHandler(uint16_t GPIO_Pin);
void HAL_GPIO_EXTI_Callback(uint16_t GPIO_Pin);
# 223 "Inc/stm32f1xx_hal_conf.h" 2



# 1 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_dma.h" 1
# 66 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_dma.h"
typedef struct
{
  uint32_t Direction;



  uint32_t PeriphInc;


  uint32_t MemInc;


  uint32_t PeriphDataAlignment;


  uint32_t MemDataAlignment;


  uint32_t Mode;




  uint32_t Priority;

} DMA_InitTypeDef;




typedef enum
{
  HAL_DMA_STATE_RESET = 0x00U,
  HAL_DMA_STATE_READY = 0x01U,
  HAL_DMA_STATE_BUSY = 0x02U,
  HAL_DMA_STATE_TIMEOUT = 0x03U
}HAL_DMA_StateTypeDef;




typedef enum
{
  HAL_DMA_FULL_TRANSFER = 0x00U,
  HAL_DMA_HALF_TRANSFER = 0x01U
}HAL_DMA_LevelCompleteTypeDef;




typedef enum
{
  HAL_DMA_XFER_CPLT_CB_ID = 0x00U,
  HAL_DMA_XFER_HALFCPLT_CB_ID = 0x01U,
  HAL_DMA_XFER_ERROR_CB_ID = 0x02U,
  HAL_DMA_XFER_ABORT_CB_ID = 0x03U,
  HAL_DMA_XFER_ALL_CB_ID = 0x04U

}HAL_DMA_CallbackIDTypeDef;




typedef struct __DMA_HandleTypeDef
{
  DMA_Channel_TypeDef *Instance;

  DMA_InitTypeDef Init;

  HAL_LockTypeDef Lock;

  HAL_DMA_StateTypeDef State;

  void *Parent;

  void (* XferCpltCallback)( struct __DMA_HandleTypeDef * hdma);

  void (* XferHalfCpltCallback)( struct __DMA_HandleTypeDef * hdma);

  void (* XferErrorCallback)( struct __DMA_HandleTypeDef * hdma);

  void (* XferAbortCallback)( struct __DMA_HandleTypeDef * hdma);

  volatile uint32_t ErrorCode;

  DMA_TypeDef *DmaBaseAddress;

  uint32_t ChannelIndex;

} DMA_HandleTypeDef;
# 374 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_dma.h"
# 1 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_dma_ex.h" 1
# 375 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_dma.h" 2
# 385 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_dma.h"
HAL_StatusTypeDef HAL_DMA_Init(DMA_HandleTypeDef *hdma);
HAL_StatusTypeDef HAL_DMA_DeInit (DMA_HandleTypeDef *hdma);
# 395 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_dma.h"
HAL_StatusTypeDef HAL_DMA_Start (DMA_HandleTypeDef *hdma, uint32_t SrcAddress, uint32_t DstAddress, uint32_t DataLength);
HAL_StatusTypeDef HAL_DMA_Start_IT(DMA_HandleTypeDef *hdma, uint32_t SrcAddress, uint32_t DstAddress, uint32_t DataLength);
HAL_StatusTypeDef HAL_DMA_Abort(DMA_HandleTypeDef *hdma);
HAL_StatusTypeDef HAL_DMA_Abort_IT(DMA_HandleTypeDef *hdma);
HAL_StatusTypeDef HAL_DMA_PollForTransfer(DMA_HandleTypeDef *hdma, uint32_t CompleteLevel, uint32_t Timeout);
void HAL_DMA_IRQHandler(DMA_HandleTypeDef *hdma);
HAL_StatusTypeDef HAL_DMA_RegisterCallback(DMA_HandleTypeDef *hdma, HAL_DMA_CallbackIDTypeDef CallbackID, void (* pCallback)( DMA_HandleTypeDef * _hdma));
HAL_StatusTypeDef HAL_DMA_UnRegisterCallback(DMA_HandleTypeDef *hdma, HAL_DMA_CallbackIDTypeDef CallbackID);
# 412 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_dma.h"
HAL_DMA_StateTypeDef HAL_DMA_GetState(DMA_HandleTypeDef *hdma);
uint32_t HAL_DMA_GetError(DMA_HandleTypeDef *hdma);
# 227 "Inc/stm32f1xx_hal_conf.h" 2
# 242 "Inc/stm32f1xx_hal_conf.h"
# 1 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_cortex.h" 1
# 280 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_cortex.h"
void HAL_NVIC_SetPriorityGrouping(uint32_t PriorityGroup);
void HAL_NVIC_SetPriority(IRQn_Type IRQn, uint32_t PreemptPriority, uint32_t SubPriority);
void HAL_NVIC_EnableIRQ(IRQn_Type IRQn);
void HAL_NVIC_DisableIRQ(IRQn_Type IRQn);
void HAL_NVIC_SystemReset(void);
uint32_t HAL_SYSTICK_Config(uint32_t TicksNumb);
# 294 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_cortex.h"
uint32_t HAL_NVIC_GetPriorityGrouping(void);
void HAL_NVIC_GetPriority(IRQn_Type IRQn, uint32_t PriorityGroup, uint32_t* pPreemptPriority, uint32_t* pSubPriority);
uint32_t HAL_NVIC_GetPendingIRQ(IRQn_Type IRQn);
void HAL_NVIC_SetPendingIRQ(IRQn_Type IRQn);
void HAL_NVIC_ClearPendingIRQ(IRQn_Type IRQn);
uint32_t HAL_NVIC_GetActive(IRQn_Type IRQn);
void HAL_SYSTICK_CLKSourceConfig(uint32_t CLKSource);
void HAL_SYSTICK_IRQHandler(void);
void HAL_SYSTICK_Callback(void);
# 243 "Inc/stm32f1xx_hal_conf.h" 2



# 1 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_adc.h" 1
# 69 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_adc.h"
typedef struct
{
  uint32_t DataAlign;


  uint32_t ScanConvMode;
# 85 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_adc.h"
  uint32_t ContinuousConvMode;


  uint32_t NbrOfConversion;


  uint32_t DiscontinuousConvMode;



  uint32_t NbrOfDiscConversion;


  uint32_t ExternalTrigConv;



}ADC_InitTypeDef;






typedef struct
{
  uint32_t Channel;






  uint32_t Rank;


  uint32_t SamplingTime;
# 130 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_adc.h"
}ADC_ChannelConfTypeDef;






typedef struct
{
  uint32_t WatchdogMode;

  uint32_t Channel;


  uint32_t ITMode;

  uint32_t HighThreshold;

  uint32_t LowThreshold;

  uint32_t WatchdogNumber;
}ADC_AnalogWDGConfTypeDef;
# 192 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_adc.h"
typedef struct
{
  ADC_TypeDef *Instance;

  ADC_InitTypeDef Init;

  DMA_HandleTypeDef *DMA_Handle;

  HAL_LockTypeDef Lock;

  volatile uint32_t State;

  volatile uint32_t ErrorCode;
}ADC_HandleTypeDef;
# 854 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_adc.h"
# 1 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_adc_ex.h" 1
# 73 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_adc_ex.h"
typedef struct
{
  uint32_t InjectedChannel;






  uint32_t InjectedRank;


  uint32_t InjectedSamplingTime;
# 94 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_adc_ex.h"
  uint32_t InjectedOffset;



  uint32_t InjectedNbrOfConversion;




  uint32_t InjectedDiscontinuousConvMode;






  uint32_t AutoInjectedConv;







  uint32_t ExternalTrigInjecConv;







}ADC_InjectionConfTypeDef;







typedef struct
{
  uint32_t Mode;
# 147 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_adc_ex.h"
}ADC_MultiModeTypeDef;
# 665 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_adc_ex.h"
HAL_StatusTypeDef HAL_ADCEx_Calibration_Start(ADC_HandleTypeDef* hadc);


HAL_StatusTypeDef HAL_ADCEx_InjectedStart(ADC_HandleTypeDef* hadc);
HAL_StatusTypeDef HAL_ADCEx_InjectedStop(ADC_HandleTypeDef* hadc);
HAL_StatusTypeDef HAL_ADCEx_InjectedPollForConversion(ADC_HandleTypeDef* hadc, uint32_t Timeout);


HAL_StatusTypeDef HAL_ADCEx_InjectedStart_IT(ADC_HandleTypeDef* hadc);
HAL_StatusTypeDef HAL_ADCEx_InjectedStop_IT(ADC_HandleTypeDef* hadc);



HAL_StatusTypeDef HAL_ADCEx_MultiModeStart_DMA(ADC_HandleTypeDef *hadc, uint32_t *pData, uint32_t Length);
HAL_StatusTypeDef HAL_ADCEx_MultiModeStop_DMA(ADC_HandleTypeDef *hadc);



uint32_t HAL_ADCEx_InjectedGetValue(ADC_HandleTypeDef* hadc, uint32_t InjectedRank);

uint32_t HAL_ADCEx_MultiModeGetValue(ADC_HandleTypeDef *hadc);



void HAL_ADCEx_InjectedConvCpltCallback(ADC_HandleTypeDef* hadc);
# 699 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_adc_ex.h"
HAL_StatusTypeDef HAL_ADCEx_InjectedConfigChannel(ADC_HandleTypeDef* hadc,ADC_InjectionConfTypeDef* sConfigInjected);

HAL_StatusTypeDef HAL_ADCEx_MultiModeConfigChannel(ADC_HandleTypeDef *hadc, ADC_MultiModeTypeDef *multimode);
# 855 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_adc.h" 2
# 867 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_adc.h"
HAL_StatusTypeDef HAL_ADC_Init(ADC_HandleTypeDef* hadc);
HAL_StatusTypeDef HAL_ADC_DeInit(ADC_HandleTypeDef *hadc);
void HAL_ADC_MspInit(ADC_HandleTypeDef* hadc);
void HAL_ADC_MspDeInit(ADC_HandleTypeDef* hadc);
# 883 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_adc.h"
HAL_StatusTypeDef HAL_ADC_Start(ADC_HandleTypeDef* hadc);
HAL_StatusTypeDef HAL_ADC_Stop(ADC_HandleTypeDef* hadc);
HAL_StatusTypeDef HAL_ADC_PollForConversion(ADC_HandleTypeDef* hadc, uint32_t Timeout);
HAL_StatusTypeDef HAL_ADC_PollForEvent(ADC_HandleTypeDef* hadc, uint32_t EventType, uint32_t Timeout);


HAL_StatusTypeDef HAL_ADC_Start_IT(ADC_HandleTypeDef* hadc);
HAL_StatusTypeDef HAL_ADC_Stop_IT(ADC_HandleTypeDef* hadc);


HAL_StatusTypeDef HAL_ADC_Start_DMA(ADC_HandleTypeDef* hadc, uint32_t* pData, uint32_t Length);
HAL_StatusTypeDef HAL_ADC_Stop_DMA(ADC_HandleTypeDef* hadc);


uint32_t HAL_ADC_GetValue(ADC_HandleTypeDef* hadc);


void HAL_ADC_IRQHandler(ADC_HandleTypeDef* hadc);
void HAL_ADC_ConvCpltCallback(ADC_HandleTypeDef* hadc);
void HAL_ADC_ConvHalfCpltCallback(ADC_HandleTypeDef* hadc);
void HAL_ADC_LevelOutOfWindowCallback(ADC_HandleTypeDef* hadc);
void HAL_ADC_ErrorCallback(ADC_HandleTypeDef *hadc);
# 914 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_adc.h"
HAL_StatusTypeDef HAL_ADC_ConfigChannel(ADC_HandleTypeDef* hadc, ADC_ChannelConfTypeDef* sConfig);
HAL_StatusTypeDef HAL_ADC_AnalogWDGConfig(ADC_HandleTypeDef* hadc, ADC_AnalogWDGConfTypeDef* AnalogWDGConfig);
# 925 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_adc.h"
uint32_t HAL_ADC_GetState(ADC_HandleTypeDef* hadc);
uint32_t HAL_ADC_GetError(ADC_HandleTypeDef *hadc);
# 941 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_adc.h"
HAL_StatusTypeDef ADC_Enable(ADC_HandleTypeDef* hadc);
HAL_StatusTypeDef ADC_ConversionStop_Disable(ADC_HandleTypeDef* hadc);
void ADC_StabilizationTime(uint32_t DelayUs);
void ADC_DMAConvCplt(DMA_HandleTypeDef *hdma);
void ADC_DMAHalfConvCplt(DMA_HandleTypeDef *hdma);
void ADC_DMAError(DMA_HandleTypeDef *hdma);
# 247 "Inc/stm32f1xx_hal_conf.h" 2
# 258 "Inc/stm32f1xx_hal_conf.h"
# 1 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_flash.h" 1
# 93 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_flash.h"
typedef enum
{
  FLASH_PROC_NONE = 0U,
  FLASH_PROC_PAGEERASE = 1U,
  FLASH_PROC_MASSERASE = 2U,
  FLASH_PROC_PROGRAMHALFWORD = 3U,
  FLASH_PROC_PROGRAMWORD = 4U,
  FLASH_PROC_PROGRAMDOUBLEWORD = 5U
} FLASH_ProcedureTypeDef;




typedef struct
{
  volatile FLASH_ProcedureTypeDef ProcedureOnGoing;

  volatile uint32_t DataRemaining;

  volatile uint32_t Address;

  volatile uint64_t Data;

  HAL_LockTypeDef Lock;

  volatile uint32_t ErrorCode;

} FLASH_ProcessTypeDef;
# 266 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_flash.h"
# 1 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_flash_ex.h" 1
# 188 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_flash_ex.h"
typedef struct
{
  uint32_t TypeErase;


  uint32_t Banks;


  uint32_t PageAddress;



  uint32_t NbPages;


} FLASH_EraseInitTypeDef;




typedef struct
{
  uint32_t OptionType;


  uint32_t WRPState;


  uint32_t WRPPage;


  uint32_t Banks;


  uint8_t RDPLevel;
# 231 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_flash_ex.h"
  uint8_t USERConfig;





  uint32_t DATAAddress;


  uint8_t DATAData;

} FLASH_OBProgramInitTypeDef;
# 768 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_flash_ex.h"
HAL_StatusTypeDef HAL_FLASHEx_Erase(FLASH_EraseInitTypeDef *pEraseInit, uint32_t *PageError);
HAL_StatusTypeDef HAL_FLASHEx_Erase_IT(FLASH_EraseInitTypeDef *pEraseInit);
# 779 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_flash_ex.h"
HAL_StatusTypeDef HAL_FLASHEx_OBErase(void);
HAL_StatusTypeDef HAL_FLASHEx_OBProgram(FLASH_OBProgramInitTypeDef *pOBInit);
void HAL_FLASHEx_OBGetConfig(FLASH_OBProgramInitTypeDef *pOBInit);
uint32_t HAL_FLASHEx_OBGetUserData(uint32_t DATAAdress);
# 267 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_flash.h" 2
# 277 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_flash.h"
HAL_StatusTypeDef HAL_FLASH_Program(uint32_t TypeProgram, uint32_t Address, uint64_t Data);
HAL_StatusTypeDef HAL_FLASH_Program_IT(uint32_t TypeProgram, uint32_t Address, uint64_t Data);


void HAL_FLASH_IRQHandler(void);

void HAL_FLASH_EndOfOperationCallback(uint32_t ReturnValue);
void HAL_FLASH_OperationErrorCallback(uint32_t ReturnValue);
# 294 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_flash.h"
HAL_StatusTypeDef HAL_FLASH_Unlock(void);
HAL_StatusTypeDef HAL_FLASH_Lock(void);
HAL_StatusTypeDef HAL_FLASH_OB_Unlock(void);
HAL_StatusTypeDef HAL_FLASH_OB_Lock(void);
void HAL_FLASH_OB_Launch(void);
# 308 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_flash.h"
uint32_t HAL_FLASH_GetError(void);
# 322 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_flash.h"
HAL_StatusTypeDef FLASH_WaitForLastOperation(uint32_t Timeout);
# 259 "Inc/stm32f1xx_hal_conf.h" 2
# 270 "Inc/stm32f1xx_hal_conf.h"
# 1 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_i2c.h" 1
# 65 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_i2c.h"
typedef struct
{
  uint32_t ClockSpeed;


  uint32_t DutyCycle;


  uint32_t OwnAddress1;


  uint32_t AddressingMode;


  uint32_t DualAddressMode;


  uint32_t OwnAddress2;


  uint32_t GeneralCallMode;


  uint32_t NoStretchMode;


}I2C_InitTypeDef;
# 119 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_i2c.h"
typedef enum
{
  HAL_I2C_STATE_RESET = 0x00U,
  HAL_I2C_STATE_READY = 0x20U,
  HAL_I2C_STATE_BUSY = 0x24U,
  HAL_I2C_STATE_BUSY_TX = 0x21U,
  HAL_I2C_STATE_BUSY_RX = 0x22U,
  HAL_I2C_STATE_LISTEN = 0x28U,
  HAL_I2C_STATE_BUSY_TX_LISTEN = 0x29U,

  HAL_I2C_STATE_BUSY_RX_LISTEN = 0x2AU,

  HAL_I2C_STATE_ABORT = 0x60U,
  HAL_I2C_STATE_TIMEOUT = 0xA0U,
  HAL_I2C_STATE_ERROR = 0xE0U

}HAL_I2C_StateTypeDef;
# 154 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_i2c.h"
typedef enum
{
  HAL_I2C_MODE_NONE = 0x00U,
  HAL_I2C_MODE_MASTER = 0x10U,
  HAL_I2C_MODE_SLAVE = 0x20U,
  HAL_I2C_MODE_MEM = 0x40U

}HAL_I2C_ModeTypeDef;




typedef struct
{
  I2C_TypeDef *Instance;

  I2C_InitTypeDef Init;

  uint8_t *pBuffPtr;

  uint16_t XferSize;

  volatile uint16_t XferCount;

  volatile uint32_t XferOptions;

  volatile uint32_t PreviousState;


  DMA_HandleTypeDef *hdmatx;

  DMA_HandleTypeDef *hdmarx;

  HAL_LockTypeDef Lock;

  volatile HAL_I2C_StateTypeDef State;

  volatile HAL_I2C_ModeTypeDef Mode;

  volatile uint32_t ErrorCode;

  volatile uint32_t Devaddress;

  volatile uint32_t Memaddress;

  volatile uint32_t MemaddSize;

  volatile uint32_t EventCount;

}I2C_HandleTypeDef;
# 483 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_i2c.h"
HAL_StatusTypeDef HAL_I2C_Init(I2C_HandleTypeDef *hi2c);
HAL_StatusTypeDef HAL_I2C_DeInit (I2C_HandleTypeDef *hi2c);
void HAL_I2C_MspInit(I2C_HandleTypeDef *hi2c);
void HAL_I2C_MspDeInit(I2C_HandleTypeDef *hi2c);
# 496 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_i2c.h"
HAL_StatusTypeDef HAL_I2C_Master_Transmit(I2C_HandleTypeDef *hi2c, uint16_t DevAddress, uint8_t *pData, uint16_t Size, uint32_t Timeout);
HAL_StatusTypeDef HAL_I2C_Master_Receive(I2C_HandleTypeDef *hi2c, uint16_t DevAddress, uint8_t *pData, uint16_t Size, uint32_t Timeout);
HAL_StatusTypeDef HAL_I2C_Slave_Transmit(I2C_HandleTypeDef *hi2c, uint8_t *pData, uint16_t Size, uint32_t Timeout);
HAL_StatusTypeDef HAL_I2C_Slave_Receive(I2C_HandleTypeDef *hi2c, uint8_t *pData, uint16_t Size, uint32_t Timeout);
HAL_StatusTypeDef HAL_I2C_Mem_Write(I2C_HandleTypeDef *hi2c, uint16_t DevAddress, uint16_t MemAddress, uint16_t MemAddSize, uint8_t *pData, uint16_t Size, uint32_t Timeout);
HAL_StatusTypeDef HAL_I2C_Mem_Read(I2C_HandleTypeDef *hi2c, uint16_t DevAddress, uint16_t MemAddress, uint16_t MemAddSize, uint8_t *pData, uint16_t Size, uint32_t Timeout);
HAL_StatusTypeDef HAL_I2C_IsDeviceReady(I2C_HandleTypeDef *hi2c, uint16_t DevAddress, uint32_t Trials, uint32_t Timeout);


HAL_StatusTypeDef HAL_I2C_Master_Transmit_IT(I2C_HandleTypeDef *hi2c, uint16_t DevAddress, uint8_t *pData, uint16_t Size);
HAL_StatusTypeDef HAL_I2C_Master_Receive_IT(I2C_HandleTypeDef *hi2c, uint16_t DevAddress, uint8_t *pData, uint16_t Size);
HAL_StatusTypeDef HAL_I2C_Slave_Transmit_IT(I2C_HandleTypeDef *hi2c, uint8_t *pData, uint16_t Size);
HAL_StatusTypeDef HAL_I2C_Slave_Receive_IT(I2C_HandleTypeDef *hi2c, uint8_t *pData, uint16_t Size);
HAL_StatusTypeDef HAL_I2C_Mem_Write_IT(I2C_HandleTypeDef *hi2c, uint16_t DevAddress, uint16_t MemAddress, uint16_t MemAddSize, uint8_t *pData, uint16_t Size);
HAL_StatusTypeDef HAL_I2C_Mem_Read_IT(I2C_HandleTypeDef *hi2c, uint16_t DevAddress, uint16_t MemAddress, uint16_t MemAddSize, uint8_t *pData, uint16_t Size);

HAL_StatusTypeDef HAL_I2C_Master_Sequential_Transmit_IT(I2C_HandleTypeDef *hi2c, uint16_t DevAddress, uint8_t *pData, uint16_t Size, uint32_t XferOptions);
HAL_StatusTypeDef HAL_I2C_Master_Sequential_Receive_IT(I2C_HandleTypeDef *hi2c, uint16_t DevAddress, uint8_t *pData, uint16_t Size, uint32_t XferOptions);
HAL_StatusTypeDef HAL_I2C_Slave_Sequential_Transmit_IT(I2C_HandleTypeDef *hi2c, uint8_t *pData, uint16_t Size, uint32_t XferOptions);
HAL_StatusTypeDef HAL_I2C_Slave_Sequential_Receive_IT(I2C_HandleTypeDef *hi2c, uint8_t *pData, uint16_t Size, uint32_t XferOptions);
HAL_StatusTypeDef HAL_I2C_Master_Abort_IT(I2C_HandleTypeDef *hi2c, uint16_t DevAddress);
HAL_StatusTypeDef HAL_I2C_EnableListen_IT(I2C_HandleTypeDef *hi2c);
HAL_StatusTypeDef HAL_I2C_DisableListen_IT(I2C_HandleTypeDef *hi2c);


HAL_StatusTypeDef HAL_I2C_Master_Transmit_DMA(I2C_HandleTypeDef *hi2c, uint16_t DevAddress, uint8_t *pData, uint16_t Size);
HAL_StatusTypeDef HAL_I2C_Master_Receive_DMA(I2C_HandleTypeDef *hi2c, uint16_t DevAddress, uint8_t *pData, uint16_t Size);
HAL_StatusTypeDef HAL_I2C_Slave_Transmit_DMA(I2C_HandleTypeDef *hi2c, uint8_t *pData, uint16_t Size);
HAL_StatusTypeDef HAL_I2C_Slave_Receive_DMA(I2C_HandleTypeDef *hi2c, uint8_t *pData, uint16_t Size);
HAL_StatusTypeDef HAL_I2C_Mem_Write_DMA(I2C_HandleTypeDef *hi2c, uint16_t DevAddress, uint16_t MemAddress, uint16_t MemAddSize, uint8_t *pData, uint16_t Size);
HAL_StatusTypeDef HAL_I2C_Mem_Read_DMA(I2C_HandleTypeDef *hi2c, uint16_t DevAddress, uint16_t MemAddress, uint16_t MemAddSize, uint8_t *pData, uint16_t Size);


void HAL_I2C_EV_IRQHandler(I2C_HandleTypeDef *hi2c);
void HAL_I2C_ER_IRQHandler(I2C_HandleTypeDef *hi2c);
void HAL_I2C_MasterTxCpltCallback(I2C_HandleTypeDef *hi2c);
void HAL_I2C_MasterRxCpltCallback(I2C_HandleTypeDef *hi2c);
void HAL_I2C_SlaveTxCpltCallback(I2C_HandleTypeDef *hi2c);
void HAL_I2C_SlaveRxCpltCallback(I2C_HandleTypeDef *hi2c);
void HAL_I2C_AddrCallback(I2C_HandleTypeDef *hi2c, uint8_t TransferDirection, uint16_t AddrMatchCode);
void HAL_I2C_ListenCpltCallback(I2C_HandleTypeDef *hi2c);
void HAL_I2C_MemTxCpltCallback(I2C_HandleTypeDef *hi2c);
void HAL_I2C_MemRxCpltCallback(I2C_HandleTypeDef *hi2c);
void HAL_I2C_ErrorCallback(I2C_HandleTypeDef *hi2c);
void HAL_I2C_AbortCpltCallback(I2C_HandleTypeDef *hi2c);
# 549 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_i2c.h"
HAL_I2C_StateTypeDef HAL_I2C_GetState(I2C_HandleTypeDef *hi2c);
HAL_I2C_ModeTypeDef HAL_I2C_GetMode(I2C_HandleTypeDef *hi2c);
uint32_t HAL_I2C_GetError(I2C_HandleTypeDef *hi2c);
# 271 "Inc/stm32f1xx_hal_conf.h" 2
# 282 "Inc/stm32f1xx_hal_conf.h"
# 1 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_pwr.h" 1
# 66 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_pwr.h"
typedef struct
{
  uint32_t PVDLevel;


  uint32_t Mode;

}PWR_PVDTypeDef;
# 347 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_pwr.h"
void HAL_PWR_DeInit(void);
void HAL_PWR_EnableBkUpAccess(void);
void HAL_PWR_DisableBkUpAccess(void);
# 360 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_pwr.h"
void HAL_PWR_ConfigPVD(PWR_PVDTypeDef *sConfigPVD);

void HAL_PWR_EnablePVD(void);
void HAL_PWR_DisablePVD(void);


void HAL_PWR_EnableWakeUpPin(uint32_t WakeUpPinx);
void HAL_PWR_DisableWakeUpPin(uint32_t WakeUpPinx);


void HAL_PWR_EnterSTOPMode(uint32_t Regulator, uint8_t STOPEntry);
void HAL_PWR_EnterSLEEPMode(uint32_t Regulator, uint8_t SLEEPEntry);
void HAL_PWR_EnterSTANDBYMode(void);

void HAL_PWR_EnableSleepOnExit(void);
void HAL_PWR_DisableSleepOnExit(void);
void HAL_PWR_EnableSEVOnPend(void);
void HAL_PWR_DisableSEVOnPend(void);



void HAL_PWR_PVD_IRQHandler(void);
void HAL_PWR_PVDCallback(void);
# 283 "Inc/stm32f1xx_hal_conf.h" 2
# 310 "Inc/stm32f1xx_hal_conf.h"
# 1 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_tim.h" 1
# 64 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_tim.h"
typedef struct
{
  uint32_t Prescaler;


  uint32_t CounterMode;


  uint32_t Period;



  uint32_t ClockDivision;


  uint32_t RepetitionCounter;
# 88 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_tim.h"
  uint32_t AutoReloadPreload;

} TIM_Base_InitTypeDef;




typedef struct
{
  uint32_t OCMode;


  uint32_t Pulse;


  uint32_t OCPolarity;


  uint32_t OCNPolarity;



  uint32_t OCFastMode;




  uint32_t OCIdleState;



  uint32_t OCNIdleState;


} TIM_OC_InitTypeDef;




typedef struct
{
  uint32_t OCMode;


  uint32_t Pulse;


  uint32_t OCPolarity;


  uint32_t OCNPolarity;



  uint32_t OCIdleState;



  uint32_t OCNIdleState;



  uint32_t ICPolarity;


  uint32_t ICSelection;


  uint32_t ICFilter;

} TIM_OnePulse_InitTypeDef;





typedef struct
{
  uint32_t ICPolarity;


  uint32_t ICSelection;


  uint32_t ICPrescaler;


  uint32_t ICFilter;

} TIM_IC_InitTypeDef;




typedef struct
{
  uint32_t EncoderMode;


  uint32_t IC1Polarity;


  uint32_t IC1Selection;


  uint32_t IC1Prescaler;


  uint32_t IC1Filter;


  uint32_t IC2Polarity;


  uint32_t IC2Selection;


  uint32_t IC2Prescaler;


  uint32_t IC2Filter;

} TIM_Encoder_InitTypeDef;





typedef struct
{
  uint32_t ClockSource;

  uint32_t ClockPolarity;

  uint32_t ClockPrescaler;

  uint32_t ClockFilter;

}TIM_ClockConfigTypeDef;




typedef struct
{
  uint32_t ClearInputState;

  uint32_t ClearInputSource;

  uint32_t ClearInputPolarity;

  uint32_t ClearInputPrescaler;

  uint32_t ClearInputFilter;

}TIM_ClearInputConfigTypeDef;




typedef struct {
  uint32_t SlaveMode;

  uint32_t InputTrigger;

  uint32_t TriggerPolarity;

  uint32_t TriggerPrescaler;

  uint32_t TriggerFilter;


}TIM_SlaveConfigTypeDef;




typedef enum
{
  HAL_TIM_STATE_RESET = 0x00U,
  HAL_TIM_STATE_READY = 0x01U,
  HAL_TIM_STATE_BUSY = 0x02U,
  HAL_TIM_STATE_TIMEOUT = 0x03U,
  HAL_TIM_STATE_ERROR = 0x04U
}HAL_TIM_StateTypeDef;




typedef enum
{
  HAL_TIM_ACTIVE_CHANNEL_1 = 0x01U,
  HAL_TIM_ACTIVE_CHANNEL_2 = 0x02U,
  HAL_TIM_ACTIVE_CHANNEL_3 = 0x04U,
  HAL_TIM_ACTIVE_CHANNEL_4 = 0x08U,
  HAL_TIM_ACTIVE_CHANNEL_CLEARED = 0x00U
}HAL_TIM_ActiveChannel;




typedef struct
{
  TIM_TypeDef *Instance;
  TIM_Base_InitTypeDef Init;
  HAL_TIM_ActiveChannel Channel;
  DMA_HandleTypeDef *hdma[7U];

  HAL_LockTypeDef Lock;
  volatile HAL_TIM_StateTypeDef State;
}TIM_HandleTypeDef;
# 1167 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_tim.h"
void TIM_Base_SetConfig(TIM_TypeDef *TIMx, TIM_Base_InitTypeDef *Structure);
void TIM_TI1_SetConfig(TIM_TypeDef *TIMx, uint32_t TIM_ICPolarity, uint32_t TIM_ICSelection, uint32_t TIM_ICFilter);
void TIM_OC2_SetConfig(TIM_TypeDef *TIMx, TIM_OC_InitTypeDef *OC_Config);
void TIM_DMADelayPulseCplt(DMA_HandleTypeDef *hdma);
void TIM_DMAError(DMA_HandleTypeDef *hdma);
void TIM_DMACaptureCplt(DMA_HandleTypeDef *hdma);
void TIM_CCxChannelCmd(TIM_TypeDef* TIMx, uint32_t Channel, uint32_t ChannelState);
# 1579 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_tim.h"
# 1 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_tim_ex.h" 1
# 67 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_tim_ex.h"
typedef struct
{

  uint32_t IC1Polarity;


  uint32_t IC1Prescaler;


  uint32_t IC1Filter;

  uint32_t Commutation_Delay;

} TIM_HallSensor_InitTypeDef;
# 90 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_tim_ex.h"
typedef struct
{
  uint32_t OffStateRunMode;

  uint32_t OffStateIDLEMode;

  uint32_t LockLevel;

  uint32_t DeadTime;

  uint32_t BreakState;

  uint32_t BreakPolarity;

  uint32_t AutomaticOutput;

} TIM_BreakDeadTimeConfigTypeDef;
# 115 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_tim_ex.h"
typedef struct {
  uint32_t MasterOutputTrigger;

  uint32_t MasterSlaveMode;

}TIM_MasterConfigTypeDef;
# 193 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_tim_ex.h"
HAL_StatusTypeDef HAL_TIMEx_HallSensor_Init(TIM_HandleTypeDef *htim, TIM_HallSensor_InitTypeDef* sConfig);
HAL_StatusTypeDef HAL_TIMEx_HallSensor_DeInit(TIM_HandleTypeDef *htim);

void HAL_TIMEx_HallSensor_MspInit(TIM_HandleTypeDef *htim);
void HAL_TIMEx_HallSensor_MspDeInit(TIM_HandleTypeDef *htim);


HAL_StatusTypeDef HAL_TIMEx_HallSensor_Start(TIM_HandleTypeDef *htim);
HAL_StatusTypeDef HAL_TIMEx_HallSensor_Stop(TIM_HandleTypeDef *htim);

HAL_StatusTypeDef HAL_TIMEx_HallSensor_Start_IT(TIM_HandleTypeDef *htim);
HAL_StatusTypeDef HAL_TIMEx_HallSensor_Stop_IT(TIM_HandleTypeDef *htim);

HAL_StatusTypeDef HAL_TIMEx_HallSensor_Start_DMA(TIM_HandleTypeDef *htim, uint32_t *pData, uint16_t Length);
HAL_StatusTypeDef HAL_TIMEx_HallSensor_Stop_DMA(TIM_HandleTypeDef *htim);
# 221 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_tim_ex.h"
HAL_StatusTypeDef HAL_TIMEx_OCN_Start(TIM_HandleTypeDef *htim, uint32_t Channel);
HAL_StatusTypeDef HAL_TIMEx_OCN_Stop(TIM_HandleTypeDef *htim, uint32_t Channel);


HAL_StatusTypeDef HAL_TIMEx_OCN_Start_IT(TIM_HandleTypeDef *htim, uint32_t Channel);
HAL_StatusTypeDef HAL_TIMEx_OCN_Stop_IT(TIM_HandleTypeDef *htim, uint32_t Channel);


HAL_StatusTypeDef HAL_TIMEx_OCN_Start_DMA(TIM_HandleTypeDef *htim, uint32_t Channel, uint32_t *pData, uint16_t Length);
HAL_StatusTypeDef HAL_TIMEx_OCN_Stop_DMA(TIM_HandleTypeDef *htim, uint32_t Channel);
# 240 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_tim_ex.h"
HAL_StatusTypeDef HAL_TIMEx_PWMN_Start(TIM_HandleTypeDef *htim, uint32_t Channel);
HAL_StatusTypeDef HAL_TIMEx_PWMN_Stop(TIM_HandleTypeDef *htim, uint32_t Channel);


HAL_StatusTypeDef HAL_TIMEx_PWMN_Start_IT(TIM_HandleTypeDef *htim, uint32_t Channel);
HAL_StatusTypeDef HAL_TIMEx_PWMN_Stop_IT(TIM_HandleTypeDef *htim, uint32_t Channel);

HAL_StatusTypeDef HAL_TIMEx_PWMN_Start_DMA(TIM_HandleTypeDef *htim, uint32_t Channel, uint32_t *pData, uint16_t Length);
HAL_StatusTypeDef HAL_TIMEx_PWMN_Stop_DMA(TIM_HandleTypeDef *htim, uint32_t Channel);
# 258 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_tim_ex.h"
HAL_StatusTypeDef HAL_TIMEx_OnePulseN_Start(TIM_HandleTypeDef *htim, uint32_t OutputChannel);
HAL_StatusTypeDef HAL_TIMEx_OnePulseN_Stop(TIM_HandleTypeDef *htim, uint32_t OutputChannel);


HAL_StatusTypeDef HAL_TIMEx_OnePulseN_Start_IT(TIM_HandleTypeDef *htim, uint32_t OutputChannel);
HAL_StatusTypeDef HAL_TIMEx_OnePulseN_Stop_IT(TIM_HandleTypeDef *htim, uint32_t OutputChannel);
# 278 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_tim_ex.h"
HAL_StatusTypeDef HAL_TIMEx_ConfigCommutationEvent(TIM_HandleTypeDef *htim, uint32_t InputTrigger, uint32_t CommutationSource);
HAL_StatusTypeDef HAL_TIMEx_ConfigCommutationEvent_IT(TIM_HandleTypeDef *htim, uint32_t InputTrigger, uint32_t CommutationSource);
HAL_StatusTypeDef HAL_TIMEx_ConfigCommutationEvent_DMA(TIM_HandleTypeDef *htim, uint32_t InputTrigger, uint32_t CommutationSource);
HAL_StatusTypeDef HAL_TIMEx_ConfigBreakDeadTime(TIM_HandleTypeDef *htim, TIM_BreakDeadTimeConfigTypeDef *sBreakDeadTimeConfig);



HAL_StatusTypeDef HAL_TIMEx_MasterConfigSynchronization(TIM_HandleTypeDef *htim, TIM_MasterConfigTypeDef * sMasterConfig);
# 294 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_tim_ex.h"
void HAL_TIMEx_CommutationCallback(TIM_HandleTypeDef *htim);
void HAL_TIMEx_BreakCallback(TIM_HandleTypeDef *htim);
# 307 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_tim_ex.h"
HAL_TIM_StateTypeDef HAL_TIMEx_HallSensor_GetState(TIM_HandleTypeDef *htim);
# 324 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_tim_ex.h"
void TIMEx_DMACommutationCplt(DMA_HandleTypeDef *hdma);
# 1580 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_tim.h" 2
# 1590 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_tim.h"
HAL_StatusTypeDef HAL_TIM_Base_Init(TIM_HandleTypeDef *htim);
HAL_StatusTypeDef HAL_TIM_Base_DeInit(TIM_HandleTypeDef *htim);
void HAL_TIM_Base_MspInit(TIM_HandleTypeDef *htim);
void HAL_TIM_Base_MspDeInit(TIM_HandleTypeDef *htim);

HAL_StatusTypeDef HAL_TIM_Base_Start(TIM_HandleTypeDef *htim);
HAL_StatusTypeDef HAL_TIM_Base_Stop(TIM_HandleTypeDef *htim);

HAL_StatusTypeDef HAL_TIM_Base_Start_IT(TIM_HandleTypeDef *htim);
HAL_StatusTypeDef HAL_TIM_Base_Stop_IT(TIM_HandleTypeDef *htim);

HAL_StatusTypeDef HAL_TIM_Base_Start_DMA(TIM_HandleTypeDef *htim, uint32_t *pData, uint16_t Length);
HAL_StatusTypeDef HAL_TIM_Base_Stop_DMA(TIM_HandleTypeDef *htim);
# 1611 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_tim.h"
HAL_StatusTypeDef HAL_TIM_OC_Init(TIM_HandleTypeDef *htim);
HAL_StatusTypeDef HAL_TIM_OC_DeInit(TIM_HandleTypeDef *htim);
void HAL_TIM_OC_MspInit(TIM_HandleTypeDef *htim);
void HAL_TIM_OC_MspDeInit(TIM_HandleTypeDef *htim);

HAL_StatusTypeDef HAL_TIM_OC_Start(TIM_HandleTypeDef *htim, uint32_t Channel);
HAL_StatusTypeDef HAL_TIM_OC_Stop(TIM_HandleTypeDef *htim, uint32_t Channel);

HAL_StatusTypeDef HAL_TIM_OC_Start_IT(TIM_HandleTypeDef *htim, uint32_t Channel);
HAL_StatusTypeDef HAL_TIM_OC_Stop_IT(TIM_HandleTypeDef *htim, uint32_t Channel);

HAL_StatusTypeDef HAL_TIM_OC_Start_DMA(TIM_HandleTypeDef *htim, uint32_t Channel, uint32_t *pData, uint16_t Length);
HAL_StatusTypeDef HAL_TIM_OC_Stop_DMA(TIM_HandleTypeDef *htim, uint32_t Channel);
# 1633 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_tim.h"
HAL_StatusTypeDef HAL_TIM_PWM_Init(TIM_HandleTypeDef *htim);
HAL_StatusTypeDef HAL_TIM_PWM_DeInit(TIM_HandleTypeDef *htim);
void HAL_TIM_PWM_MspInit(TIM_HandleTypeDef *htim);
void HAL_TIM_PWM_MspDeInit(TIM_HandleTypeDef *htim);

HAL_StatusTypeDef HAL_TIM_PWM_Start(TIM_HandleTypeDef *htim, uint32_t Channel);
HAL_StatusTypeDef HAL_TIM_PWM_Stop(TIM_HandleTypeDef *htim, uint32_t Channel);

HAL_StatusTypeDef HAL_TIM_PWM_Start_IT(TIM_HandleTypeDef *htim, uint32_t Channel);
HAL_StatusTypeDef HAL_TIM_PWM_Stop_IT(TIM_HandleTypeDef *htim, uint32_t Channel);

HAL_StatusTypeDef HAL_TIM_PWM_Start_DMA(TIM_HandleTypeDef *htim, uint32_t Channel, uint32_t *pData, uint16_t Length);
HAL_StatusTypeDef HAL_TIM_PWM_Stop_DMA(TIM_HandleTypeDef *htim, uint32_t Channel);
# 1654 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_tim.h"
HAL_StatusTypeDef HAL_TIM_IC_Init(TIM_HandleTypeDef *htim);
HAL_StatusTypeDef HAL_TIM_IC_DeInit(TIM_HandleTypeDef *htim);
void HAL_TIM_IC_MspInit(TIM_HandleTypeDef *htim);
void HAL_TIM_IC_MspDeInit(TIM_HandleTypeDef *htim);

HAL_StatusTypeDef HAL_TIM_IC_Start(TIM_HandleTypeDef *htim, uint32_t Channel);
HAL_StatusTypeDef HAL_TIM_IC_Stop(TIM_HandleTypeDef *htim, uint32_t Channel);

HAL_StatusTypeDef HAL_TIM_IC_Start_IT(TIM_HandleTypeDef *htim, uint32_t Channel);
HAL_StatusTypeDef HAL_TIM_IC_Stop_IT(TIM_HandleTypeDef *htim, uint32_t Channel);

HAL_StatusTypeDef HAL_TIM_IC_Start_DMA(TIM_HandleTypeDef *htim, uint32_t Channel, uint32_t *pData, uint16_t Length);
HAL_StatusTypeDef HAL_TIM_IC_Stop_DMA(TIM_HandleTypeDef *htim, uint32_t Channel);
# 1675 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_tim.h"
HAL_StatusTypeDef HAL_TIM_OnePulse_Init(TIM_HandleTypeDef *htim, uint32_t OnePulseMode);
HAL_StatusTypeDef HAL_TIM_OnePulse_DeInit(TIM_HandleTypeDef *htim);
void HAL_TIM_OnePulse_MspInit(TIM_HandleTypeDef *htim);
void HAL_TIM_OnePulse_MspDeInit(TIM_HandleTypeDef *htim);

HAL_StatusTypeDef HAL_TIM_OnePulse_Start(TIM_HandleTypeDef *htim, uint32_t OutputChannel);
HAL_StatusTypeDef HAL_TIM_OnePulse_Stop(TIM_HandleTypeDef *htim, uint32_t OutputChannel);

HAL_StatusTypeDef HAL_TIM_OnePulse_Start_IT(TIM_HandleTypeDef *htim, uint32_t OutputChannel);
HAL_StatusTypeDef HAL_TIM_OnePulse_Stop_IT(TIM_HandleTypeDef *htim, uint32_t OutputChannel);
# 1693 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_tim.h"
HAL_StatusTypeDef HAL_TIM_Encoder_Init(TIM_HandleTypeDef *htim, TIM_Encoder_InitTypeDef* sConfig);
HAL_StatusTypeDef HAL_TIM_Encoder_DeInit(TIM_HandleTypeDef *htim);
void HAL_TIM_Encoder_MspInit(TIM_HandleTypeDef *htim);
void HAL_TIM_Encoder_MspDeInit(TIM_HandleTypeDef *htim);

HAL_StatusTypeDef HAL_TIM_Encoder_Start(TIM_HandleTypeDef *htim, uint32_t Channel);
HAL_StatusTypeDef HAL_TIM_Encoder_Stop(TIM_HandleTypeDef *htim, uint32_t Channel);

HAL_StatusTypeDef HAL_TIM_Encoder_Start_IT(TIM_HandleTypeDef *htim, uint32_t Channel);
HAL_StatusTypeDef HAL_TIM_Encoder_Stop_IT(TIM_HandleTypeDef *htim, uint32_t Channel);

HAL_StatusTypeDef HAL_TIM_Encoder_Start_DMA(TIM_HandleTypeDef *htim, uint32_t Channel, uint32_t *pData1, uint32_t *pData2, uint16_t Length);
HAL_StatusTypeDef HAL_TIM_Encoder_Stop_DMA(TIM_HandleTypeDef *htim, uint32_t Channel);
# 1715 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_tim.h"
void HAL_TIM_IRQHandler(TIM_HandleTypeDef *htim);
# 1724 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_tim.h"
HAL_StatusTypeDef HAL_TIM_OC_ConfigChannel(TIM_HandleTypeDef *htim, TIM_OC_InitTypeDef* sConfig, uint32_t Channel);
HAL_StatusTypeDef HAL_TIM_PWM_ConfigChannel(TIM_HandleTypeDef *htim, TIM_OC_InitTypeDef* sConfig, uint32_t Channel);
HAL_StatusTypeDef HAL_TIM_IC_ConfigChannel(TIM_HandleTypeDef *htim, TIM_IC_InitTypeDef* sConfig, uint32_t Channel);
HAL_StatusTypeDef HAL_TIM_OnePulse_ConfigChannel(TIM_HandleTypeDef *htim, TIM_OnePulse_InitTypeDef* sConfig, uint32_t OutputChannel, uint32_t InputChannel);
HAL_StatusTypeDef HAL_TIM_ConfigOCrefClear(TIM_HandleTypeDef *htim, TIM_ClearInputConfigTypeDef * sClearInputConfig, uint32_t Channel);
HAL_StatusTypeDef HAL_TIM_ConfigClockSource(TIM_HandleTypeDef *htim, TIM_ClockConfigTypeDef * sClockSourceConfig);
HAL_StatusTypeDef HAL_TIM_ConfigTI1Input(TIM_HandleTypeDef *htim, uint32_t TI1_Selection);
HAL_StatusTypeDef HAL_TIM_SlaveConfigSynchronization(TIM_HandleTypeDef *htim, TIM_SlaveConfigTypeDef * sSlaveConfig);
HAL_StatusTypeDef HAL_TIM_SlaveConfigSynchronization_IT(TIM_HandleTypeDef *htim, TIM_SlaveConfigTypeDef * sSlaveConfig);
HAL_StatusTypeDef HAL_TIM_DMABurst_WriteStart(TIM_HandleTypeDef *htim, uint32_t BurstBaseAddress, uint32_t BurstRequestSrc,
                                              uint32_t *BurstBuffer, uint32_t BurstLength);
HAL_StatusTypeDef HAL_TIM_DMABurst_WriteStop(TIM_HandleTypeDef *htim, uint32_t BurstRequestSrc);
HAL_StatusTypeDef HAL_TIM_DMABurst_ReadStart(TIM_HandleTypeDef *htim, uint32_t BurstBaseAddress, uint32_t BurstRequestSrc,
                                              uint32_t *BurstBuffer, uint32_t BurstLength);
HAL_StatusTypeDef HAL_TIM_DMABurst_ReadStop(TIM_HandleTypeDef *htim, uint32_t BurstRequestSrc);
HAL_StatusTypeDef HAL_TIM_GenerateEvent(TIM_HandleTypeDef *htim, uint32_t EventSource);
uint32_t HAL_TIM_ReadCapturedValue(TIM_HandleTypeDef *htim, uint32_t Channel);
# 1750 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_tim.h"
void HAL_TIM_PeriodElapsedCallback(TIM_HandleTypeDef *htim);
void HAL_TIM_OC_DelayElapsedCallback(TIM_HandleTypeDef *htim);
void HAL_TIM_IC_CaptureCallback(TIM_HandleTypeDef *htim);
void HAL_TIM_PWM_PulseFinishedCallback(TIM_HandleTypeDef *htim);
void HAL_TIM_TriggerCallback(TIM_HandleTypeDef *htim);
void HAL_TIM_ErrorCallback(TIM_HandleTypeDef *htim);
# 1764 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_tim.h"
HAL_TIM_StateTypeDef HAL_TIM_Base_GetState(TIM_HandleTypeDef *htim);
HAL_TIM_StateTypeDef HAL_TIM_OC_GetState(TIM_HandleTypeDef *htim);
HAL_TIM_StateTypeDef HAL_TIM_PWM_GetState(TIM_HandleTypeDef *htim);
HAL_TIM_StateTypeDef HAL_TIM_IC_GetState(TIM_HandleTypeDef *htim);
HAL_TIM_StateTypeDef HAL_TIM_OnePulse_GetState(TIM_HandleTypeDef *htim);
HAL_TIM_StateTypeDef HAL_TIM_Encoder_GetState(TIM_HandleTypeDef *htim);
# 311 "Inc/stm32f1xx_hal_conf.h" 2



# 1 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_uart.h" 1
# 65 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_uart.h"
typedef struct
{
  uint32_t BaudRate;




  uint32_t WordLength;


  uint32_t StopBits;


  uint32_t Parity;






  uint32_t Mode;


  uint32_t HwFlowCtl;


  uint32_t OverSampling;


}UART_InitTypeDef;
# 135 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_uart.h"
typedef enum
{
  HAL_UART_STATE_RESET = 0x00U,

  HAL_UART_STATE_READY = 0x20U,

  HAL_UART_STATE_BUSY = 0x24U,

  HAL_UART_STATE_BUSY_TX = 0x21U,

  HAL_UART_STATE_BUSY_RX = 0x22U,

  HAL_UART_STATE_BUSY_TX_RX = 0x23U,


  HAL_UART_STATE_TIMEOUT = 0xA0U,

  HAL_UART_STATE_ERROR = 0xE0U

}HAL_UART_StateTypeDef;




typedef struct
{
  USART_TypeDef *Instance;

  UART_InitTypeDef Init;

  uint8_t *pTxBuffPtr;

  uint16_t TxXferSize;

  volatile uint16_t TxXferCount;

  uint8_t *pRxBuffPtr;

  uint16_t RxXferSize;

  volatile uint16_t RxXferCount;

  DMA_HandleTypeDef *hdmatx;

  DMA_HandleTypeDef *hdmarx;

  HAL_LockTypeDef Lock;

  volatile HAL_UART_StateTypeDef gState;



  volatile HAL_UART_StateTypeDef RxState;


  volatile uint32_t ErrorCode;
}UART_HandleTypeDef;
# 622 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_uart.h"
HAL_StatusTypeDef HAL_UART_Init(UART_HandleTypeDef *huart);
HAL_StatusTypeDef HAL_HalfDuplex_Init(UART_HandleTypeDef *huart);
HAL_StatusTypeDef HAL_LIN_Init(UART_HandleTypeDef *huart, uint32_t BreakDetectLength);
HAL_StatusTypeDef HAL_MultiProcessor_Init(UART_HandleTypeDef *huart, uint8_t Address, uint32_t WakeUpMethod);
HAL_StatusTypeDef HAL_UART_DeInit (UART_HandleTypeDef *huart);
void HAL_UART_MspInit(UART_HandleTypeDef *huart);
void HAL_UART_MspDeInit(UART_HandleTypeDef *huart);
# 637 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_uart.h"
HAL_StatusTypeDef HAL_UART_Transmit(UART_HandleTypeDef *huart, uint8_t *pData, uint16_t Size, uint32_t Timeout);
HAL_StatusTypeDef HAL_UART_Receive(UART_HandleTypeDef *huart, uint8_t *pData, uint16_t Size, uint32_t Timeout);
HAL_StatusTypeDef HAL_UART_Transmit_IT(UART_HandleTypeDef *huart, uint8_t *pData, uint16_t Size);
HAL_StatusTypeDef HAL_UART_Receive_IT(UART_HandleTypeDef *huart, uint8_t *pData, uint16_t Size);
HAL_StatusTypeDef HAL_UART_Transmit_DMA(UART_HandleTypeDef *huart, uint8_t *pData, uint16_t Size);
HAL_StatusTypeDef HAL_UART_Receive_DMA(UART_HandleTypeDef *huart, uint8_t *pData, uint16_t Size);
HAL_StatusTypeDef HAL_UART_DMAPause(UART_HandleTypeDef *huart);
HAL_StatusTypeDef HAL_UART_DMAResume(UART_HandleTypeDef *huart);
HAL_StatusTypeDef HAL_UART_DMAStop(UART_HandleTypeDef *huart);

HAL_StatusTypeDef HAL_UART_Abort(UART_HandleTypeDef *huart);
HAL_StatusTypeDef HAL_UART_AbortTransmit(UART_HandleTypeDef *huart);
HAL_StatusTypeDef HAL_UART_AbortReceive(UART_HandleTypeDef *huart);
HAL_StatusTypeDef HAL_UART_Abort_IT(UART_HandleTypeDef *huart);
HAL_StatusTypeDef HAL_UART_AbortTransmit_IT(UART_HandleTypeDef *huart);
HAL_StatusTypeDef HAL_UART_AbortReceive_IT(UART_HandleTypeDef *huart);

void HAL_UART_IRQHandler(UART_HandleTypeDef *huart);
void HAL_UART_TxCpltCallback(UART_HandleTypeDef *huart);
void HAL_UART_TxHalfCpltCallback(UART_HandleTypeDef *huart);
void HAL_UART_RxCpltCallback(UART_HandleTypeDef *huart);
void HAL_UART_RxHalfCpltCallback(UART_HandleTypeDef *huart);
void HAL_UART_ErrorCallback(UART_HandleTypeDef *huart);
void HAL_UART_AbortCpltCallback (UART_HandleTypeDef *huart);
void HAL_UART_AbortTransmitCpltCallback (UART_HandleTypeDef *huart);
void HAL_UART_AbortReceiveCpltCallback (UART_HandleTypeDef *huart);
# 671 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_uart.h"
HAL_StatusTypeDef HAL_LIN_SendBreak(UART_HandleTypeDef *huart);
HAL_StatusTypeDef HAL_MultiProcessor_EnterMuteMode(UART_HandleTypeDef *huart);
HAL_StatusTypeDef HAL_MultiProcessor_ExitMuteMode(UART_HandleTypeDef *huart);
HAL_StatusTypeDef HAL_HalfDuplex_EnableTransmitter(UART_HandleTypeDef *huart);
HAL_StatusTypeDef HAL_HalfDuplex_EnableReceiver(UART_HandleTypeDef *huart);
# 684 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal_uart.h"
HAL_UART_StateTypeDef HAL_UART_GetState(UART_HandleTypeDef *huart);
uint32_t HAL_UART_GetError(UART_HandleTypeDef *huart);
# 315 "Inc/stm32f1xx_hal_conf.h" 2
# 49 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal.h" 2
# 271 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal.h"
HAL_StatusTypeDef HAL_Init(void);
HAL_StatusTypeDef HAL_DeInit(void);
void HAL_MspInit(void);
void HAL_MspDeInit(void);
HAL_StatusTypeDef HAL_InitTick (uint32_t TickPriority);
# 284 "Drivers/STM32F1xx_HAL_Driver/Inc/stm32f1xx_hal.h"
void HAL_IncTick(void);
void HAL_Delay(volatile uint32_t Delay);
uint32_t HAL_GetTick(void);
void HAL_SuspendTick(void);
void HAL_ResumeTick(void);
uint32_t HAL_GetHalVersion(void);
uint32_t HAL_GetREVID(void);
uint32_t HAL_GetDEVID(void);
void HAL_DBGMCU_EnableDBGSleepMode(void);
void HAL_DBGMCU_DisableDBGSleepMode(void);
void HAL_DBGMCU_EnableDBGStopMode(void);
void HAL_DBGMCU_DisableDBGStopMode(void);
void HAL_DBGMCU_EnableDBGStandbyMode(void);
void HAL_DBGMCU_DisableDBGStandbyMode(void);
void HAL_GetUID(uint32_t *UID);
# 27 "Inc/defines.h" 2
# 1 "Inc/config.h" 1
# 28 "Inc/defines.h" 2
# 219 "Inc/defines.h"
typedef struct {
  uint16_t dcr;
  uint16_t dcl;
  uint16_t rlA;
  uint16_t rlB;
  uint16_t rrB;
  uint16_t rrC;
  uint16_t batt1;
  uint16_t l_tx2;
  uint16_t temp;
  uint16_t l_rx2;
} adc_buf_t;

typedef enum {
  NUNCHUK_CONNECTING,
  NUNCHUK_DISCONNECTED,
  NUNCHUK_RECONNECTING,
  NUNCHUK_CONNECTED
} nunchuk_state;


void I2C_Init(void);
nunchuk_state Nunchuk_Read(void);
void PPM_Init(void);
void PPM_ISR_Callback(void);
void PWM_Init(void);
void PWM_ISR_CH1_Callback(void);
void PWM_ISR_CH2_Callback(void);
# 39 "Src/setup.c" 2
# 1 "Inc/config.h" 1
# 40 "Src/setup.c" 2
# 1 "Inc/setup.h" 1
# 28 "Inc/setup.h"
void MX_GPIO_Init(void);
void MX_TIM_Init(void);
void MX_ADC1_Init(void);
void MX_ADC2_Init(void);
void UART2_Init(void);
void UART3_Init(void);
# 41 "Src/setup.c" 2

TIM_HandleTypeDef htim_right;
TIM_HandleTypeDef htim_left;
ADC_HandleTypeDef hadc1;
ADC_HandleTypeDef hadc2;
I2C_HandleTypeDef hi2c2;
UART_HandleTypeDef huart2;
UART_HandleTypeDef huart3;

DMA_HandleTypeDef hdma_usart2_rx;
DMA_HandleTypeDef hdma_usart2_tx;
DMA_HandleTypeDef hdma_usart3_rx;
DMA_HandleTypeDef hdma_usart3_tx;
volatile adc_buf_t adc_buffer;
# 85 "Src/setup.c"
void UART3_Init(void)
{

  do { volatile uint32_t tmpreg; ((((RCC_TypeDef *)((0x40000000U + 0x00020000U) + 0x00001000U))->AHBENR) |= ((0x1U << (0U)))); tmpreg = ((((RCC_TypeDef *)((0x40000000U + 0x00020000U) + 0x00001000U))->AHBENR) & ((0x1U << (0U)))); ((void)(tmpreg)); } while(0U);



  HAL_NVIC_SetPriority(DMA1_Channel2_IRQn, 1, 0);
  HAL_NVIC_EnableIRQ(DMA1_Channel2_IRQn);

  HAL_NVIC_SetPriority(DMA1_Channel3_IRQn, 1, 0);
  HAL_NVIC_EnableIRQ(DMA1_Channel3_IRQn);

  huart3.Instance = ((USART_TypeDef *)(0x40000000U + 0x00004800U));
  huart3.Init.BaudRate = 115200;
  huart3.Init.WordLength = 0x00000000U;
  huart3.Init.StopBits = 0x00000000U;
  huart3.Init.Parity = 0x00000000U;
  huart3.Init.Mode = ((uint32_t)((0x1U << (3U)) |(0x1U << (2U))));
  huart3.Init.HwFlowCtl = 0x00000000U;
  huart3.Init.OverSampling = 0x00000000U;
  HAL_UART_Init(&huart3);
}




void HAL_UART_MspInit(UART_HandleTypeDef* uartHandle)
{
  GPIO_InitTypeDef GPIO_InitStruct = {0};
  if(uartHandle->Instance==((USART_TypeDef *)(0x40000000U + 0x00004400U)))
  {




    do { volatile uint32_t tmpreg; ((((RCC_TypeDef *)((0x40000000U + 0x00020000U) + 0x00001000U))->APB1ENR) |= ((0x1U << (17U)))); tmpreg = ((((RCC_TypeDef *)((0x40000000U + 0x00020000U) + 0x00001000U))->APB1ENR) & ((0x1U << (17U)))); ((void)(tmpreg)); } while(0U);

    do { volatile uint32_t tmpreg; ((((RCC_TypeDef *)((0x40000000U + 0x00020000U) + 0x00001000U))->APB2ENR) |= ((0x1U << (2U)))); tmpreg = ((((RCC_TypeDef *)((0x40000000U + 0x00020000U) + 0x00001000U))->APB2ENR) & ((0x1U << (2U)))); ((void)(tmpreg)); } while(0U);




    GPIO_InitStruct.Pin = ((uint16_t)0x0004);
    GPIO_InitStruct.Mode = 0x00000002U;
    GPIO_InitStruct.Speed = ((0x3U << (0U)));
    HAL_GPIO_Init(((GPIO_TypeDef *)((0x40000000U + 0x00010000U) + 0x00000800U)), &GPIO_InitStruct);

    GPIO_InitStruct.Pin = ((uint16_t)0x0008);
    GPIO_InitStruct.Mode = 0x00000000U;
    GPIO_InitStruct.Pull = 0x00000001U;
    HAL_GPIO_Init(((GPIO_TypeDef *)((0x40000000U + 0x00010000U) + 0x00000800U)), &GPIO_InitStruct);



    hdma_usart2_rx.Instance = ((DMA_Channel_TypeDef *)((0x40000000U + 0x00020000U) + 0x0000006CU));
    hdma_usart2_rx.Init.Direction = 0x00000000U;
    hdma_usart2_rx.Init.PeriphInc = 0x00000000U;
    hdma_usart2_rx.Init.MemInc = ((uint32_t)(0x1U << (7U)));
    hdma_usart2_rx.Init.PeriphDataAlignment = 0x00000000U;
    hdma_usart2_rx.Init.MemDataAlignment = 0x00000000U;
    hdma_usart2_rx.Init.Mode = ((uint32_t)(0x1U << (5U)));
    hdma_usart2_rx.Init.Priority = 0x00000000U;
    HAL_DMA_Init(&hdma_usart2_rx);
    do{ (uartHandle)->hdmarx = &(hdma_usart2_rx); (hdma_usart2_rx).Parent = (uartHandle); } while(0U);


    hdma_usart2_tx.Instance = ((DMA_Channel_TypeDef *)((0x40000000U + 0x00020000U) + 0x00000080U));
    hdma_usart2_tx.Init.Direction = ((uint32_t)(0x1U << (4U)));
    hdma_usart2_tx.Init.PeriphInc = 0x00000000U;
    hdma_usart2_tx.Init.MemInc = ((uint32_t)(0x1U << (7U)));
    hdma_usart2_tx.Init.PeriphDataAlignment = 0x00000000U;
    hdma_usart2_tx.Init.MemDataAlignment = 0x00000000U;
    hdma_usart2_tx.Init.Mode = 0x00000000U;
    hdma_usart2_tx.Init.Priority = 0x00000000U;
    HAL_DMA_Init(&hdma_usart2_tx);
    do{ (uartHandle)->hdmatx = &(hdma_usart2_tx); (hdma_usart2_tx).Parent = (uartHandle); } while(0U);


    HAL_NVIC_SetPriority(USART2_IRQn, 1, 0);
    HAL_NVIC_EnableIRQ(USART2_IRQn);

 ((((((uint32_t)(1U << 28U | (0x1U << (4U))))) >> 28U) == 1U)? ((uartHandle)->Instance->CR1 |= ((((uint32_t)(1U << 28U | (0x1U << (4U))))) & 0x0000FFFFU)): (((((uint32_t)(1U << 28U | (0x1U << (4U))))) >> 28U) == 2U)? ((uartHandle)->Instance->CR2 |= ((((uint32_t)(1U << 28U | (0x1U << (4U))))) & 0x0000FFFFU)): ((uartHandle)->Instance->CR3 |= ((((uint32_t)(1U << 28U | (0x1U << (4U))))) & 0x0000FFFFU)));

  }
  else if(uartHandle->Instance==((USART_TypeDef *)(0x40000000U + 0x00004800U)))
  {




    do { volatile uint32_t tmpreg; ((((RCC_TypeDef *)((0x40000000U + 0x00020000U) + 0x00001000U))->APB1ENR) |= ((0x1U << (18U)))); tmpreg = ((((RCC_TypeDef *)((0x40000000U + 0x00020000U) + 0x00001000U))->APB1ENR) & ((0x1U << (18U)))); ((void)(tmpreg)); } while(0U);

    do { volatile uint32_t tmpreg; ((((RCC_TypeDef *)((0x40000000U + 0x00020000U) + 0x00001000U))->APB2ENR) |= ((0x1U << (3U)))); tmpreg = ((((RCC_TypeDef *)((0x40000000U + 0x00020000U) + 0x00001000U))->APB2ENR) & ((0x1U << (3U)))); ((void)(tmpreg)); } while(0U);




    GPIO_InitStruct.Pin = ((uint16_t)0x0400);
    GPIO_InitStruct.Mode = 0x00000002U;
    GPIO_InitStruct.Speed = ((0x3U << (0U)));
    HAL_GPIO_Init(((GPIO_TypeDef *)((0x40000000U + 0x00010000U) + 0x00000C00U)), &GPIO_InitStruct);

    GPIO_InitStruct.Pin = ((uint16_t)0x0800);
    GPIO_InitStruct.Mode = 0x00000000U;
    GPIO_InitStruct.Pull = 0x00000001U;
    HAL_GPIO_Init(((GPIO_TypeDef *)((0x40000000U + 0x00010000U) + 0x00000C00U)), &GPIO_InitStruct);



    hdma_usart3_rx.Instance = ((DMA_Channel_TypeDef *)((0x40000000U + 0x00020000U) + 0x00000030U));
    hdma_usart3_rx.Init.Direction = 0x00000000U;
    hdma_usart3_rx.Init.PeriphInc = 0x00000000U;
    hdma_usart3_rx.Init.MemInc = ((uint32_t)(0x1U << (7U)));
    hdma_usart3_rx.Init.PeriphDataAlignment = 0x00000000U;
    hdma_usart3_rx.Init.MemDataAlignment = 0x00000000U;
    hdma_usart3_rx.Init.Mode = ((uint32_t)(0x1U << (5U)));
    hdma_usart3_rx.Init.Priority = 0x00000000U;
    HAL_DMA_Init(&hdma_usart3_rx);
    do{ (uartHandle)->hdmarx = &(hdma_usart3_rx); (hdma_usart3_rx).Parent = (uartHandle); } while(0U);


    hdma_usart3_tx.Instance = ((DMA_Channel_TypeDef *)((0x40000000U + 0x00020000U) + 0x0000001CU));
    hdma_usart3_tx.Init.Direction = ((uint32_t)(0x1U << (4U)));
    hdma_usart3_tx.Init.PeriphInc = 0x00000000U;
    hdma_usart3_tx.Init.MemInc = ((uint32_t)(0x1U << (7U)));
    hdma_usart3_tx.Init.PeriphDataAlignment = 0x00000000U;
    hdma_usart3_tx.Init.MemDataAlignment = 0x00000000U;
    hdma_usart3_tx.Init.Mode = 0x00000000U;
    hdma_usart3_tx.Init.Priority = 0x00000000U;
    HAL_DMA_Init(&hdma_usart3_tx);
    do{ (uartHandle)->hdmatx = &(hdma_usart3_tx); (hdma_usart3_tx).Parent = (uartHandle); } while(0U);


    HAL_NVIC_SetPriority(USART3_IRQn, 1, 0);
    HAL_NVIC_EnableIRQ(USART3_IRQn);

 ((((((uint32_t)(1U << 28U | (0x1U << (4U))))) >> 28U) == 1U)? ((uartHandle)->Instance->CR1 |= ((((uint32_t)(1U << 28U | (0x1U << (4U))))) & 0x0000FFFFU)): (((((uint32_t)(1U << 28U | (0x1U << (4U))))) >> 28U) == 2U)? ((uartHandle)->Instance->CR2 |= ((((uint32_t)(1U << 28U | (0x1U << (4U))))) & 0x0000FFFFU)): ((uartHandle)->Instance->CR3 |= ((((uint32_t)(1U << 28U | (0x1U << (4U))))) & 0x0000FFFFU)));

  }
}

void HAL_UART_MspDeInit(UART_HandleTypeDef* uartHandle)
{

  if(uartHandle->Instance==((USART_TypeDef *)(0x40000000U + 0x00004400U)))
  {




    (((RCC_TypeDef *)((0x40000000U + 0x00020000U) + 0x00001000U))->APB1ENR &= ~((0x1U << (17U))));





    HAL_GPIO_DeInit(((GPIO_TypeDef *)((0x40000000U + 0x00010000U) + 0x00000800U)), ((uint16_t)0x0004)|((uint16_t)0x0008));


    HAL_DMA_DeInit(uartHandle->hdmarx);
    HAL_DMA_DeInit(uartHandle->hdmatx);


    HAL_NVIC_DisableIRQ(USART2_IRQn);



  }
  else if(uartHandle->Instance==((USART_TypeDef *)(0x40000000U + 0x00004800U)))
  {




    (((RCC_TypeDef *)((0x40000000U + 0x00020000U) + 0x00001000U))->APB1ENR &= ~((0x1U << (18U))));





    HAL_GPIO_DeInit(((GPIO_TypeDef *)((0x40000000U + 0x00010000U) + 0x00000C00U)), ((uint16_t)0x0400)|((uint16_t)0x0800));


    HAL_DMA_DeInit(uartHandle->hdmarx);
    HAL_DMA_DeInit(uartHandle->hdmatx);


    HAL_NVIC_DisableIRQ(USART3_IRQn);



  }
}


DMA_HandleTypeDef hdma_i2c2_rx;
DMA_HandleTypeDef hdma_i2c2_tx;

void I2C_Init(void)
{





  GPIO_InitTypeDef GPIO_InitStruct;
  do { volatile uint32_t tmpreg; ((((RCC_TypeDef *)((0x40000000U + 0x00020000U) + 0x00001000U))->APB2ENR) |= ((0x1U << (3U)))); tmpreg = ((((RCC_TypeDef *)((0x40000000U + 0x00020000U) + 0x00001000U))->APB2ENR) & ((0x1U << (3U)))); ((void)(tmpreg)); } while(0U);
  GPIO_InitStruct.Pin = ((uint16_t)0x0400)|((uint16_t)0x0800);
  GPIO_InitStruct.Mode = 0x00000012U;
  GPIO_InitStruct.Pull = 0x00000000U;
  GPIO_InitStruct.Speed = ((0x3U << (0U)));
  HAL_GPIO_Init(((GPIO_TypeDef *)((0x40000000U + 0x00010000U) + 0x00000C00U)), &GPIO_InitStruct);


  do { volatile uint32_t tmpreg; ((((RCC_TypeDef *)((0x40000000U + 0x00020000U) + 0x00001000U))->APB1ENR) |= ((0x1U << (22U)))); tmpreg = ((((RCC_TypeDef *)((0x40000000U + 0x00020000U) + 0x00001000U))->APB1ENR) & ((0x1U << (22U)))); ((void)(tmpreg)); } while(0U);
  hi2c2.Instance = ((I2C_TypeDef *)(0x40000000U + 0x5800));
  hi2c2.Init.ClockSpeed = 200000;
  hi2c2.Init.DutyCycle = 0x00000000U;
  hi2c2.Init.OwnAddress1 = 0;
  hi2c2.Init.AddressingMode = 0x00004000U;
  hi2c2.Init.DualAddressMode = 0x00000000U;
  hi2c2.Init.OwnAddress2 = 0;
  hi2c2.Init.GeneralCallMode = 0x00000000U;
  hi2c2.Init.NoStretchMode = 0x00000000U;
  (((RCC_TypeDef *)((0x40000000U + 0x00020000U) + 0x00001000U))->APB1RSTR |= ((0x1U << (22U))));
  (((RCC_TypeDef *)((0x40000000U + 0x00020000U) + 0x00001000U))->APB1RSTR &= ~((0x1U << (22U))));
  HAL_I2C_Init(&hi2c2);
# 357 "Src/setup.c"
}

void MX_GPIO_Init(void) {
  GPIO_InitTypeDef GPIO_InitStruct;


  do { volatile uint32_t tmpreg; ((((RCC_TypeDef *)((0x40000000U + 0x00020000U) + 0x00001000U))->APB2ENR) |= ((0x1U << (2U)))); tmpreg = ((((RCC_TypeDef *)((0x40000000U + 0x00020000U) + 0x00001000U))->APB2ENR) & ((0x1U << (2U)))); ((void)(tmpreg)); } while(0U);
  do { volatile uint32_t tmpreg; ((((RCC_TypeDef *)((0x40000000U + 0x00020000U) + 0x00001000U))->APB2ENR) |= ((0x1U << (3U)))); tmpreg = ((((RCC_TypeDef *)((0x40000000U + 0x00020000U) + 0x00001000U))->APB2ENR) & ((0x1U << (3U)))); ((void)(tmpreg)); } while(0U);
  do { volatile uint32_t tmpreg; ((((RCC_TypeDef *)((0x40000000U + 0x00020000U) + 0x00001000U))->APB2ENR) |= ((0x1U << (4U)))); tmpreg = ((((RCC_TypeDef *)((0x40000000U + 0x00020000U) + 0x00001000U))->APB2ENR) & ((0x1U << (4U)))); ((void)(tmpreg)); } while(0U);

  GPIO_InitStruct.Mode = 0x00000000U;
  GPIO_InitStruct.Pull = 0x00000000U;
  GPIO_InitStruct.Speed = ((0x2U << (0U)));

  GPIO_InitStruct.Pin = ((uint16_t)0x0020);
  HAL_GPIO_Init(((GPIO_TypeDef *)((0x40000000U + 0x00010000U) + 0x00000C00U)), &GPIO_InitStruct);

  GPIO_InitStruct.Pin = ((uint16_t)0x0040);
  HAL_GPIO_Init(((GPIO_TypeDef *)((0x40000000U + 0x00010000U) + 0x00000C00U)), &GPIO_InitStruct);

  GPIO_InitStruct.Pin = ((uint16_t)0x0080);
  HAL_GPIO_Init(((GPIO_TypeDef *)((0x40000000U + 0x00010000U) + 0x00000C00U)), &GPIO_InitStruct);

  GPIO_InitStruct.Pin = ((uint16_t)0x0400);
  HAL_GPIO_Init(((GPIO_TypeDef *)((0x40000000U + 0x00010000U) + 0x00001000U)), &GPIO_InitStruct);

  GPIO_InitStruct.Pin = ((uint16_t)0x0800);
  HAL_GPIO_Init(((GPIO_TypeDef *)((0x40000000U + 0x00010000U) + 0x00001000U)), &GPIO_InitStruct);

  GPIO_InitStruct.Pin = ((uint16_t)0x1000);
  HAL_GPIO_Init(((GPIO_TypeDef *)((0x40000000U + 0x00010000U) + 0x00001000U)), &GPIO_InitStruct);

  GPIO_InitStruct.Pull = 0x00000001U;
  GPIO_InitStruct.Pin = ((uint16_t)0x1000);
  HAL_GPIO_Init(((GPIO_TypeDef *)((0x40000000U + 0x00010000U) + 0x00000800U)), &GPIO_InitStruct);
# 401 "Src/setup.c"
  GPIO_InitStruct.Pull = 0x00000000U;

  GPIO_InitStruct.Pin = ((uint16_t)0x0002);
  HAL_GPIO_Init(((GPIO_TypeDef *)((0x40000000U + 0x00010000U) + 0x00000800U)), &GPIO_InitStruct);


  GPIO_InitStruct.Mode = 0x00000001U;

  GPIO_InitStruct.Pin = ((uint16_t)0x0004);
  HAL_GPIO_Init(((GPIO_TypeDef *)((0x40000000U + 0x00010000U) + 0x00000C00U)), &GPIO_InitStruct);

  GPIO_InitStruct.Pin = ((uint16_t)0x0010);
  HAL_GPIO_Init(((GPIO_TypeDef *)((0x40000000U + 0x00010000U) + 0x00000800U)), &GPIO_InitStruct);

  GPIO_InitStruct.Pin = ((uint16_t)0x0020);
  HAL_GPIO_Init(((GPIO_TypeDef *)((0x40000000U + 0x00010000U) + 0x00000800U)), &GPIO_InitStruct);


  GPIO_InitStruct.Mode = 0x00000003U;

  GPIO_InitStruct.Pin = ((uint16_t)0x0001);
  HAL_GPIO_Init(((GPIO_TypeDef *)((0x40000000U + 0x00010000U) + 0x00001000U)), &GPIO_InitStruct);

  GPIO_InitStruct.Pin = ((uint16_t)0x0001);
  HAL_GPIO_Init(((GPIO_TypeDef *)((0x40000000U + 0x00010000U) + 0x00000800U)), &GPIO_InitStruct);

  GPIO_InitStruct.Pin = ((uint16_t)0x0008);
  HAL_GPIO_Init(((GPIO_TypeDef *)((0x40000000U + 0x00010000U) + 0x00001000U)), &GPIO_InitStruct);

  GPIO_InitStruct.Pin = ((uint16_t)0x0002);
  HAL_GPIO_Init(((GPIO_TypeDef *)((0x40000000U + 0x00010000U) + 0x00001000U)), &GPIO_InitStruct);

  GPIO_InitStruct.Pin = ((uint16_t)0x0010);
  HAL_GPIO_Init(((GPIO_TypeDef *)((0x40000000U + 0x00010000U) + 0x00001000U)), &GPIO_InitStruct);

  GPIO_InitStruct.Pin = ((uint16_t)0x0020);
  HAL_GPIO_Init(((GPIO_TypeDef *)((0x40000000U + 0x00010000U) + 0x00001000U)), &GPIO_InitStruct);

  GPIO_InitStruct.Pin = ((uint16_t)0x0004);
  HAL_GPIO_Init(((GPIO_TypeDef *)((0x40000000U + 0x00010000U) + 0x00001000U)), &GPIO_InitStruct);



  GPIO_InitStruct.Pin = ((uint16_t)0x0008);
  HAL_GPIO_Init(((GPIO_TypeDef *)((0x40000000U + 0x00010000U) + 0x00000800U)), &GPIO_InitStruct);
  GPIO_InitStruct.Pin = ((uint16_t)0x0004);
  HAL_GPIO_Init(((GPIO_TypeDef *)((0x40000000U + 0x00010000U) + 0x00000800U)), &GPIO_InitStruct);


  GPIO_InitStruct.Mode = 0x00000002U;

  GPIO_InitStruct.Pin = ((uint16_t)0x0040);
  HAL_GPIO_Init(((GPIO_TypeDef *)((0x40000000U + 0x00010000U) + 0x00001000U)), &GPIO_InitStruct);

  GPIO_InitStruct.Pin = ((uint16_t)0x0080);
  HAL_GPIO_Init(((GPIO_TypeDef *)((0x40000000U + 0x00010000U) + 0x00001000U)), &GPIO_InitStruct);

  GPIO_InitStruct.Pin = ((uint16_t)0x0100);
  HAL_GPIO_Init(((GPIO_TypeDef *)((0x40000000U + 0x00010000U) + 0x00001000U)), &GPIO_InitStruct);

  GPIO_InitStruct.Pin = ((uint16_t)0x0080);
  HAL_GPIO_Init(((GPIO_TypeDef *)((0x40000000U + 0x00010000U) + 0x00000800U)), &GPIO_InitStruct);

  GPIO_InitStruct.Pin = ((uint16_t)0x0001);
  HAL_GPIO_Init(((GPIO_TypeDef *)((0x40000000U + 0x00010000U) + 0x00000C00U)), &GPIO_InitStruct);

  GPIO_InitStruct.Pin = ((uint16_t)0x0002);
  HAL_GPIO_Init(((GPIO_TypeDef *)((0x40000000U + 0x00010000U) + 0x00000C00U)), &GPIO_InitStruct);

  GPIO_InitStruct.Pin = ((uint16_t)0x0100);
  HAL_GPIO_Init(((GPIO_TypeDef *)((0x40000000U + 0x00010000U) + 0x00000800U)), &GPIO_InitStruct);

  GPIO_InitStruct.Pin = ((uint16_t)0x0200);
  HAL_GPIO_Init(((GPIO_TypeDef *)((0x40000000U + 0x00010000U) + 0x00000800U)), &GPIO_InitStruct);

  GPIO_InitStruct.Pin = ((uint16_t)0x0400);
  HAL_GPIO_Init(((GPIO_TypeDef *)((0x40000000U + 0x00010000U) + 0x00000800U)), &GPIO_InitStruct);

  GPIO_InitStruct.Pin = ((uint16_t)0x2000);
  HAL_GPIO_Init(((GPIO_TypeDef *)((0x40000000U + 0x00010000U) + 0x00000C00U)), &GPIO_InitStruct);

  GPIO_InitStruct.Pin = ((uint16_t)0x4000);
  HAL_GPIO_Init(((GPIO_TypeDef *)((0x40000000U + 0x00010000U) + 0x00000C00U)), &GPIO_InitStruct);

  GPIO_InitStruct.Pin = ((uint16_t)0x8000);
  HAL_GPIO_Init(((GPIO_TypeDef *)((0x40000000U + 0x00010000U) + 0x00000C00U)), &GPIO_InitStruct);
}

void MX_TIM_Init(void) {
  do { volatile uint32_t tmpreg; ((((RCC_TypeDef *)((0x40000000U + 0x00020000U) + 0x00001000U))->APB2ENR) |= ((0x1U << (11U)))); tmpreg = ((((RCC_TypeDef *)((0x40000000U + 0x00020000U) + 0x00001000U))->APB2ENR) & ((0x1U << (11U)))); ((void)(tmpreg)); } while(0U);
  do { volatile uint32_t tmpreg; ((((RCC_TypeDef *)((0x40000000U + 0x00020000U) + 0x00001000U))->APB2ENR) |= ((0x1U << (13U)))); tmpreg = ((((RCC_TypeDef *)((0x40000000U + 0x00020000U) + 0x00001000U))->APB2ENR) & ((0x1U << (13U)))); ((void)(tmpreg)); } while(0U);

  TIM_MasterConfigTypeDef sMasterConfig;
  TIM_OC_InitTypeDef sConfigOC;
  TIM_BreakDeadTimeConfigTypeDef sBreakDeadTimeConfig;
  TIM_SlaveConfigTypeDef sTimConfig;

  htim_right.Instance = ((TIM_TypeDef *)((0x40000000U + 0x00010000U) + 0x00002C00U));
  htim_right.Init.Prescaler = 0;
  htim_right.Init.CounterMode = (0x1U << (5U));
  htim_right.Init.Period = 64000000 / 2 / 16000;
  htim_right.Init.ClockDivision = 0x00000000U;
  htim_right.Init.RepetitionCounter = 0;
  htim_right.Init.AutoReloadPreload = 0x0000U;
  HAL_TIM_PWM_Init(&htim_right);

  sMasterConfig.MasterOutputTrigger = ((0x1U << (4U)));
  sMasterConfig.MasterSlaveMode = 0x00000000U;
  HAL_TIMEx_MasterConfigSynchronization(&htim_right, &sMasterConfig);

  sConfigOC.OCMode = ((0x2U << (4U)) | (0x4U << (4U)));
  sConfigOC.Pulse = 0;
  sConfigOC.OCPolarity = 0x00000000U;
  sConfigOC.OCNPolarity = ((0x1U << (3U)));
  sConfigOC.OCFastMode = 0x00000000U;
  sConfigOC.OCIdleState = 0x00000000U;
  sConfigOC.OCNIdleState = ((0x1U << (9U)));
  HAL_TIM_PWM_ConfigChannel(&htim_right, &sConfigOC, 0x00000000U);
  HAL_TIM_PWM_ConfigChannel(&htim_right, &sConfigOC, 0x00000004U);
  HAL_TIM_PWM_ConfigChannel(&htim_right, &sConfigOC, 0x00000008U);

  sBreakDeadTimeConfig.OffStateRunMode = ((0x1U << (11U)));
  sBreakDeadTimeConfig.OffStateIDLEMode = ((0x1U << (10U)));
  sBreakDeadTimeConfig.LockLevel = 0x00000000U;
  sBreakDeadTimeConfig.DeadTime = 48;
  sBreakDeadTimeConfig.BreakState = 0x00000000U;
  sBreakDeadTimeConfig.BreakPolarity = 0x00000000U;
  sBreakDeadTimeConfig.AutomaticOutput = 0x00000000U;
  HAL_TIMEx_ConfigBreakDeadTime(&htim_right, &sBreakDeadTimeConfig);

  htim_left.Instance = ((TIM_TypeDef *)((0x40000000U + 0x00010000U) + 0x00003400U));
  htim_left.Init.Prescaler = 0;
  htim_left.Init.CounterMode = (0x1U << (5U));
  htim_left.Init.Period = 64000000 / 2 / 16000;
  htim_left.Init.ClockDivision = 0x00000000U;
  htim_left.Init.RepetitionCounter = 0;
  htim_left.Init.AutoReloadPreload = 0x0000U;
  HAL_TIM_PWM_Init(&htim_left);

  sMasterConfig.MasterOutputTrigger = ((0x2U << (4U)));
  sMasterConfig.MasterSlaveMode = 0x00000080U;
  HAL_TIMEx_MasterConfigSynchronization(&htim_left, &sMasterConfig);

  sTimConfig.InputTrigger = 0x00000000U;
  sTimConfig.SlaveMode = 0x00000005U;
  HAL_TIM_SlaveConfigSynchronization(&htim_left, &sTimConfig);



  ((TIM_TypeDef *)((0x40000000U + 0x00010000U) + 0x00003400U))->CNT = ((4) * ((20)));

  sConfigOC.OCMode = ((0x2U << (4U)) | (0x4U << (4U)));
  sConfigOC.Pulse = 0;
  sConfigOC.OCPolarity = 0x00000000U;
  sConfigOC.OCNPolarity = ((0x1U << (3U)));
  sConfigOC.OCFastMode = 0x00000000U;
  sConfigOC.OCIdleState = 0x00000000U;
  sConfigOC.OCNIdleState = ((0x1U << (9U)));
  HAL_TIM_PWM_ConfigChannel(&htim_left, &sConfigOC, 0x00000000U);
  HAL_TIM_PWM_ConfigChannel(&htim_left, &sConfigOC, 0x00000004U);
  HAL_TIM_PWM_ConfigChannel(&htim_left, &sConfigOC, 0x00000008U);

  sBreakDeadTimeConfig.OffStateRunMode = ((0x1U << (11U)));
  sBreakDeadTimeConfig.OffStateIDLEMode = ((0x1U << (10U)));
  sBreakDeadTimeConfig.LockLevel = 0x00000000U;
  sBreakDeadTimeConfig.DeadTime = 48;
  sBreakDeadTimeConfig.BreakState = 0x00000000U;
  sBreakDeadTimeConfig.BreakPolarity = 0x00000000U;
  sBreakDeadTimeConfig.AutomaticOutput = 0x00000000U;
  HAL_TIMEx_ConfigBreakDeadTime(&htim_left, &sBreakDeadTimeConfig);

  ((TIM_TypeDef *)((0x40000000U + 0x00010000U) + 0x00003400U))->BDTR &= ~(0x1U << (15U));
  ((TIM_TypeDef *)((0x40000000U + 0x00010000U) + 0x00002C00U))->BDTR &= ~(0x1U << (15U));

  HAL_TIM_PWM_Start(&htim_left, 0x00000000U);
  HAL_TIM_PWM_Start(&htim_left, 0x00000004U);
  HAL_TIM_PWM_Start(&htim_left, 0x00000008U);
  HAL_TIMEx_PWMN_Start(&htim_left, 0x00000000U);
  HAL_TIMEx_PWMN_Start(&htim_left, 0x00000004U);
  HAL_TIMEx_PWMN_Start(&htim_left, 0x00000008U);

  HAL_TIM_PWM_Start(&htim_right, 0x00000000U);
  HAL_TIM_PWM_Start(&htim_right, 0x00000004U);
  HAL_TIM_PWM_Start(&htim_right, 0x00000008U);
  HAL_TIMEx_PWMN_Start(&htim_right, 0x00000000U);
  HAL_TIMEx_PWMN_Start(&htim_right, 0x00000004U);
  HAL_TIMEx_PWMN_Start(&htim_right, 0x00000008U);

  htim_left.Instance->RCR = 1;

  ((&htim_right)->Instance->CR1|=((0x1U << (0U))));
}

void MX_ADC1_Init(void) {
  ADC_MultiModeTypeDef multimode;
  ADC_ChannelConfTypeDef sConfig;

  do { volatile uint32_t tmpreg; ((((RCC_TypeDef *)((0x40000000U + 0x00020000U) + 0x00001000U))->APB2ENR) |= ((0x1U << (9U)))); tmpreg = ((((RCC_TypeDef *)((0x40000000U + 0x00020000U) + 0x00001000U))->APB2ENR) & ((0x1U << (9U)))); ((void)(tmpreg)); } while(0U);

  hadc1.Instance = ((ADC_TypeDef *)((0x40000000U + 0x00010000U) + 0x00002400U));
  hadc1.Init.ScanConvMode = ((uint32_t)(0x1U << (8U)));
  hadc1.Init.ContinuousConvMode = DISABLE;
  hadc1.Init.DiscontinuousConvMode = DISABLE;
  hadc1.Init.ExternalTrigConv = ((uint32_t)((0x4U << (17U)) | (0x2U << (17U)) ));
  hadc1.Init.DataAlign = 0x00000000U;
  hadc1.Init.NbrOfConversion = 5;
  HAL_ADC_Init(&hadc1);



  ((((AFIO_TypeDef *)((0x40000000U + 0x00010000U) + 0x00000000U))->MAPR) |= ((0x1U << (18U))));



  multimode.Mode = ((uint32_t)( (0x4U << (16U)) | (0x2U << (16U)) ));
  HAL_ADCEx_MultiModeConfigChannel(&hadc1, &multimode);

  sConfig.SamplingTime = 0x00000000U;
  sConfig.Channel = ((uint32_t)( (0x08U << (0U)) | (0x02U << (0U)) | (0x01U << (0U))));
  sConfig.Rank = 1;
  HAL_ADC_ConfigChannel(&hadc1, &sConfig);


  sConfig.SamplingTime = ((uint32_t)( (0x1U << (0U))));
  sConfig.Channel = 0x00000000U;
  sConfig.Rank = 2;
  HAL_ADC_ConfigChannel(&hadc1, &sConfig);

  sConfig.Channel = ((uint32_t)( (0x08U << (0U)) | (0x04U << (0U)) | (0x02U << (0U)) ));
  sConfig.Rank = 3;
  HAL_ADC_ConfigChannel(&hadc1, &sConfig);


  sConfig.Channel = ((uint32_t)( (0x08U << (0U)) | (0x04U << (0U)) ));



  sConfig.Rank = 4;
  HAL_ADC_ConfigChannel(&hadc1, &sConfig);


  sConfig.SamplingTime = ((uint32_t)((0x4U << (0U)) | (0x2U << (0U)) | (0x1U << (0U))));
  sConfig.Channel = ((uint32_t)((0x10U << (0U)) ));
  sConfig.Rank = 5;
  HAL_ADC_ConfigChannel(&hadc1, &sConfig);

  hadc1.Instance->CR2 |= (0x1U << (8U)) | (0x1U << (23U));

  ((((&hadc1)->Instance->CR2) |= (((0x1U << (0U))))));

  do { volatile uint32_t tmpreg; ((((RCC_TypeDef *)((0x40000000U + 0x00020000U) + 0x00001000U))->AHBENR) |= ((0x1U << (0U)))); tmpreg = ((((RCC_TypeDef *)((0x40000000U + 0x00020000U) + 0x00001000U))->AHBENR) & ((0x1U << (0U)))); ((void)(tmpreg)); } while(0U);

  ((DMA_Channel_TypeDef *)((0x40000000U + 0x00020000U) + 0x00000008U))->CCR = 0;
  ((DMA_Channel_TypeDef *)((0x40000000U + 0x00020000U) + 0x00000008U))->CNDTR = 5;
  ((DMA_Channel_TypeDef *)((0x40000000U + 0x00020000U) + 0x00000008U))->CPAR = (uint32_t) & (((ADC_TypeDef *)((0x40000000U + 0x00010000U) + 0x00002400U))->DR);
  ((DMA_Channel_TypeDef *)((0x40000000U + 0x00020000U) + 0x00000008U))->CMAR = (uint32_t)&adc_buffer;
  ((DMA_Channel_TypeDef *)((0x40000000U + 0x00020000U) + 0x00000008U))->CCR = (0x2U << (10U)) | (0x2U << (8U)) | (0x1U << (7U)) | (0x1U << (5U)) | (0x1U << (1U));
  ((DMA_Channel_TypeDef *)((0x40000000U + 0x00020000U) + 0x00000008U))->CCR |= (0x1U << (0U));

  HAL_NVIC_SetPriority(DMA1_Channel1_IRQn, 0, 0);
  HAL_NVIC_EnableIRQ(DMA1_Channel1_IRQn);
}


void MX_ADC2_Init(void) {
  ADC_ChannelConfTypeDef sConfig;

  do { volatile uint32_t tmpreg; ((((RCC_TypeDef *)((0x40000000U + 0x00020000U) + 0x00001000U))->APB2ENR) |= ((0x1U << (10U)))); tmpreg = ((((RCC_TypeDef *)((0x40000000U + 0x00020000U) + 0x00001000U))->APB2ENR) & ((0x1U << (10U)))); ((void)(tmpreg)); } while(0U);





  hadc2.Instance = ((ADC_TypeDef *)((0x40000000U + 0x00010000U) + 0x00002800U));
  hadc2.Init.ScanConvMode = ((uint32_t)(0x1U << (8U)));
  hadc2.Init.ContinuousConvMode = DISABLE;
  hadc2.Init.DiscontinuousConvMode = DISABLE;
  hadc2.Init.ExternalTrigConv = ((uint32_t)((0x4U << (17U)) | (0x2U << (17U)) | (0x1U << (17U))));
  hadc2.Init.DataAlign = 0x00000000U;
  hadc2.Init.NbrOfConversion = 5;
  HAL_ADC_Init(&hadc2);


  sConfig.SamplingTime = 0x00000000U;
  sConfig.Channel = ((uint32_t)( (0x08U << (0U)) | (0x02U << (0U)) ));
  sConfig.Rank = 1;
  HAL_ADC_ConfigChannel(&hadc2, &sConfig);


  sConfig.SamplingTime = ((uint32_t)( (0x1U << (0U))));
  sConfig.Channel = ((uint32_t)( (0x08U << (0U)) | (0x04U << (0U)) | (0x01U << (0U))));
  sConfig.Rank = 2;
  HAL_ADC_ConfigChannel(&hadc2, &sConfig);

  sConfig.Channel = ((uint32_t)( (0x08U << (0U)) | (0x04U << (0U)) | (0x02U << (0U)) | (0x01U << (0U))));
  sConfig.Rank = 3;
  HAL_ADC_ConfigChannel(&hadc2, &sConfig);

  sConfig.Channel = ((uint32_t)( (0x02U << (0U)) ));
  sConfig.Rank = 4;
  HAL_ADC_ConfigChannel(&hadc2, &sConfig);


  sConfig.Channel = ((uint32_t)( (0x02U << (0U)) | (0x01U << (0U))));
  sConfig.Rank = 5;
  HAL_ADC_ConfigChannel(&hadc2, &sConfig);

  hadc2.Instance->CR2 |= (0x1U << (8U));
  ((((&hadc2)->Instance->CR2) |= (((0x1U << (0U))))));
}
