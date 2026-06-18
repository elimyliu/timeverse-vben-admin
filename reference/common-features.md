# 登录 / 主题 / 国际化 / 切换 UI 库

## 一、登录

### 默认登录流程

1. 用户访问任意页面 → `router/guard.ts` 拦截
2. 未登录跳到 `/login`
3. 提交登录表单 → `authApi.login()` 返回 token
4. 调 `authStore.setToken()` 存到 cookie
5. 调 `fetchUserInfo()` + `getAccessCodes()` 获取用户信息与权限
6. 根据 `accessMode` 生成动态路由
7. 跳到登录前要访问的页面（或 `/`）

### 改登录逻辑

```ts
// apps/web-antd/src/api/core/auth.ts
export async function loginApi(data: LoginReq) {
  return requestClient.post<LoginResp>('/auth/login', data);
}
```

```ts
// apps/web-antd/src/store/auth.ts
const authStore = useAuthStore();
async function authLogin(form: LoginReq) {
  // 1. 登录
  const { accessToken, refreshToken } = await loginApi(form);
  authStore.setToken(accessToken, refreshToken);
  // 2. 拉用户信息
  const [userInfo, accessCodes] = await Promise.all([
    fetchUserInfo(),
    getAccessCodes(),
  ]);
  authStore.setUserInfo(userInfo);
  accessStore.setAccessCodes(accessCodes);
}
```

### 替换为 OAuth / SSO

```ts
// apps/web-antd/src/views/_core/authentication/login.vue
function handleLogin() {
  // 跳到 OAuth
  window.location.href = `https://sso.example.com/login?redirect=${encodeURIComponent(window.location.origin)}`;
}

// 在 callback 页面处理 token
const params = new URLSearchParams(location.search);
authStore.setToken(params.get('access_token'), params.get('refresh_token'));
```

### 自定义登录页

直接修改 `src/views/_core/authentication/login.vue` 即可，组件内部已封装好表单提交逻辑。

---

## 二、主题与布局偏好

### 配置文件 `src/preferences.ts`

```ts
import { defineOverridesPreferences } from '@vben/preferences';

export const overridesPreferences = defineOverridesPreferences({
  app: {
    name: '我的后台',
    logo: 'https://example.com/logo.svg',
    accessMode: 'mixed',
  },
  theme: {
    colorPrimary: '#1890ff',  // 主题色
    mode: 'light',            // 'light' | 'dark' | 'auto'
    radius: 0.5,              // 圆角
  },
  layout: {
    type: 'sidebar-nav',      // 'sidebar-nav' | 'header-nav' | 'mixed-nav'
    sideCollapsedWidth: 60,
    showBreadcrumb: true,
    showFooter: true,
  },
  shortcutKeys: {
    globalSearch: true,
    globalLogout: true,
  },
});
```

### 动态切换主题色（运行时）

```ts
import { usePreferences } from '@vben/preferences';

const { theme, setTheme } = usePreferences();

function changeColor(color: string) {
  setTheme({ colorPrimary: color });
}
```

### 暗色模式

```ts
const { theme, setTheme } = usePreferences();
setTheme({ mode: 'dark' });
```

---

## 三、国际化（i18n）

### 配置

`apps/web-antd/src/preferences.ts`:

```ts
i18n: {
  enable: true,
  defaultLocale: 'zh-CN',
  fallbackLocale: 'en-US',
  availableLocales: ['zh-CN', 'en-US'],
}
```

### 添加语言

1. 在 `src/locales/langs/` 创建新文件 `ja-JP.ts`：

```ts
export default {
  page: {
    home: { title: 'ホーム' },
  },
};
```

2. 注册到 `src/locales/i18n.ts`

### 模板中使用

```vue
<template>
  <div>{{ $t('page.home.title') }}</div>
</template>
```

### 脚本中使用

```ts
import { $t } from '#/locales';
const title = $t('page.home.title');
```

### 切换语言

```ts
import { usePreferences } from '@vben/preferences';
const { setLocale } = usePreferences();
setLocale('en-US');
```

---

## 四、切换 UI 库

Vben 提供 4 套完整 UI 库应用：

| App | UI 库 | 启动命令 |
|---|---|---|
| `apps/web-antd` | Ant Design Vue | `pnpm dev:antd` |
| `apps/web-antdv-next` | Ant Design Vue 5.x | `pnpm dev:antdv` |
| `apps/web-ele` | Element Plus | `pnpm dev:ele` |
| `apps/web-naive` | Naive UI | `pnpm dev:naive` |
| `apps/web-tdesign` | TDesign | `pnpm dev:tdesign` |

### 业务代码是否需要改？

- **通常不需要** —— `packages/@core/` 已做 UI 抽象，业务页面用 `VbenVxeTable` / `useVbenForm` 等封装组件
- 仅当使用了特定 UI 库的 API 时才需改

### 自定义新增 UI 库

参考 `apps/web-antd/` 与 `apps/web-naive/` 的差异，主要是：
- `src/adapter/` 目录下的组件适配
- `package.json` 的依赖

---

## 五、HTTP 请求

### 直接调用

```ts
import { requestClient } from '#/api/request';

export async function getUserListApi(params: PageQuery) {
  return requestClient.get<PageResp<User>>('/system/user/list', { params });
}
```

### 业务 API 文件 `src/api/system/user.ts`

```ts
import { requestClient } from '#/api/request';

export namespace SystemUserApi {
  export interface User {
    id: string;
    username: string;
    nickname: string;
    email: string;
    status: 'enabled' | 'disabled';
    roles: string[];
  }
  export interface PageQuery {
    page: number;
    pageSize: number;
    keyword?: string;
  }
  export interface PageResp<T> {
    items: T[];
    total: number;
  }
}

export async function getUserListApi(params: SystemUserApi.PageQuery) {
  return requestClient.get<SystemUserApi.PageResp<SystemUserApi.User>>(
    '/system/user/list',
    { params },
  );
}

export async function createUserApi(data: Partial<SystemUserApi.User>) {
  return requestClient.post('/system/user', data);
}

export async function updateUserApi(id: string, data: Partial<SystemUserApi.User>) {
  return requestClient.put(`/system/user/${id}`, data);
}

export async function deleteUserApi(id: string) {
  return requestClient.delete(`/system/user/${id}`);
}
```

### requestClient 自动处理

- ✅ Token 注入（Authorization 头）
- ✅ 401 自动调 refresh token
- ✅ 全局 loading
- ✅ 错误码统一处理（如 401 跳登录、403 跳无权限页）
- ✅ 请求/响应拦截

### 关闭 loading

```ts
requestClient.get('/foo', { meta: { noLoading: true } });
```

---

## 六、Mock 数据

Vben 5.x 使用 [Nitro](https://nitro.unjs.io/) 做本地 Mock。

### 创建 Mock

在 `apps/web-antd/mock/` 下创建：

```ts
// apps/web-antd/mock/system-user.mock.ts
import { defineMock } from 'vite-plugin-mock-dev-server';

export default defineMock([
  {
    url: '/api/system/user/list',
    method: 'POST',
    body: {
      items: [
        { id: '1', username: 'admin', nickname: '管理员' },
        { id: '2', username: 'user', nickname: '用户' },
      ],
      total: 2,
    },
  },
]);
```

### 启用 Mock

`apps/web-antd/src/preferences.ts`:

```ts
app: {
  enableMock: true,
}
```

### baseURL 约定

Mock 走 `/api/*`，不需要单独配 baseURL。
