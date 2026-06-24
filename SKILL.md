---
name: timeverse-vben-admin
description: "Use this skill when the user wants to build a Vue 3 / TypeScript / Vite admin management system (后台管理系统) using Vben Admin 5.x as the foundation. Triggers on phrases like '搭建后台', '管理系统', '中后台', 'admin', 'vben', '权限系统', 'CRUD 页面', 'Dashboard', 'RBAC'."
version: 1.0.0
author: trae-cn
ui-default: antd
permission-default: mixed
license: MIT
---

# Vben Admin 5.x 中后台开发技能

基于 [Vben Admin 5.x](https://doc.vben.pro/) 快速构建企业级中后台系统。**默认 UI 框架: Ant Design Vue**。**默认权限模式: 混合(前端路由 + 后端菜单)**。

## 何时触发

当用户提出以下需求时**必须**使用本技能：

- "帮我搭建一个后台管理系统" / "做一个 admin" / "中后台原型"
- "基于 Vben 做一个 XXX 系统"
- "用 Vue3 写一个后台" + 涉及表格/表单/权限/菜单/Dashboard
- 已有 Vben 项目，需要新增模块、CRUD 页面、权限改造、主题、国际化
- 涉及登录/注销、按钮权限、菜单可见性、角色判断、动态路由等关键词

## 核心信息速查

| 项 | 值 |
|---|---|
| 框架 | [Vben Admin 5.x](https://github.com/vbenjs/vue-vben-admin) |
| 文档 | https://doc.vben.pro/ |
| 仓库 | https://github.com/vbenjs/vue-vben-admin |
| 最低 Node | **22.18.0+** |
| 包管理 | **pnpm** (强制使用 corepack) |
| 技术栈 | Vue 3.5 + Vite 6 + TypeScript 5 + Nitro |
| UI 默认 | **Ant Design Vue**（可切换 Element Plus / Naive UI / TDesign） |
| 权限 | 混合模式：前端路由 `meta.authority` + 后端动态菜单 |
| 浏览器 | Chrome/Edge/Firefox/Safari 最近 2 个版本，不支持 IE |

## 工作流程（必须遵循）

每接到一个 Vben 相关任务，按以下顺序执行：

```
1. 阅读 [reference/tech-stack.md]         → 确认技术栈与命令
2. 阅读 [reference/architecture.md]       → 确认目录结构
3. 阅读 [reference/permissions.md]        → 确认权限模式
4. 阅读 [reference/routing.md]            → 确认路由/菜单规范
5. 阅读 [reference/common-features.md]    → 登录/主题/国际化方案
6. 按需使用 [templates/crud-page.md]     → CRUD 页面模板
7. 按需使用 [templates/scaffolding-script.md] → 脚手架命令
```

## 核心约束（绝对禁止违反）

1. **必须使用 pnpm**，不要使用 npm/yarn 安装依赖
2. **目录路径不能含中文/韩文/日文/空格**，否则安装依赖会失败
3. **优先复用框架能力**：表单用 `useVbenForm`、表格用 `VbenVxeTable`、HTTP 用 `requestClient`、图标用 `Iconify`、权限用 `@vben/access`
4. **页面新增流程**：先在 `src/router/routes/modules/<业务模块>.ts` 加路由 → 再在 `src/views/<业务模块>/` 写页面
5. **国际化**：所有用户可见文案必须走 `$t('key')`，禁止硬编码
6. **图标**：使用 `Iconify` 格式（如 `mdi:home`、`lucide:copyright`），禁止直接引入 icon 包
7. **权限判断**：菜单用 `meta.authority`，按钮用 `<AccessControl>` 或 `v-access:code` 指令
8. **Mock 数据**：优先使用 Nitro 内置 Mock，目录 `apps/web-antd/mock/`
9. **代码规范**：提交前必须跑 `pnpm lint` + `pnpm typecheck`
10. **不要在 router 文件里直接写组件导入**，用 `() => import('#/views/...')` 懒加载

## 快速命令速查

```bash
# 1. 使用脚手架脚本（推荐——交互式选择 UI 框架，自动清理无用目录）
# Windows:
.\templates\init-vben.ps1
# macOS/Linux:
chmod +x templates/init-vben.sh && ./templates/init-vben.sh

# 2. 或手动拉取脚手架
git clone --depth 1 https://github.com/vbenjs/vue-vben-admin.git
cd vue-vben-admin

# 3. 安装依赖（强制使用 pnpm）
npm i -g corepack
pnpm install

# 4. 启动 Ant Design Vue 版本
pnpm run dev:antd
# 访问 http://localhost:5555

# 5. 其他命令
pnpm dev               # 交互式选择应用
pnpm build             # 生产构建
pnpm lint              # 代码检查
pnpm typecheck         # 类型检查
pnpm test              # 单元测试（vitest）
```

## 脚手架脚本（PowerShell / Bash 双版本）

详见 [templates/scaffolding-script.md](templates/scaffolding-script.md)。该脚本可在 60 秒内完成：环境检查 → 克隆 → 依赖安装 → UI 库选择 → 权限模式配置 → 启动。

## 常见任务的最小实现路径

| 任务 | 关键文件 |
|---|---|
| 新增一个 CRUD 页面 | `src/router/routes/modules/<业务>.ts` + `src/views/<业务>/<page>.vue`，见 [templates/crud-page.md](templates/crud-page.md) |
| 接入后端 API | 改 `src/api/<业务>/index.ts` + `src/service/request/index.ts` |
| 修改登录逻辑 | `src/views/_core/authentication/login.vue` + `src/api/core/auth.ts` + `src/store/auth.ts` |
| 新增按钮权限 | `<AccessControl :codes="['AC_xxx']" type="code">` |
| 切换 UI 库 | 见 [reference/common-features.md](reference/common-features.md) 切换章节 |
| 国际化文案 | `src/locales/langs/zh-CN.ts` 添加 key + 模板用 `$t('key')` |
| 主题色修改 | `apps/web-antd/src/preferences.ts` |
| 移除示例代码 | 见 [reference/architecture.md](reference/architecture.md) 移除章节 |

## 反模式（绝对不要做）

- ❌ 在 Vben 项目里用 npm/yarn 装依赖
- ❌ 写 `import UserList from '@/views/user/list.vue'`（破坏懒加载）
- ❌ 把接口地址硬编码到 `.vue` 文件里
- ❌ 用 `localStorage` 直接存用户信息（应通过 `useAuthStore`）
- ❌ 跳过 `useVbenForm` 直接用 `v-model` 写表单
- ❌ 在模板里写中文硬编码
- ❌ 修改 `apps/web-antd/src/router/routes/core/` 下的核心路由
- ❌ 把业务代码写到 `playground/` 目录

## 文档参考链接

- 简介：https://doc.vben.pro/guide/introduction/vben.html
- 快速开始：https://doc.vben.pro/guide/introduction/quick-start.html
- 精简版：https://doc.vben.pro/guide/introduction/thin.html
- 路由和菜单：https://doc.vben.pro/guide/essentials/route.html
- 权限：https://doc.vben.pro/guide/in-depth/access.html
- 登录：https://doc.vben.pro/guide/in-depth/login.html
- 主题：https://doc.vben.pro/guide/in-depth/theme.html
- 国际化：https://doc.vben.pro/guide/in-depth/locale.html
- 组件库切换：https://doc.vben.pro/guide/in-depth/ui-framework.html
- 工程规范：https://doc.vben.pro/guide/project/standard.html
- CLI 工具：https://doc.vben.pro/guide/project/cli.html
- 目录结构：https://doc.vben.pro/guide/project/dir.html
