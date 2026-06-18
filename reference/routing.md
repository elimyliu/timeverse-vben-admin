# 路由与菜单

Vben Admin 的**菜单由路由文件自动生成**，无需单独维护菜单配置。

## 路由类型

| 类型 | 位置 | 说明 |
|---|---|---|
| **核心路由** | `src/router/routes/core/` | 框架内置（根、登录、404、403），**不要改** |
| **静态路由** | `src/router/routes/static/` | 项目启动时确定的路由 |
| **动态路由** | `src/router/routes/modules/` | 业务模块路由（**主要写在这里**） |
| **外部路由** | `src/router/routes/external/` | 无 Layout 包裹的页面（内嵌用） |

---

## 新增一个页面（3 步）

### Step 1: 添加路由

在 `src/router/routes/modules/<业务模块>.ts` 添加：

```ts
import type { RouteRecordRaw } from 'vue-router';
import { $t } from '#/locales';

const routes: RouteRecordRaw[] = [
  {
    name: 'SystemUser',
    path: '/system/user',
    component: () => import('#/views/system/user/index.vue'),
    meta: {
      title: $t('page.system.user.title'),
      icon: 'mdi:account-cog',
      authority: ['admin'], // 权限
      keepAlive: true,      // 缓存
    },
  },
];

export default routes;
```

### Step 2: 添加页面

在 `src/views/system/user/index.vue`：

```vue
<script lang="ts" setup>
import { ref } from 'vue';
const count = ref(0);
</script>

<template>
  <div>
    <h1>User Management</h1>
  </div>
</template>
```

### Step 3: 启动验证

`pnpm dev:antd` 后访问 `http://localhost:5555/system/user`。

---

## 多级路由（嵌套菜单）

```ts
const routes: RouteRecordRaw[] = [
  {
    meta: {
      icon: 'ic:baseline-view-in-ar',
      title: $t('demos.title'),
    },
    name: 'Demos',
    path: '/demos',
    redirect: '/demos/access',  // 默认进第一个子路由
    children: [
      {
        name: 'DemoAccess',
        path: '/demos/access',
        component: () => import('#/views/demos/access/index.vue'),
        meta: {
          icon: 'ic:round-menu',
          title: $t('demos.access'),
        },
      },
      {
        name: 'DemoNested',
        path: '/demos/nested',
        meta: {
          icon: 'ic:round-menu',
          title: $t('demos.nested'),
        },
        redirect: '/demos/nested/menu1',
        children: [
          {
            name: 'Menu1Demo',
            path: '/demos/nested/menu1',
            component: () => import('#/views/demos/nested/menu-1.vue'),
            meta: { title: $t('demos.nested.menu1') },
          },
        ],
      },
    ],
  },
];
```

---

## 路由 Meta 完整配置

```ts
interface RouteMeta {
  title: string;            // 必填：菜单/标签标题
  icon?: string;            // 图标（Iconify 格式）
  activeIcon?: string;      // 激活态图标
  authority?: string[];     // 可访问角色 ['super', 'admin']
  ignoreAccess?: boolean;   // 忽略权限检查
  keepAlive?: boolean;      // 标签页 keep-alive
  hideInMenu?: boolean;     // 菜单中隐藏
  hideInTab?: boolean;      // 标签页中隐藏
  hideInBreadcrumb?: boolean;
  hideChildrenInMenu?: boolean;
  affixTab?: boolean;       // 固定标签（不可关闭）
  affixTabOrder?: number;
  badge?: string;           // 角标文本
  badgeType?: 'dot' | 'normal';
  badgeVariants?: 'default' | 'primary' | 'success' | 'warning' | 'destructive';
  iframeSrc?: string;       // 内嵌 iframe
  link?: string;            // 外链（新窗口打开）
  order?: number;           // 一级菜单排序
  query?: Recordable;       // 路由默认 query
  noBasicLayout?: boolean;  // 不使用基础布局
  menuVisibleWithForbidden?: boolean;  // 菜单可见但禁止访问（403）
  openInNewWindow?: boolean;
  domCached?: boolean;      // DOM 缓存（解决复杂 tab 切换卡顿）
}
```

---

## 常用 Meta 场景

### 详情页（菜单隐藏但可访问）

```ts
{
  name: 'UserDetail',
  path: '/system/user/detail/:id',
  component: () => import('#/views/system/user/detail.vue'),
  meta: {
    title: '用户详情',
    hideInMenu: true,
    hideInTab: true, // 不显示在标签页
    activePath: '/system/user', // 激活父菜单
  },
}
```

### 固定标签的首页

```ts
{
  name: 'Dashboard',
  path: '/',
  component: () => import('#/views/dashboard/index.vue'),
  meta: {
    title: 'Dashboard',
    affixTab: true,
    affixTabOrder: 0,
  },
}
```

### 外链

```ts
{
  path: '/external-link',
  meta: { title: '外链', link: 'https://example.com' },
}
```

### 内嵌 Iframe

```ts
{
  path: '/iframe-page',
  component: () => import('#/views/_core/iframe/index.vue'),
  meta: {
    title: '内嵌页',
    iframeSrc: 'https://example.com',
  },
}
```

### 不使用基础布局（如登录页、营销页）

```ts
{
  path: '/landing',
  component: () => import('#/views/landing/index.vue'),
  meta: {
    title: '落地页',
    noBasicLayout: true,
  },
}
```

---

## 路由刷新

```ts
import { useRefresh } from '@vben/hooks';

const { refresh } = useRefresh();
refresh(); // 刷新当前路由
```

---

## 路由跳转

### 声明式

```vue
<RouterLink :to="{ name: 'SystemUser' }">用户管理</RouterLink>
<RouterLink :to="{ path: '/system/user' }">用户管理</RouterLink>
```

### 编程式

```ts
const router = useRouter();
router.push({ name: 'SystemUser' });
router.push({ path: '/system/user', query: { id: 1 } });
router.replace({ path: '/system/user' });
router.go(-1);
```

### 跳转并保留 query / hash

```ts
router.push({
  name: 'UserDetail',
  params: { id: 123 },
  query: { tab: 'profile' },
  hash: '#section1',
});
```

---

## 标签页（Tab）控制

每个 Tab 用唯一 key 标识，3 种方式（优先级递减）：

```ts
// 1. query.pageKey（最高）
router.push({ path: '/foo', query: { pageKey: 'unique-key' } });

// 2. fullPath（默认）
// meta.fullPathKey !== false → 用 fullPath

// 3. path
// meta.fullPathKey === false → 用 path
```

---

## 常见错误

| 错误 | 原因 |
|---|---|
| 菜单不显示 | `meta.title` 没值 / `hideInMenu: true` |
| 点击菜单 404 | 路由的 `component` 路径写错 |
| 多级菜单父级不显示 | 父级没有 `component` 但也没设 `redirect` |
| 详情页关闭后回到列表失败 | 列表页 `keepAlive: false` |
| Iframe 加载失败 | `iframeSrc` 跨域或目标网站禁 Iframe |
| 角色切换后菜单不更新 | 需要 `router.replace({ name: '...' })` 触发守卫 |
