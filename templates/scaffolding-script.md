# 脚手架脚本

## PowerShell 版（Windows 推荐）

保存为 `init-vben.ps1`，放到任意 PATH 目录即可。

```powershell
<#
.SYNOPSIS
  Vben Admin 5.x 快速脚手架脚本
.DESCRIPTION
  一键完成：环境检查 → 克隆 → 依赖安装 → UI 库/权限模式选择 → 启动
.EXAMPLE
  .\init-vben.ps1 -AppName "my-admin"
#>
param(
  [Parameter(Mandatory = $false)]
  [string]$AppName = "vben-admin-app",

  [Parameter(Mandatory = $false)]
  [ValidateSet("antd", "ele", "naive", "tdesign", "antdv")]
  [string]$UI = "antd",

  [Parameter(Mandatory = $false)]
  [ValidateSet("frontend", "backend", "mixed")]
  [string]$AccessMode = "mixed",

  [Parameter(Mandatory = $false)]
  [switch]$SkipInstall,

  [Parameter(Mandatory = $false)]
  [switch]$SkipStart
)

$ErrorActionPreference = "Stop"
$Repo = "https://github.com/vbenjs/vue-vben-admin.git"

function Write-Step($msg) { Write-Host "`n[$(Get-Date -Format 'HH:mm:ss')] $msg" -ForegroundColor Cyan }
function Write-OK($msg)   { Write-Host "  ✔ $msg" -ForegroundColor Green }
function Write-Err($msg)  { Write-Host "  ✘ $msg" -ForegroundColor Red }

# 1. 环境检查
Write-Step "环境检查"
$nodeVer = (& node -v 2>$null) -replace 'v', ''
if (-not $nodeVer) { Write-Err "未安装 Node.js"; exit 1 }
$nodeMajor = [int]($nodeVer.Split('.')[0])
if ($nodeMajor -lt 22) { Write-Err "Node 版本过低: $nodeVer，需 >= 22.18"; exit 1 }
Write-OK "Node $nodeVer"

$gitVer = (& git --version 2>$null)
if (-not $gitVer) { Write-Err "未安装 Git"; exit 1 }
Write-OK $gitVer

# 检查路径无中文/空格
$cwd = (Get-Location).Path
if ($cwd -match '[\u4e00-\u9fff\s]') {
  Write-Err "当前路径含中文或空格：$cwd`n请切换到英文无空格目录"
  exit 1
}

# 2. 克隆
Write-Step "克隆 Vben Admin 仓库"
if (Test-Path $AppName) {
  Write-Err "目录 $AppName 已存在"
  exit 1
}
git clone --depth 1 $Repo $AppName 2>&1 | Out-Null
if ($LASTEXITCODE -ne 0) { Write-Err "克隆失败"; exit 1 }
Write-OK "克隆到 $AppName"

Set-Location $AppName

# 3. 启用 corepack
Write-Step "启用 corepack"
corepack enable 2>&1 | Out-Null
Write-OK "corepack enabled"

# 4. 安装依赖
if (-not $SkipInstall) {
  Write-Step "安装依赖（pnpm）"
  pnpm install
  if ($LASTEXITCODE -ne 0) { Write-Err "依赖安装失败"; exit 1 }
  Write-OK "依赖安装完成"
}

# 5. 配置 accessMode
Write-Step "配置权限模式: $AccessMode"
$prefFile = "apps/web-$UI/src/preferences.ts"
if (Test-Path $prefFile) {
  (Get-Content $prefFile) -replace "accessMode:\s*'[^']+'", "accessMode: '$AccessMode'" | Set-Content $prefFile
  Write-OK "已写入 $prefFile"
} else {
  Write-Err "找不到 $prefFile，请检查 UI 库参数"
}

