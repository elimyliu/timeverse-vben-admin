# timeverse-vben-admin

> A skill for scaffolding enterprise-grade admin systems with [Vben Admin 5.x](https://doc.vben.pro/)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Vben Admin](https://img.shields.io/badge/Vben%20Admin-5.x-1890ff)](https://github.com/vbenjs/vue-vben-admin)
[![Vue 3](https://img.shields.io/badge/Vue-3.5-4FC08D)](https://vuejs.org)
[![TypeScript](https://img.shields.io/badge/TypeScript-5.x-3178C6)](https://www.typescriptlang.org)
[![pnpm](https://img.shields.io/badge/pnpm-9.x-F69220)](https://pnpm.io)

A reusable skill that turns natural-language requirements into production-ready Vben Admin 5.x projects. Comes with one-click scaffolding scripts, RBAC templates, CRUD page generators, and complete reference docs.

## Features

- **One-Command Scaffolding** — PowerShell + Bash scripts that clone, install, configure, and run in under 60 seconds
- **Multi-UI Support** — Works with Ant Design Vue (default), Element Plus, Naive UI, and TDesign
- **3 Permission Modes** — Frontend-fixed / Backend-dynamic / Hybrid (default)
- **CRUD Page Template** — Complete, copy-paste ready code for list/form/editor/modal
- **i18n Ready** — Built-in zh-CN / en-US with extensible locale structure
- **Theming** — Dark mode, color primary, layout switching via preferences
- **Mock Data** — Nitro-based local mock server for rapid prototyping
- **5 Reference Docs** — tech stack, architecture, permissions, routing, common features
- **Best Practices** — Encodes 10+ anti-patterns to avoid common Vben pitfalls

## Quick Start

### 1. Install the Skill

**Option A — Download ZIP (recommended)**

Go to [https://github.com/elimyliu/timeverse-vben-admin](https://github.com/elimyliu/timeverse-vben-admin), click `Code` → `Download ZIP`, extract and copy the folder to your AI client's skills directory:

```powershell
# Trae global skills directory
Copy-Item -Path .\timeverse-vben-admin -Destination "$env:USERPROFILE\.trae\skills\timeverse-vben-admin" -Recurse -Force

# Cursor skills directory
Copy-Item -Path .\timeverse-vben-admin -Destination "$env:USERPROFILE\.cursor\skills\timeverse-vben-admin" -Recurse -Force

# Windsurf skills directory
Copy-Item -Path .\timeverse-vben-admin -Destination "$env:USERPROFILE\.windsurf\skills\timeverse-vben-admin" -Recurse -Force
```

**Option B — Git Clone**

```powershell
git clone https://github.com/elimyliu/timeverse-vben-admin.git
```

After cloning, copy to your AI client's skill directory (same as Option A).

**Option C — Project-level install (Trae)**

```powershell
mkdir -p .trae\skills
git clone https://github.com/elimyliu/timeverse-vben-admin.git .trae\skills\timeverse-vben-admin
```

### Using with Other AI Clients

The core of this skill is the `SKILL.md` instruction set. Here's how to use it with different clients:

| Client | How to Install |
|---|---|
| **Trae** | Copy to `~/.trae/skills/` or project `.trae/skills/` |
| **Cursor** | Paste `SKILL.md` content into Rules → Custom Instructions |
| **Windsurf** | Copy to `~/.windsurf/skills/` |
| **Claude Code** | `claude -p "Load SKILL.md: \$(cat SKILL.md)"` |
| **GitHub Copilot** | Add `SKILL.md` content to `.github/copilot-instructions.md` |

### 2. Use the Skill

Open the IDE and chat naturally:

```
Build an order management admin with Vben
Create a user/role/menu management admin with Vben
Add a CRUD page for products in my Vben project
Switch permissions from frontend to backend dynamic mode
```

The skill auto-activates and walks you through the implementation.

## One-Command Scaffolding

Don't have a project yet? Use the bundled scaffolding script:

```powershell
# Windows PowerShell
.\templates\init-vben.ps1                               # Interactive UI selection
.\templates\init-vben.ps1 -AppName "my-crm" -UI "ele"  # Direct parameters
```

```bash
# macOS / Linux
chmod +x templates/init-vben.sh
./templates/init-vben.sh my-admin antd mixed
```

This will:

1. Check Node.js >= 22.18 and Git
2. Clone Vben Admin 5.x (only keep selected UI framework)
3. Enable corepack & install pnpm dependencies
4. Patch `preferences.ts` with your UI library and access mode
5. Launch the dev server at http://localhost:5555

## What's in the Box

```
timeverse-vben-admin/
├── SKILL.md                          → Main skill definition
├── skill.yaml                        → Skill metadata
├── README.md                         → This file
├── README.zh-CN.md                   → Chinese documentation
├── LICENSE                           → MIT License
├── CHANGELOG.md                      → Release history
├── CONTRIBUTING.md                   → Contribution guide
├── .gitignore                        → Excludes
├── reference/                        → Deep-dive docs
│   ├── tech-stack.md                 → Versions, commands, deps
│   ├── architecture.md               → Directory layout, conventions
│   ├── permissions.md                → RBAC: 3 modes + 4 button APIs
│   ├── routing.md                    → Routes, menu, meta config
│   ├── common-features.md            → Login, theme, i18n, HTTP, mock
│   ├── data-visualization.md         → ECharts integration, Dashboard layout
│   └── industry-templates.md         → 19 industry presets
├── templates/                        → Copy-paste starters
│   ├── crud-page.md                  → Full user-management page
│   ├── crud-advanced.md              → Tree table, batch ops, import/export, drag-sort
│   ├── dashboard.md                  → Workspace + analytics templates
│   ├── init-vben.ps1                 → Scaffolding script (Windows PowerShell)
│   ├── init-vben.sh                  → Scaffolding script (macOS/Linux Bash)
│   └── scaffolding-script.md         → Script usage guide
```

## Trigger Keywords

The skill auto-activates when you mention any of these:

| Chinese | English |
|---|---|
| 搭建后台、管理系统、中后台、admin、vben、权限系统、CRUD 页面、Dashboard、RBAC | build admin, admin system, RBAC, CRUD, dashboard, role-based access |

## Tech Stack (Vben Admin 5.x)

| Layer | Tech |
|---|---|
| Framework | Vue 3.5 + Vite 6 + TypeScript 5 |
| Package Manager | pnpm (via corepack) |
| Repo | Pnpm Monorepo + Turborepo + Changeset |
| State | Pinia |
| HTTP | Axios (`requestClient`) |
| Icons | Iconify (offline) |
| Table | VxeTable (`VbenVxeTable`) |
| Form | Vben Form (`useVbenForm`) |
| Mock | Nitro |
| Tests | Vitest |
| Lint | Oxfmt / Oxlint / ESLint / Stylelint |

## Documentation

For the official Vben Admin 5.x docs, see [https://doc.vben.pro/](https://doc.vben.pro/).

This skill is a curated knowledge layer on top — it knows which APIs to use, which patterns to follow, and which pitfalls to avoid.

## Contributing

Contributions are welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md) first.

```bash
# Fork & clone
git clone https://github.com/elimyliu/timeverse-vben-admin.git
cd timeverse-vben-admin

# Make changes in a feature branch
git checkout -b feat/better-templates
git commit -m "feat: add dashboard template"
git push origin feat/better-templates
# Open a Pull Request
```

## License

[MIT](LICENSE) &copy; timeverse

## Credits

- [Vben Admin](https://github.com/vbenjs/vue-vben-admin) — the underlying framework
- All contributors who help keep this skill accurate and up-to-date

## Disclaimer

This is an unofficial community skill. It is not affiliated with the Vben Admin team. Always refer to the [official Vben docs](https://doc.vben.pro/) for authoritative information.

---

<p align="center">Made with love for the Vben Admin community</p>
