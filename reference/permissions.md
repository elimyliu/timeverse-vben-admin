# 权限系统（RBAC）

Vben Admin 提供**三种**权限模式，配置在 `src/preferences.ts` 的 `app.accessMode`：

| 模式 | 值 | 适用场景 |
|---|---|---|
| 前端固定 | `'frontend'` | 角色固定的小型项目 |
| 后端动态 | `'backend'` | 权限复杂的中大型项目 |
| **混合（默认）** | `'mixed'` | 通用项目推荐 |

```ts
// apps/web-antd/src/preferences.ts
import { defineOverridesPreferences } from '@vben/preferences';

export const overridesPreferences = defineOverridesPreferences({
  app: {
    accessMode: 'mixed', // frontend | backend | mixed
  },
});
```

---

## 模式 1: 前端固定权限

**原理**: 在路由 `meta.authority` 中写死哪些角色可访问，登录后用 `userInfo.roles` 过滤路由。

### 配置

```ts
// src/router/routes/modules/system.ts
{
  name: 'SystemUser',
  path: '/system/user',
  component: () => import('#/views/system/user/index.vue'),
  meta: {
    authority: ['super', 'admin'], // 只有 super / admin 可访问
    title: $t('page.system.user.title'),
    icon: 'mdi:account-cog',
  },
}
```

```ts
// src/store/auth.ts（确保登录接口返回 roles）
userInfo = await fetchUserInfo();
userInfo.roles = ['super', 'admin']; // 后端返回
authStore.setUserInfo(userInfo);
```

### 菜单可见但禁止访问

```ts
{
  meta: {
    authority: ['super'],
    menuVisibleWithForbidden: true, // 菜单可见，访问会跳 403
  },
}
```

---

## 模式 2: 后端动态菜单

**原理**: 登录后调用后端接口获取菜单数据，前端按约定格式生成路由。

### 后端返回数据格式

```ts
const menus = [
  {
    meta: { order: -1, title: 'page.dashboard.title' },
    name: 'Dashboard',
    path: '/',
    redirect: '/analytics',
    children: [
      {
        name: 'Analytics',
        path: '/analytics',
        component: '/dashboard/analytics/index', // 去掉 views/ 和 .vue
        meta: { affixTab: true, title: 'page.dashboard.analytics' },
      },
    ],
  },
  {
    name: 'Test',
    path: '/test',
    component: '/test/index',
    meta: { title: 'page.test', noBasicLayout: true },
  },
];
```

### 前端接入

```ts
// src/router/access.ts
async function generateAccess(options: GenerateMenuAndRoutesOptions) {
  return await generateAccessible(preferences.app.accessMode, {
    fetchMenuListAsync: async () => {
      return await getAllMenus(); // 调后端
    },
  });
}
```

---

## 模式 3: 混合模式（推荐）

**原理**: 静态路由（`meta.authority`）+ 后端动态菜单 + 角色过滤。

- 静态路由用 `meta.authority` 控制
- 后端菜单按角色下发
- 两者并行处理后合并

---

## 按钮级权限

无论哪种模式，按钮级权限都通过 `@vben/access` 实现。

### 接口约定

登录后调用 `getAccessCodes()` 获取权限码数组：

```ts
const [userInfo, accessCodes] = await Promise.all([
  fetchUserInfo(),
  getAccessCodes(),
]);
authStore.setUserInfo(userInfo);
accessStore.setAccessCodes(accessCodes); // ['system:user:list', 'system:user:create', ...]
```

### 4 种用法

#### ① `<AccessControl>` 组件（最常用）

```vue
<script lang="ts" setup>
import { AccessControl } from '@vben/access';
</script>

<template>
  <AccessControl :codes="['system:user:list']" type="code">
    <Button>超级管理员可见</Button>
  </AccessControl>
</template>
```

#### ② `useAccess().hasAccessByCodes` API

```vue
<script lang="ts" setup>
import { useAccess } from '@vben/access';
const { hasAccessByCodes } = useAccess();
</script>

<template>
  <Button v-if="hasAccessByCodes(['system:user:list'])">超级管理员可见</Button>
</template>
```

#### ③ `v-access:code` 指令（最简洁）

```vue
<template>
  <Button v-access:code="'system:user:list'">超级管理员可见</Button>
  <Button v-access:code="['system:user:list', 'system:user:create']">超级+管理员可见</Button>
</template>
```

#### ④ 角色判断

```vue
<template>
  <Button v-access:role="'super'">超级角色可见</Button>
  <Button v-access:role="['super', 'admin']">超级+管理员可见</Button>
</template>
```

---

## 权限码设计建议

| 模块 | 前缀 | 示例 |
|---|---|---|
| 用户管理 | `system:user` | `system:user:list` 查询、`system:user:create` 新增、`system:user:edit` 编辑、`system:user:delete` 删除、`system:user:export` 导出 |
| 角色管理 | `system:role` | `system:role:list` 查询、`system:role:create` 新增... |
| 菜单管理 | `system:menu` | `system:menu:list` 查询、`system:menu:create` 新增... |
| 订单管理 | `order` | `order:list` 查询、`order:create` 新增... |
| 系统设置 | `setting` | `setting:list` 查询、`setting:edit` 编辑... |

规则：`<模块>:<子模块>:<动作>`  →  list=查询、create=新增、edit=编辑、delete=删除、export=导出

---

## 登录态与退出

```ts
// src/store/auth.ts
const authStore = useAuthStore();

// 登录
const { accessToken, refreshToken } = await loginApi(form);
authStore.setToken(accessToken, refreshToken);

// 获取用户信息
const userInfo = await fetchUserInfo();
authStore.setUserInfo(userInfo);

// 注销
authStore.logout();
```

**Token 刷新**已在 `@vben/request` 中自动处理，无需手动调用。

---

## 多租户 / 多角色

```ts
// userInfo.roles 可包含多个角色
userInfo.roles = ['admin', 'operator'];

// 路由的 authority 只要命中其中一个即通过
{ meta: { authority: ['admin'] } } // admin 可访问
```

切换角色：

```ts
authStore.setUserInfo({ ...userInfo, roles: ['operator'] });
// 路由表会自动重算
```

---

## 常见错误

| 错误 | 原因 | 修复 |
|---|---|---|
| 路由不显示 | 角色不匹配 `meta.authority` | 确认 userInfo.roles 含匹配值 |
| 403 但能看见菜单 | 设置了 `menuVisibleWithForbidden` | 改权限或移除该字段 |
| 按钮一直隐藏 | 没调 `getAccessCodes` | 确认 `accessStore.setAccessCodes` |
| 动态菜单不显示 | 后端返回格式不对 | 严格按 `name/path/component/meta` 字段 |
| 路由刷新后丢失 | 没用 `useRefresh` | `import { useRefresh } from '@vben/hooks'` |
