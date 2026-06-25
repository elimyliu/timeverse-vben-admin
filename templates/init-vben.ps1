<#
.SYNOPSIS
  Vben Admin 5.x 快速脚手架脚本
.DESCRIPTION
  一键完成：环境检查 → 克隆 → UI 库选择 → 清理无用框架 → 依赖安装 → 权限配置 → 启动
.EXAMPLE
  .\init-vben.ps1 -AppName "my-admin"
#>
param(
  [Parameter(Mandatory = $false)]
  [string]$AppName = "vben-admin-app",

  [Parameter(Mandatory = $false)]
  [ValidateSet("antd", "ele", "naive", "tdesign")]
  [string]$UI = "",

  [Parameter(Mandatory = $false)]
  [ValidateSet("frontend", "backend", "mixed")]
  [string]$AccessMode = "mixed",

  [Parameter(Mandatory = $false)]
  [switch]$SkipInstall,

  [Parameter(Mandatory = $false)]
  [switch]$SkipStart,

  [Parameter(Mandatory = $false)]
  [switch]$NonInteractive
)

$ErrorActionPreference = "Stop"
$Repo = "https://github.com/vbenjs/vue-vben-admin.git"

function Write-Step($msg) { Write-Host "`n[$(Get-Date -Format 'HH:mm:ss')] $msg" -ForegroundColor Cyan }
function Write-OK($msg)   { Write-Host "  ✔ $msg" -ForegroundColor Green }
function Write-Err($msg)  { Write-Host "  ✘ $msg" -ForegroundColor Red }
function Write-Warn($msg) { Write-Host "  ⚠ $msg" -ForegroundColor Yellow }

# UI 框架映射表 (显示名 → 目录名)
$UIMap = @{
  "1" = @{ Name = "Ant Design Vue";      Dir = "web-antd" }
  "2" = @{ Name = "Element Plus";        Dir = "web-ele" }
  "3" = @{ Name = "Naive UI";            Dir = "web-naive" }
  "4" = @{ Name = "TDesign";             Dir = "web-tdesign" }
}

# 要清理的顶级目录
$DirsToRemove = @("playground", "docs")

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

# 2. 交互式 UI 选择（如果未通过参数指定）
if (-not $UI) {
  Write-Step "请选择前端 UI 框架"
  Write-Host ""
  foreach ($key in $UIMap.Keys | Sort-Object) {
    Write-Host "  [$key] $($UIMap[$key].Name)" -ForegroundColor Yellow
  }
  Write-Host ""
  do {
    $selection = Read-Host "请输入编号 (1-4)"
    if (-not $UIMap.ContainsKey($selection)) {
      Write-Warn "无效输入，请输入 1、2、3 或 4"
    }
  } while (-not $UIMap.ContainsKey($selection))
  $selected = $UIMap[$selection]
  $UI = $selected.Dir -replace '^web-', ''
  Write-OK "已选择: $($selected.Name)"
} else {
  # 通过参数指定的 UI，找对应的显示名
  $selected = $UIMap.Values | Where-Object { $_.Dir -eq "web-$UI" } | Select-Object -First 1
}

# 3. 克隆
Write-Step "克隆 Vben Admin 仓库"
if (Test-Path $AppName) {
  Write-Err "目录 $AppName 已存在"
  exit 1
}
git clone --depth 1 $Repo $AppName 2>&1 | Out-Null
if ($LASTEXITCODE -ne 0) { Write-Err "克隆失败"; exit 1 }
Write-OK "克隆到 $AppName"

Set-Location $AppName

# 4. 清理：只保留选中的 UI 框架，删除其他
Write-Step "清理未使用的 UI 框架"
$keepDir = "apps/web-$UI"
foreach ($entry in Get-ChildItem "apps" -Directory) {
  if ($entry.Name -ne "web-$UI") {
    Write-Warn "  删除 apps/$($entry.Name)"
    Remove-Item -Recurse -Force $entry.FullName
  }
}
# 清理顶级无用目录
foreach ($dir in $DirsToRemove) {
  if (Test-Path $dir) {
    Write-Warn "  删除 $dir/"
    Remove-Item -Recurse -Force $dir
  }
}
Write-OK "已清理，仅保留 $keepDir"

# 5. 启用 corepack
Write-Step "启用 corepack"
corepack enable 2>&1 | Out-Null
Write-OK "corepack enabled"

# 6. 安装依赖
if (-not $SkipInstall) {
  Write-Step "安装依赖（pnpm）"
  pnpm install
  if ($LASTEXITCODE -ne 0) { Write-Err "依赖安装失败"; exit 1 }
  Write-OK "依赖安装完成"
}

# 7. 配置 accessMode
Write-Step "配置权限模式: $AccessMode"
$prefFile = "apps/web-$UI/src/preferences.ts"
if (Test-Path $prefFile) {
  (Get-Content $prefFile) -replace "accessMode:\s*'[^']+'", "accessMode: '$AccessMode'" | Set-Content $prefFile
  Write-OK "已写入 $prefFile"
} else {
  Write-Err "找不到 $prefFile，请检查 UI 库参数"
}

# 8. 启动
if (-not $SkipStart) {
  Write-Step "启动开发服务器（UI: $UI）"
  Write-Host "  启动后访问 http://localhost:5555" -ForegroundColor Yellow
  pnpm "dev:$UI"
}
