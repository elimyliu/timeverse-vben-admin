# 脚手架脚本

脚本已提取为独立文件，可直接运行：

- **[init-vben.ps1](init-vben.ps1)** — Windows PowerShell 版
- **[init-vben.sh](init-vben.sh)** — macOS / Linux Bash 版

---

## 用法

### PowerShell（Windows）

```powershell
# 交互式选择 UI（推荐）
.\templates\init-vben.ps1

# 指定参数
.\templates\init-vben.ps1 -AppName "my-crm" -UI "ele" -AccessMode "backend"

# 只装依赖不启动
.\templates\init-vben.ps1 -SkipStart

# 非交互模式（需同时指定 -UI）
.\templates\init-vben.ps1 -UI "antd" -NonInteractive
```

### Bash（macOS / Linux）

```bash
chmod +x templates/init-vben.sh

# 交互式选择 UI
./templates/init-vben.sh

# 指定参数
./templates/init-vben.sh my-admin antd mixed
```

---

## 执行流程

1. **环境检查** — 检测 Node.js (>= 22.18)、Git、路径不含中文/空格
2. **UI 选择** — 交互式或参数指定（antd / ele / naive / tdesign）
3. **克隆** — `git clone --depth 1` Vben Admin 仓库
4. **清理** — 只保留选中的 `apps/web-*`，删除其他框架 + `playground/` + `docs/`
5. **启用 corepack**
6. **安装依赖**（pnpm install）
7. **配置权限模式** — 写入 `src/preferences.ts`
8. **启动** — `pnpm dev:<ui>`

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
