# timeverse-vben-admin

> 基于 [Vben Admin 5.x](https://doc.vben.pro/) 快速搭建企业级后台管理系统的 AI 技能包

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Vben Admin](https://img.shields.io/badge/Vben%20Admin-5.x-1890ff)](https://github.com/vbenjs/vue-vben-admin)
[![Vue 3](https://img.shields.io/badge/Vue-3.5-4FC08D)](https://vuejs.org)
[![TypeScript](https://img.shields.io/badge/TypeScript-5.x-3178C6)](https://www.typescriptlang.org)
[![pnpm](https://img.shields.io/badge/pnpm-9.x-F69220)](https://pnpm.io)

将自然语言需求直接转化为可运行的 Vben Admin 5.x 项目。提供一键脚手架脚本、RBAC 权限模板、CRUD 页面生成器及完整的参考文档。

## ✨ 功能特性

  - 🏗 **一键脚手架** — PowerShell + Bash 脚本，克隆、安装、配置、启动，60 秒内完成
  - 🎨 **多 UI 支持** — 支持 Ant Design Vue（默认）、Element Plus、Naive UI、TDesign 四种框架
  - 🔐 **三种权限模式** — 前端固定 / 后端动态 / 混合模式（默认）
  - 📋 **CRUD 页面模板** — 完整的列表/表单/编辑/弹窗代码，开箱即用
  - 🌐 **国际化** — 内置 zh-CN / en-US，轻松扩展多语言
  - 🎭 **主题切换** — 深色模式、主题色、布局切换，通过 preferences 配置
  - 📦 **Mock 数据** — 基于 Nitro 的本地 Mock 服务，快速原型开发
  - � **数据可视化** — 内置 ECharts 集成方案，折线图、柱状图、饼图、仪表盘开箱即用
  - � **6 份参考文档** — 技术栈、架构、权限、路由、通用功能、数据可视化
  - 🛠 **最佳实践** — 内置 10+ 条反模式清单，避免常见 Vben 开发陷阱
  - 🏭 **19 种行业模板** — 电商、ERP、CRM、CMS、SaaS、O2O、HIS、MES 等

## 🚀 快速开始

### 1. 安装技能

**方式 A — 全局安装（推荐）**

```powershell
# 克隆仓库
git clone https://github.com/<your-username>/timeverse-vben-admin.git
# 复制到 Trae 全局技能目录
Copy-Item -Path .\timeverse-vben-admin -Destination "$env:USERPROFILE\.trae\skills\timeverse-vben-admin" -Recurse -Force
```

**方式 B — 项目级安装**

```powershell
# 在 Trae 项目根目录
mkdir -p .trae\skills
git clone https://github.com/<your-username>/timeverse-vben-admin.git .trae\skills\timeverse-vben-admin
```

### 2. 使用技能

在对话框中直接说出需求：

```
帮我用 Vben 搭建一个订单管理后台
基于 Vben 做一个用户/角色/菜单管理后台
在 Vben 项目里新增一个商品的 CRUD 页面
把 Vben 的权限从前端模式改成后端动态菜单
```

AI 将自动激活技能并引导你完成实现。

## 🛠 一键脚手架

还没有项目？使用配套脚手架脚本快速创建：

```powershell
# Windows PowerShell
.\templates\init-vben.ps1                               # 交互式选择 UI
.\templates\init-vben.ps1 -AppName "my-crm" -UI "ele"  # 直接指定参数
```

```bash
# macOS / Linux
chmod +x templates/init-vben.sh
./templates/init-vben.sh my-admin antd mixed
```

脚本会自动完成：

1. 检查环境（Node.js >= 22.18、Git、路径不含中文/空格）
2. 交互式选择或参数指定前端 UI 框架
3. 克隆 Vben Admin 5.x（仅保留选中的 UI 框架）
4. 启用 corepack 并安装 pnpm 依赖
5. 配置权限模式（写入 `preferences.ts`）
6. 启动开发服务器（http://localhost:5555）

## 📂 项目结构

```
timeverse-vben-admin/
├── SKILL.md                          ← 技能主定义文件
├── skill.yaml                        ← 技能元数据
├── README.md                         ← 英文说明
├── README.zh-CN.md                   ← 中文说明（当前文件）
├── LICENSE                           ← MIT 许可证
├── CHANGELOG.md                      ← 版本发布记录
├── CONTRIBUTING.md                   ← 贡献指南
├── .gitignore                        ← 排除规则
├── reference/                        ← 深度参考文档
│   ├── tech-stack.md                 ← 版本、命令、依赖
│   ├── architecture.md               ← 目录结构、编码约定
│   ├── permissions.md                ← RBAC：3 种模式 + 4 种按钮级用法
│   ├── routing.md                    ← 路由、菜单、meta 配置
│   ├── common-features.md            ← 登录、主题、国际化、HTTP、Mock
│   └── industry-templates.md         ← 19 种行业模板的预设菜单和权限
└── templates/                        ← 可直接复用的模板
    ├── crud-page.md                  ← 完整的 CRUD 用户管理页面
    ├── init-vben.ps1                 ← 脚手架脚本（Windows PowerShell）
    ├── init-vben.sh                  ← 脚手架脚本（macOS/Linux Bash）
    └── scaffolding-script.md         ← 脚本使用说明与参考
```

## 🎯 触发关键词

在对话框中提到以下关键词时技能自动激活：

| 关键词 |
|---|
| 搭建后台、管理系统、中后台、admin、vben |
| 权限系统、CRUD 页面、Dashboard、RBAC |
| 用户管理、角色管理、菜单管理、系统管理 |
| 电商后台、商品管理、订单管理、营销中心、财务管理 |
| ERP 系统、采购管理、销售管理、库存管理、生产管理 |
| CRM 系统、客户管理、销售漏斗、工单管理、客户公海 |
| CMS 系统、文章管理、内容管理、评论审核、分类管理 |
| SaaS 平台、租户管理、套餐订阅、应用管理、账单管理 |
| O2O 平台、门店管理、预约管理、技师管理、核销管理 |
| 外卖系统、餐饮系统、菜品管理、桌台管理、厨打管理 |
| 酒店管理、PMS、房态管理、预订管理、入住退房 |
| 支付系统、商户管理、交易流水、清结算、对账管理 |
| 金融后台、借款管理、理财产品、KYC、风控管理 |
| 财务系统、FMS、凭证管理、总账、预算管理、固定资产 |
| 医疗 HIS、挂号管理、住院管理、药房管理、电子病历 |
| 教育系统、学生管理、排课管理、成绩管理、招生管理 |
| 物业系统、房产管理、业主管理、报修管理、收费管理 |
| 物流 TMS、运单管理、路由规划、车辆管理、签收管理 |
| MES 系统、生产工单、质量管理、设备管理、工艺管理、生产看板 |
| OA 系统、审批管理、考勤管理、会议管理、文档管理 |
| API 开放平台、API 管理、流量控制、应用管理、调用统计 |

## 🏗 技术栈（Vben Admin 5.x）

| 层级 | 技术选型 |
|---|---|
| 框架 | Vue 3.5 + Vite 6 + TypeScript 5 |
| 包管理 | pnpm（通过 corepack） |
| 仓库 | Pnpm Monorepo + Turborepo + Changeset |
| 状态管理 | Pinia |
| HTTP 请求 | Axios（`requestClient`） |
| 图标 | Iconify（离线） |
| 表格 | VxeTable（`VbenVxeTable`） |
| 表单 | Vben Form（`useVbenForm`） |
| Mock | Nitro |
| 测试 | Vitest |
| 代码检查 | Oxfmt / Oxlint / ESLint / Stylelint |

## 📖 参考文档

- [Vben Admin 5.x 官方文档](https://doc.vben.pro/)
- [技术栈详情](reference/tech-stack.md) — 版本要求、常用命令、IDE 配置
- [架构指南](reference/architecture.md) — 目录结构、模块化原则、命名规范
- [权限系统](reference/permissions.md) — 三种权限模式、按钮级权限、权限码设计
- [路由配置](reference/routing.md) — 路由分类、新增页面、RouteMeta 完整配置
- [通用功能](reference/common-features.md) — 登录、主题、国际化、HTTP、Mock
- [数据可视化](reference/data-visualization.md) — ECharts 集成、图表组件、Dashboard 布局

## 🤝 贡献指南

欢迎贡献！请先阅读 [CONTRIBUTING.md](CONTRIBUTING.md)。

```bash
# Fork 并克隆
git clone https://github.com/<your-username>/timeverse-vben-admin.git
cd timeverse-vben-admin

# 在功能分支上修改
git checkout -b feat/better-templates
git commit -m "feat: add dashboard template"
git push origin feat/better-templates
# 提交 Pull Request
```

## 📜 许可证

[MIT](LICENSE) © timeverse

## 🙏 致谢

- [Vben Admin](https://github.com/vbenjs/vue-vben-admin) — 底层框架
- 所有为本技能贡献的开发者

## ⚠️ 免责声明

这是一个社区技能包，与 Vben Admin 官方团队无关联。权威信息请参考 [Vben 官方文档](https://doc.vben.pro/)。

---

<p align="center">为 Vben Admin 社区打造 ❤️</p>
