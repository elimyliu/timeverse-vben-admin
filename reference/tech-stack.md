# 技术栈与命令速查

## 基础环境要求

| 工具 | 版本 | 备注 |
|---|---|---|
| Node.js | **>= 22.18.0** | 推荐用 fnm/nvm 管理 |
| pnpm | 通过 corepack 自动安装 | 强制使用，禁用 npm/yarn |
| Git | 任意 | 克隆仓库 |
| 浏览器 | Chrome/Edge/Firefox/Safari 最近 2 版 | 不支持 IE |

## 框架版本（5.x）

| 类别 | 技术 |
|---|---|
| 框架 | Vue 3.5+ |
| 构建 | Vite 6 |
| 类型 | TypeScript 5 |
| 包管理 | pnpm + corepack |
| 仓库结构 | Pnpm Monorepo + Turborepo + Changeset |
| Mock | Nitro Server |
| 测试 | Vitest |
| 代码规范 | Oxfmt / Oxlint / ESLint / Stylelint / Publint / CSpell |
| 状态管理 | Pinia |
| 路由 | Vue Router 4 |
| 样式 | Tailwind CSS 4（仅 web-antd/web-ele） |
| HTTP | Axios（封装为 `requestClient`） |
| UI 库 | 默认 Ant Design Vue（可切） |
| 图标 | Iconify（按需离线加载） |
| 富文本 | TipTap |
| 表格 | VxeTable（封装为 `VbenVxeTable`） |
| 表单 | Vben Form（封装 ant-design-vue 的 Form） |

## Monorepo 目录结构

> **注意：** 以下 `apps/` 目录包含 5 套 UI 框架应用。克隆项目时必须先询问用户使用哪一个，禁止全部下载。
> 脚手架脚本（`templates/init-vben.ps1` / `templates/init-vben.sh`）会自动询问并只保留选中的 UI 应用。

```
vue-vben-admin/
├── apps/
│   ├── web-antd/           # 默认 Ant Design Vue 应用
│   ├── web-antdv-next/     # Ant Design Vue 5.x 实验性
│   ├── web-ele/            # Element Plus 应用
│   ├── web-naive/          # Naive UI 应用
│   ├── web-tdesign/        # TDesign 应用
│   └── playground/         # 组件演示场（不要放业务代码）
├── packages/
│   ├── @core/              # 框架核心（API、组件、hooks、布局、偏好）
│   ├── effects/            # 副作用（权限、登录、订阅）
│   ├── locales/            # 国际化资源
│   ├── icons/              # 离线图标
│   ├── hooks/              # 通用 hooks
│   ├── constants/          # 常量
│   ├── styles/             # 全局样式
│   ├── utils/              # 工具函数
│   ├── types/              # 类型定义
│   ├── preferences/        # 用户偏好（主题、布局）
│   ├── access/             # 权限控制
│   └── request/            # HTTP 请求
├── scripts/                # 构建脚本
├── docs/                   # 文档源
└── internal/               # 内部工具
```

## 常用命令

### 安装与启动

```bash
# 克隆
git clone https://github.com/vbenjs/vue-vben-admin.git
cd vue-vben-admin

# 启用 corepack（自动安装指定 pnpm 版本）
npm i -g corepack

# 安装依赖（必须用 pnpm）
pnpm install

# 开发
pnpm dev                 # 交互式选择应用
pnpm run dev:antd        # Ant Design Vue 版本（推荐）
pnpm run dev:ele         # Element Plus
pnpm run dev:naive       # Naive UI
pnpm run dev:tdesign     # TDesign

# 构建
pnpm build               # 构建所有应用
pnpm run build:antd      # 只构建 web-antd

# 质量
pnpm lint                # 代码检查 + 自动修复
pnpm typecheck           # TS 类型检查
pnpm test                # 单元测试
```

### 单独操作某个应用

```bash
cd apps/web-antd
pnpm dev                 # 当前应用开发
pnpm build               # 当前应用构建
```

### npm 源国内镜像

```bash
# corepack 走 npmmirror
set COREPACK_NPM_REGISTRY=https://registry.npmmirror.com
pnpm install

# pnpm 自身
pnpm config set registry https://registry.npmmirror.com
```

## 推荐 IDE 配置

- **VS Code** + Volar + ESLint + Stylelint + Tailwind CSS IntelliSense
- 启用 `Take Over Mode` 提升 Vue 类型性能
- 推荐安装 Vben 团队提供的 [vben-admin 扩展包](https://marketplace.visualstudio.com/items?itemName=vben.vben-vscode)

## 关键技术决策

1. **不要在路由里同步 `import` 页面组件**，必须用动态 import，否则首屏体积爆炸
2. **不要绕过 `@vben/request`** 自己封装 axios，框架已处理 token 刷新、错误码、loading
3. **不要直接改 `packages/`** 下的代码，框架会升级覆盖；如需扩展请 fork
4. **不要在 `playground/`** 写业务代码，那是组件演示场
