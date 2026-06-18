# 架构与目录约定

## 应用目录（以 `apps/web-antd` 为例）

```
apps/web-antd/
├── src/
│   ├── api/                       # 后端接口定义（按业务模块分目录）
│   │   ├── core/                  # 框架级接口（登录、用户、菜单、权限码）
│   │   ├── system/                # 业务系统接口（用户管理、角色管理等）
│   │   └── ...
│   ├── assets/                    # 静态资源（图片、字体）
│   ├── bootstrap.ts               # 应用启动引导
│   ├── components/                # 应用级业务组件
│   │   └── ...
│   ├── constants/                 # 应用级常量
│   ├── layouts/                   # 布局组件（一般不需要修改）
│   ├── locales/                   # 国际化文案
│   │   ├── langs/
│   │   │   ├── zh-CN.ts
│   │   │   └── en-US.ts
│   │   └── i18n.ts
│   ├── main.ts                    # 入口文件（不要改）
│   ├── plugins/                   # Vben 插件
│   ├── preferences.ts             # 应用偏好覆盖（主题、布局、accessMode）
│   ├── router/
│   │   ├── access.ts              # 权限路由生成
│   │   ├── guard.ts               # 路由守卫
│   │   ├── routes.ts              # 路由汇总
│   │   └── routes/
│   │       ├── core/              # 核心路由（不要改）
│   │       ├── static/            # 静态路由（无权限）
│   │       └── modules/           # 业务路由（按模块分文件）
│   │           ├── system.ts
│   │           ├── dashboard.ts
│   │           └── ...
│   ├── service/
│   │   ├── api.ts                 # API 聚合
│   │   └── request/               # HTTP 请求封装（不要改）
│   │       └── index.ts
│   ├── store/                     # Pinia 状态
│   │   ├── auth.ts                # 登录态、用户信息
│   │   └── ...
│   ├── utils/                     # 工具
│   ├── views/                     # 业务页面
│   │   ├── _core/                 # 框架级页面（登录、403、404、个人中心）
│   │   ├── dashboard/             # 业务页面，按路由模块对应目录
│   │   │   ├── analytics/
│   │   │   │   └── index.vue
│   │   │   └── workspace/
│   │   │       └── index.vue
│   │   └── system/
│   │       └── user/
│   │           └── index.vue
│   └── ...
├── public/                        # 不打包的静态资源
├── index.html
├── vite.config.ts                 # Vite 配置
├── tailwind.config.ts
├── tsconfig.json
└── package.json
```

## 关键路径速查

| 用途 | 路径 |
|---|---|
| 改登录逻辑 | `src/views/_core/authentication/login.vue` |
| 改登录 API | `src/api/core/auth.ts` |
| 改登录态 | `src/store/auth.ts` |
| 改用户信息 | `src/api/core/user.ts` |
| 加新菜单 | `src/router/routes/modules/<业务>.ts` |
| 加新页面 | `src/views/<业务>/<page>/index.vue` |
| 加新接口 | `src/api/<业务>/<module>.ts` |
| 加新国际化 | `src/locales/langs/zh-CN.ts` |
| 改主题/布局 | `src/preferences.ts` |
| 改权限模式 | `src/preferences.ts` 中 `accessMode` |
| 改请求 baseURL | `src/preferences.ts` 中 `apiURL` |
| 写 Mock 接口 | `mock/` 目录（Nitro） |

## 模块化原则

### 1. 路由 → 视图 → API → Store 一一对应

```
src/router/routes/modules/user.ts
   ↓
src/views/system/user/index.vue
   ↓
src/api/system/user.ts
   ↓ (可选)
src/store/user.ts
```

### 2. 业务组件就近放

- 只在一个页面用 → 放在该页面同目录的 `components/`
- 在多个页面用 → 放在 `apps/web-antd/src/components/<业务模块>/`
- 框架级通用 → 已经在 `packages/@core/ui-kit/` 里了

### 3. 命名约定

| 类型 | 规范 | 示例 |
|---|---|---|
| 路由 name | 大驼峰，**与目录名一致** | `UserManagement` |
| 路由 path | 小写中横线 | `/system/user` |
| 文件名 | 小写中横线 | `user-list.vue` |
| 组件名 | 大驼峰 | `UserList` |
| API 函数 | 小驼峰 + 动词 | `getUserList`、`createUser` |
| Store | 大驼峰 + Store | `useUserStore` |
| Hook | use + 大驼峰 | `useUserList` |
| 常量 | 大写蛇形 | `API_BASE_URL` |

## 精简版（thin）

如果只需要一个**纯净**的 Vben 模板（不要示例代码）：

```bash
# 方法 1：用精简仓库
git clone https://github.com/vbenjs/vben-admin-thin.git

# 方法 2：从主仓库移除示例代码
# 删除 apps/web-antd/src/views/demos/ 与 playground/ 下业务页面
# 删除 router/routes/modules/demos.ts
```

精简版只保留：
- 框架核心能力
- 1 个登录页 + 1 个 dashboard
- 1 个 404 页面
- 用户/角色/菜单的基础 CRUD

## 不应该修改的目录

- `packages/@core/` — 框架核心
- `packages/effects/` — 副作用层
- `apps/web-antd/src/router/routes/core/` — 核心路由
- `apps/web-antd/src/service/request/` — HTTP 封装
- `apps/web-antd/src/main.ts` — 入口

如需扩展，请用以下方式：

1. `src/preferences.ts` 覆盖配置
2. `src/plugins/` 注册自定义插件
3. `src/components/` 添加业务组件
4. `apps/web-antd/mock/` 添加 Mock
5. fork `packages/` 自己改并发布私有包
