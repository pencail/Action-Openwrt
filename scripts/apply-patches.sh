#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

# 📄 使用说明
show_help() {
cat << EOF
💡 补丁应用脚本 apply_all_patches.sh

用法：
  bash apply_all_patches.sh [补丁目录] [日志路径]

参数说明：
  [补丁目录]      可选，默认值为 ./patches
  [日志路径]      可选，默认值为 ./patchlog.txt

示例：
  bash apply_all_patches.sh
  bash apply_all_patches.sh ./patches/kernel ./logs/kernel_patchlog.txt

备注：
  - 脚本会递归遍历补丁目录下所有文件夹。
  - 自动跳过已应用或冲突补丁。
  - 日志记录包含 [PATCHED] 和 [SKIPPED] 状态。
  - 支持在 GitHub Actions 或本地环境执行。
EOF
}

# 🚩 若传入 --help 或 -h 参数，则显示说明后退出
[[ "${1:-}" =~ ^(-h|--help)$ ]] && show_help && exit 0

# 参数接收 + 默认值处理
PATCH_ROOT="${1:-./patches}"
LOG_FILE="${2:-./patchlog.txt}"
LOG_DIR="$(dirname "$LOG_FILE")"
EXCLUDE_DIRS=("docs" "example" "README")

# 日志目录准备
mkdir -p "$LOG_DIR"
: > "$LOG_FILE"
echo "🔧 补丁应用开始，来源目录：$PATCH_ROOT" | tee -a "$LOG_FILE"
echo "📜 日志位置：$LOG_FILE" | tee -a "$LOG_FILE"

# 补丁目录不存在时提示
if [ ! -d "$PATCH_ROOT" ]; then
    echo "❌ 错误：补丁目录不存在 → $PATCH_ROOT" | tee -a "$LOG_FILE"
    exit 1
fi

should_skip_dir() {
    local d="$(basename "$1")"
    for skip in "${EXCLUDE_DIRS[@]}"; do
        [[ "$d" == "$skip" ]] && return 0
    done
    return 1
}

apply_patch() {
    local patch="$1"
    if patch --dry-run -p1 < "$patch" &>/dev/null; then
        echo "✅ 应用补丁: $patch" | tee -a "$LOG_FILE"
        patch -p1 < "$patch"
        echo "[PATCHED] $(date '+%Y-%m-%d %H:%M:%S') $patch" >> "$LOG_FILE"
    else
        echo "⚠️ 跳过补丁（已应用或冲突）: $patch" | tee -a "$LOG_FILE"
        echo "[SKIPPED] $(date '+%Y-%m-%d %H:%M:%S') $patch" >> "$LOG_FILE"
    fi
}

# 遍历并处理所有补丁文件
find "$PATCH_ROOT" -type d | while read -r dir; do
    if should_skip_dir "$dir"; then
        echo "⏭ 跳过目录: $dir" | tee -a "$LOG_FILE"
        continue
    fi
    for patch in "$dir"/*.patch; do
        [ -f "$patch" ] && apply_patch "$patch"
    done
done

echo "🏁 补丁处理完成！" | tee -a "$LOG_FILE"