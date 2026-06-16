#!/usr/bin/env bash
set -euo pipefail
# 支持多种编译变体，默认: VARIANT_HOVERCAR
# ============================================================================

# 编译变体选择（可通过环境变量或命令行参数设置）
VARIANT="${1:-VARIANT_HOVERCAR}"
# 目标芯片默认使用 STM32F103xE，除非通过 TARGET_CHIP 显式指定。
TARGET_CHIP="${TARGET_CHIP:-STM32F103xE}"
# 在此处定义您的额外宏，例如开启双输入模式
# 默认：双输入，PB11(USART3) 作为主输入（优先），ADC 作为第二输入
# 通过预处理宏显式设置 PRI 输入类型为 ADC（TYPE=3）且范围为 0-4095，避免自动类型检测
# 注：在 VARIANT_HOVERCAR 中可能已定义 SIDEBOARD_SERIAL_USART3，使用 -U 取消以避免冲突
EXTRA_CFLAGS="-DDUAL_INPUTS -DCONTROL_SERIAL_USART3=0 -DCONTROL_ADC=1 -USIDEBOARD_SERIAL_USART3"

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BUILD_DIR="$ROOT_DIR/build"

# ============================================================================
# 验证工具链
# ============================================================================

for tool in arm-none-eabi-gcc arm-none-eabi-objcopy arm-none-eabi-size make; do
    if ! command -v "$tool" &> /dev/null; then
        echo "错误：找不到工具: $tool"
        echo "请先安装 ARM 交叉编译工具链："
        echo "  sudo apt-get install build-essential gcc-arm-none-eabi binutils-arm-none-eabi"
        exit 1
    fi
done

echo "编译变体: $VARIANT ($TARGET_CHIP)"
echo "附加标志: $EXTRA_CFLAGS"
echo "编译目录: $BUILD_DIR"
echo ""

# ============================================================================
# 使用 Make 进行编译
# ============================================================================

cd "$ROOT_DIR"

# 清理旧的编译输出
echo "清理旧编译..."
make clean 2>/dev/null || true

# 编译指定变体 (此处将 TARGET_CHIP/CHIP、EXTRA_CFLAGS 传入 make)
echo ""
echo "编译中 (VARIANT=$VARIANT)..."
if VARIANT="$VARIANT" TARGET_CHIP="$TARGET_CHIP" CHIP="$TARGET_CHIP" EXTRA_CFLAGS="$EXTRA_CFLAGS" make BUILD_DIR="$BUILD_DIR" all 2>&1; then
    echo ""
    echo "=== 编译完成 ==="
    echo "输出文件:"
    echo "  - $BUILD_DIR/hover.elf"
    echo "  - $BUILD_DIR/hover.hex"
    echo "  - $BUILD_DIR/hover.bin"
    echo ""
    # 列出实际定义的预处理器宏（包含 Inc/config.h）并打印摘要
    echo "生成预处理宏清单..."
        CC_TOOL="arm-none-eabi-gcc"
        MACRO_FILE="$BUILD_DIR/defined_macros.txt"
        # 为 GD32 目标增加 STM32F103xE 别名，保证 HAL 头文件能正确选择设备，
        # 同时保留 TARGET_CHIP 的原始宏定义用于构建报告和特定代码分支。
        GCC_TARGET_CHIP="$TARGET_CHIP"
        if [ "$TARGET_CHIP" = "GD32E103RBT6" ] || [ "$TARGET_CHIP" = "GD32F103RCT6" ]; then
            GCC_CHIP_ALIAS="STM32F103xE"
        else
            GCC_CHIP_ALIAS="$TARGET_CHIP"
        fi
        # 编译命令中也加入 EXTRA_CFLAGS，以保证宏清单准确
        $CC_TOOL -dM -E \
            -IInc \
            -IDrivers/STM32F1xx_HAL_Driver/Inc \
            -IDrivers/STM32F1xx_HAL_Driver/Inc/Legacy \
            -IDrivers/CMSIS/Device/ST/STM32F1xx/Include \
            -IDrivers/CMSIS/Include \
            -DUSE_HAL_DRIVER -D"$GCC_TARGET_CHIP" -D"$GCC_CHIP_ALIAS" -D$VARIANT $EXTRA_CFLAGS -xc /dev/null > "$MACRO_FILE" 2>/dev/null || true
    echo "已生成宏清单: $MACRO_FILE"
    echo "---- 相关宏摘要 ----"
    grep -E "VARIANT|DEBUG_|FEEDBACK|CONTROL_|SIDEBOARD|PRI_INPUT|DEBUG_SERIAL|FEEDBACK_SERIAL|VARIANT_HOVERCAR|VARIANT_USART|DUAL_INPUTS|USE_HAL_DRIVER|STM32F103xE|GD32E103RBT6|GD32F103RCT6" "$MACRO_FILE" || true
    echo "--------------------"
else
    echo ""
    echo "编译失败！"
    exit 1
fi