# 6. 启动
if (-not $SkipStart) {
  Write-Step "启动开发服务器（UI: $UI）"
  Write-Host "  启动后访问 http://localhost:5555" -ForegroundColor Yellow
  pnpm "dev:$UI"
}
```

### 用法

```powershell
# 默认（antd + mixed + 自动启动）
.\init-vben.ps1

# 自定义
.\init-vlen.ps1 -AppName "my-crm" -UI "ele" -AccessMode "backend"

# 只装依赖不启动
.\init-vben.ps1 -SkipStart
```

---

## Bash 版（macOS / Linux）

保存为 `init-vben.sh`：

```bash
#!/usr/bin/env bash
set -euo pipefail

APP_NAME=${1:-"vben-admin-app"}
UI=${2:-"antd"}            # antd | ele | naive | tdesign | antdv
ACCESS_MODE=${3:-"mixed"}  # frontend | backend | mixed
REPO="https://github.com/vbenjs/vue-vben-admin.git"

Cyan='\033[0;36m'; Green='\033[0;32m'; Red='\033[0;31m'; NC='\033[0m'
step() { echo -e "\n${Cyan}[$(date +%H:%M:%S)] $1${NC}"; }
ok()   { echo -e "  ${Green}✔${NC} $1"; }
err()  { echo -e "  ${Red}✘${NC} $1"; exit 1; }

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

# 2. 克隆
step "克隆 Vben Admin 仓库"
[[ -d "$APP_NAME" ]] && err "目录 $APP_NAME 已存在"
git clone --depth 1 "$REPO" "$APP_NAME"
cd "$APP_NAME"
ok "克隆到 $APP_NAME"

# 3. 启用 corepack
step "启用 corepack"
corepack enable
ok "corepack enabled"

# 4. 安装依赖
step "安装依赖（pnpm）"
pnpm install
ok "依赖安装完成"

# 5. 配置 accessMode
step "配置权限模式: $ACCESS_MODE"
PREF_FILE="apps/web-$UI/src/preferences.ts"
if [[ -f "$PREF_FILE" ]]; then
  sed -i.bak "s/accessMode: '[^']*'/accessMode: '$ACCESS_MODE'/" "$PREF_FILE"
  rm -f "$PREF_FILE.bak"
  ok "已写入 $PREF_FILE"
else
  err "找不到 $PREF_FILE"
fi

# 6. 启动
step "启动开发服务器（UI: $UI）"
echo -e "  ${Green}启动后访问 http://localhost:5555${NC}"
pnpm "dev:$UI"
```

### 用法

```bash
chmod +x init-vben.sh
./init-vben.sh my-admin antd mixed
```

---

## 仅克隆不安装（用于已有项目）

```bash
git clone --depth 1 https://github.com/vbenjs/vue-vben-admin.git
cd vue-vben-admin
corepack enable
pnpm install
pnpm dev:antd
```

---

## 国内网络加速

```bash
# 设置 corepack 走淘宝源
export COREPACK_NPM_REGISTRY=https://registry.npmmirror.com

# 设置 pnpm 源
pnpm config set registry https://registry.npmmirror.com

# 重新安装
pnpm install
```

Windows PowerShell:

```powershell
$env:COREPACK_NPM_REGISTRY = "https://registry.npmmirror.com"
pnpm config set registry https://registry.npmmirror.com
pnpm install
```

---

## 一句话脚手架

如果想用最简命令直接生成（无交互、无配置）：

```bash
git clone --depth 1 https://github.com/vbenjs/vue-vben-admin.git my-admin && \
cd my-admin && corepack enable && pnpm install && pnpm dev:antd
```

---

## 卸载与重装

```bash
# 清理
rm -rf node_modules apps/*/node_modules packages/*/node_modules
rm pnpm-lock.yaml

# 重装
corepack enable
pnpm install
```

Windows:

```powershell
Remove-Item -Recurse -Force node_modules, apps\*\node_modules, packages\*\node_modules
Remove-Item -Force pnpm-lock.yaml
corepack enable; pnpm install
```
