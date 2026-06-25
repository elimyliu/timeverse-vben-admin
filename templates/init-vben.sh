#!/usr/bin/env bash
set -euo pipefail

APP_NAME=${1:-"vben-admin-app"}
UI=${2:-""}                # antd | ele | naive | tdesign (留空则交互式选择)
ACCESS_MODE=${3:-"mixed"}  # frontend | backend | mixed
REPO="https://github.com/vbenjs/vue-vben-admin.git"

Cyan='\033[0;36m'; Green='\033[0;32m'; Yellow='\033[0;33m'; Red='\033[0;31m'; NC='\033[0m'
step() { echo -e "\n${Cyan}[$(date +%H:%M:%S)] $1${NC}"; }
ok()   { echo -e "  ${Green}✔${NC} $1"; }
warn() { echo -e "  ${Yellow}⚠${NC} $1"; }
err()  { echo -e "  ${Red}✘${NC} $1"; exit 1; }

# UI 框架映射
declare -A UI_NAMES=(
  ["1"]="Ant Design Vue"
  ["2"]="Element Plus"
  ["3"]="Naive UI"
  ["4"]="TDesign"
)
declare -A UI_DIRS=(
  ["1"]="web-antd"
  ["2"]="web-ele"
  ["3"]="web-naive"
  ["4"]="web-tdesign"
)

# 要清理的顶级目录
DIRS_TO_REMOVE=("playground" "docs")

# 1. 环境检查
step "环境检查"
[[ -z "$(command -v node)" ]] && err "未安装 Node.js"
NODE_VER=$(node -v | sed 's/v//')
NODE_MAJOR=$(echo "$NODE_VER" | cut -d. -f1)
[[ $NODE_MAJOR -lt 22 ]] && err "Node 版本过低: $NODE_VER，需 >= 22.18"
ok "Node $NODE_VER"
[[ -z "$(command -v git)" ]] && err "未安装 Git"
git --version

# 路径检查
CWD=$(pwd)
if echo "$CWD" | grep -P '[\x{4e00}-\x{9fff}\s]' > /dev/null; then
  err "当前路径含中文或空格：$CWD"
fi

# 2. 交互式 UI 选择
if [[ -z "$UI" ]]; then
  step "请选择前端 UI 框架"
  echo ""
  for key in 1 2 3 4; do
    echo -e "  ${Yellow}[$key]${NC} ${UI_NAMES[$key]}"
  done
  echo ""
  while true; do
    read -p "请输入编号 (1-4): " selection
    case "$selection" in
      1|2|3|4) break ;;
      *) warn "无效输入，请输入 1、2、3 或 4" ;;
    esac
  done
  UI_DIR=${UI_DIRS[$selection]}
  UI_NAME=${UI_NAMES[$selection]}
  UI=${UI_DIR#web-}
  ok "已选择: $UI_NAME"
else
  # 参数指定，反向查找目录名
  for key in 1 2 3 4; do
    dir="${UI_DIRS[$key]}"
    if [[ "${dir#web-}" == "$UI" ]]; then
      UI_NAME=${UI_NAMES[$key]}
      break
    fi
  done
  UI_DIR="web-$UI"
fi

# 3. 克隆
step "克隆 Vben Admin 仓库"
[[ -d "$APP_NAME" ]] && err "目录 $APP_NAME 已存在"
git clone --depth 1 "$REPO" "$APP_NAME"
cd "$APP_NAME"
ok "克隆到 $APP_NAME"

# 4. 清理：只保留选中的 UI 框架，删除其他
step "清理未使用的 UI 框架"
for dir_entry in apps/*/; do
  entry_name=$(basename "$dir_entry")
  if [[ "$entry_name" != "$UI_DIR" ]]; then
    warn "  删除 apps/$entry_name"
    rm -rf "apps/$entry_name"
  fi
done
# 清理顶级无用目录
for dir in "${DIRS_TO_REMOVE[@]}"; do
  if [[ -d "$dir" ]]; then
    warn "  删除 $dir/"
    rm -rf "$dir"
  fi
done
ok "已清理，仅保留 apps/$UI_DIR"

# 5. 启用 corepack
step "启用 corepack"
corepack enable
ok "corepack enabled"

# 6. 安装依赖
step "安装依赖（pnpm）"
pnpm install
ok "依赖安装完成"

# 7. 配置 accessMode
step "配置权限模式: $ACCESS_MODE"
PREF_FILE="apps/$UI_DIR/src/preferences.ts"
if [[ -f "$PREF_FILE" ]]; then
  sed -i.bak "s/accessMode: '[^']*'/accessMode: '$ACCESS_MODE'/" "$PREF_FILE"
  rm -f "$PREF_FILE.bak"
  ok "已写入 $PREF_FILE"
else
  err "找不到 $PREF_FILE"
fi

# 8. 启动
step "启动开发服务器（UI: $UI）"
echo -e "  ${Green}启动后访问 http://localhost:5555${NC}"
pnpm "dev:$UI"
