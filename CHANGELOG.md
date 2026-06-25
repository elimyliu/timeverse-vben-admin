# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Planned
- Add role-management CRUD template
- Add i18n key generator script
- Add CI workflow (`.github/workflows/ci.yml`)

## [2.0.0] - 2026-06-24

### Added
- 中文版 README (`README.zh-CN.md`)
- 19 种行业模板 (`reference/industry-templates.md`) — 电商、ERP、CRM、CMS、SaaS、O2O、餐饮、酒店 PMS、支付、金融、FMS、HIS、教育、物业、TMS、MES、OA、API 开放平台、通用后台
- 高级 CRUD 模板 (`templates/crud-advanced.md`) — 树形表格、批量操作、导入导出、拖拽排序
- Dashboard 模板 (`templates/dashboard.md`) — 工作台 + 分析页，含 KPI 卡片、图表、待办任务、19 种行业 Dashboard 参考
- 数据可视化指南 (`reference/data-visualization.md`) — ECharts 集成、图表组件、Dashboard 布局

### Changed
- 脚手架脚本提取为独立可执行文件 (`templates/init-vben.ps1` + `templates/init-vben.sh`)
- 权限码格式统一为 `module:action` 风格（`system:user:list`）
- 超级管理员角色名统一为 `super_admin`
- CRUD 模板默认 UI 从 Element Plus 改为 Ant Design Vue（默认 UI）
- 触发关键词扩展覆盖全部 19 种行业模板
- 更新 `scaffolding-script.md` 为轻量文档，引用独立脚本文件

## [1.0.0] - 2026-06-17

### Added
- Initial release
- 5 reference documents (tech-stack, architecture, permissions, routing, common-features)
- 2 template documents (CRUD page, scaffolding scripts)
- PowerShell + Bash scaffolding scripts (`init-vben.ps1` / `init-vben.sh`)
- Support for 4 UI libraries: Ant Design Vue, Element Plus, Naive UI, TDesign
- 3 permission modes: frontend, backend, mixed (default)
- Comprehensive anti-patterns section (10+ pitfalls)
- MIT License
- Contributing guide
- English README with badges and quick-start

[Unreleased]: https://github.com/<your-username>/timeverse-vben-admin/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/<your-username>/timeverse-vben-admin/releases/tag/v1.0.0
