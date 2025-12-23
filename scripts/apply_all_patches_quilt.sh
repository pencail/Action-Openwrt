#!/usr/bin/env bash
# 🧩 PatchKit 智能补丁应用脚本（支持 patchmap）

set -euo pipefail
IFS=$'\n\t'

# ✨ 显示帮助说明
show_help() {
cat << EOF
🧩 apply_all_patches.sh - OpenWrt 补丁自动应用脚本（支持 patchmap）

用法：
  bash apply_all_patches.sh [补丁目录] [补丁清单文件] [日志路径]

参数：
  [补丁目录]        可选，默认：./patches
  [补丁清单文件]    可选，默认：./patchmap.yml
  [日志路径]        可选，默认：./patchlog.txt

示例：
  bash apply_all_patches.sh
  bash apply_all_patches.sh ./patches ./patchmap.yml ./logs/patchlog.txt

备注：
  - 补丁是否应用由 patchmap.yml 中 enabled 字段决定
  - 日志文件自动创建目录并记录已打或跳过的补丁状态
  - 若传入 --help 或 -h 即显示本说明
EOF
}

# 🛎 检查是否请求帮助
[[ "${1:-}" =~ ^(-h|--help)$ ]] && show_help && exit 0

# 🎯 参数默认值处理
PATCH_DIR="${1:-./patches}"
PATCHMAP="${2:-./patchmap.yml}"
LOG_FILE="${3:-./patchlog.txt}"
LOG_DIR="$(dirname "$LOG_FILE")"

# 🌱 创建日志目录（若不存在）
mkdir -p "$LOG_DIR"
: > "$LOG_FILE"

# 📋 前置信息输出
echo "🔧 正在加载补丁清单文件：$PATCHMAP" | tee -a "$LOG_FILE"
echo "📦 补丁目录：$PATCH_DIR" | tee -a "$LOG_FILE"
echo "📜 日志输出位置：$LOG_FILE" | tee -a "$LOG_FILE"
echo "──────────────────────────────" | tee -a "$LOG_FILE"

# 🔍 检查 patchmap 是否存在
if [ ! -f "$PATCHMAP" ]; then
    echo "❌ 错误：找不到 patchmap 文件 → $PATCHMAP" | tee -a "$LOG_FILE"
    exit 1
fi

# 🧪 检查是否安装 yq 解析工具
if ! command -v yq &>/dev/null; then
    echo "⚠️ 缺少 yq 工具，请先安装： sudo apt-get install yq" | tee -a "$LOG_FILE"
    exit 1
fi

# 📖 解析 patchmap.yml，获取启用补丁列表
mapfile -t PATCH_ENTRIES < <(yq -o=json '.patches[] | select(.enabled == true)' "$PATCHMAP" | jq -c '.')

# 🚀 遍历补丁条目并处理
generate_series() {
    : > "$PATCH_DIR/series"
    for entry in "${PATCH_ENTRIES[@]}"; do
        patch_path=$(echo "$entry" | jq -r '.path')
        echo "${patch_path#patches/}" >> "$PATCH_DIR/series"
    done
}

# 🩹 补丁应用函数（含冲突检测）
apply_patch() {
    export QUILT_PATCHES="$PATCH_DIR"
    quilt push -a || { echo "❌ quilt push 失败" | tee -a "$LOG_FILE" exit 1; }
}

# 执行流程 
generate_series 
apply_patch 
echo "🎉 所有补丁已成功应用！" | tee -a "$LOG_FILE"