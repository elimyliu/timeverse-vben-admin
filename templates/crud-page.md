# CRUD 页面模板

## 完整示例：用户管理页

### 1. 路由 `src/router/routes/modules/system.ts`

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
      authority: ['admin'],
    },
  },
];

export default routes;
```

### 2. API `src/api/system/user.ts`

```ts
import { requestClient } from '#/api/request';

export namespace SystemUserApi {
  export interface UserEntity {
    id: string;
    username: string;
    nickname: string;
    email: string;
    status: 'enabled' | 'disabled';
    roles: string[];
    createdAt: string;
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
  export interface SaveReq {
    id?: string;
    username: string;
    nickname: string;
    email: string;
    status: 'enabled' | 'disabled';
    roles: string[];
  }
}

export async function getUserListApi(params: SystemUserApi.PageQuery) {
  return requestClient.get<SystemUserApi.PageResp<SystemUserApi.UserEntity>>(
    '/system/user/list',
    { params },
  );
}

export async function saveUserApi(data: SystemUserApi.SaveReq) {
  return data.id
    ? requestClient.put(`/system/user/${data.id}`, data)
    : requestClient.post('/system/user', data);
}

export async function deleteUserApi(id: string) {
  return requestClient.delete(`/system/user/${id}`);
}
```

### 3. 国际化 `src/locales/langs/zh-CN.ts`

```ts
export default {
  page: {
    system: {
      user: {
        title: '用户管理',
        search: {
          keyword: '用户名/昵称',
        },
        columns: {
          username: '用户名',
          nickname: '昵称',
          email: '邮箱',
          status: '状态',
          roles: '角色',
          createdAt: '创建时间',
          action: '操作',
        },
        status: {
          enabled: '启用',
          disabled: '禁用',
        },
        form: {
          title: '用户',
          username: '用户名',
          nickname: '昵称',
          email: '邮箱',
          status: '状态',
          statusEnabled: '启用',
          statusDisabled: '禁用',
          roles: '角色',
          required: '必填',
        },
        action: {
          add: '新增用户',
          edit: '编辑',
          delete: '删除',
          deleteConfirm: '确认删除该用户？',
        },
        message: {
          saveSuccess: '保存成功',
          deleteSuccess: '删除成功',
        },
      },
    },
  },
};
```

### 4. 视图 `src/views/system/user/index.vue`

```vue
<script lang="ts" setup>
import { ref, h } from 'vue';
import { useVbenVxeGrid, type VxeGridProps } from '#/adapter/vxe-table';
import { useVbenModal, type VbenFormProps } from '@vben/common-ui';
import {
  deleteUserApi,
  getUserListApi,
  saveUserApi,
  SystemUserApi,
} from '#/api/system/user';
import { $t } from '#/locales';
import { ElMessage, ElMessageBox } from 'element-plus'; // 或从 ant-design-vue 导入
import Editor from './editor.vue';

// 表格配置
const gridOptions: VxeGridProps<SystemUserApi.UserEntity> = {
  columns: [
    { title: $t('page.system.user.columns.username'), field: 'username' },
    { title: $t('page.system.user.columns.nickname'), field: 'nickname' },
    { title: $t('page.system.user.columns.email'), field: 'email' },
    {
      title: $t('page.system.user.columns.status'),
      field: 'status',
      cellRender: {
        name: 'Tag',
        props: (row: any) => ({
          color: row.status === 'enabled' ? 'success' : 'default',
        }),
      },
    },
    {
      title: $t('page.system.user.columns.createdAt'),
      field: 'createdAt',
    },
    {
      title: $t('page.system.user.columns.action'),
      width: 180,
      slots: { default: 'action' },
    },
  ],
  proxyConfig: {
    ajax: {
      query: async ({ page }) => {
        return await getUserListApi({
          page: page.currentPage,
          pageSize: page.pageSize,
        });
      },
    },
  },
  toolbarConfig: {
    refresh: true,
  },
};

const [Grid, gridApi] = useVbenVxeGrid({ gridOptions });

// 表单配置
const formData = ref<SystemUserApi.SaveReq>({} as any);
const [Modal, modalApi] = useVbenModal({
  connectedComponent: Editor,
  onBeforeOk: async () => {
    const valid = await modalApi.getData()?.formApi?.validate();
    if (!valid) return false;
    try {
      await saveUserApi(modalApi.getData().values);
      ElMessage.success($t('page.system.user.message.saveSuccess'));
      await gridApi.reload();
      return true;
    } catch {
      return false;
    }
  },
});

function onAdd() {
  formData.value = {
    username: '',
    nickname: '',
    email: '',
    status: 'enabled',
    roles: [],
  } as any;
  modalApi.setData({ values: formData.value, formApi: null }).open();
}

function onEdit(row: SystemUserApi.UserEntity) {
  formData.value = { ...row };
  modalApi.setData({ values: formData.value, formApi: null }).open();
}

async function onDelete(row: SystemUserApi.UserEntity) {
  try {
    await ElMessageBox.confirm(
      $t('page.system.user.action.deleteConfirm'),
      'Warning',
      { type: 'warning' },
    );
    await deleteUserApi(row.id);
    ElMessage.success($t('page.system.user.message.deleteSuccess'));
    await gridApi.reload();
  } catch {}
}
</script>

<template>
  <Page auto-content-height>
    <Grid>
      <template #toolbar-tools>
        <Button type="primary" @click="onAdd">
          {{ $t('page.system.user.action.add') }}
        </Button>
      </template>

      <template #action="{ row }">
        <Space>
          <Button link type="primary" v-access:code="['AC_100120']" @click="onEdit(row)">
            {{ $t('page.system.user.action.edit') }}
          </Button>
          <Button link type="danger" v-access:code="['AC_100130']" @click="onDelete(row)">
            {{ $t('page.system.user.action.delete') }}
          </Button>
        </Space>
      </template>
    </Grid>

    <Modal :title="$t('page.system.user.form.title')" />
  </Page>
</template>
```

### 5. 编辑弹窗 `src/views/system/user/editor.vue`

```vue
<script lang="ts" setup>
import { ref, watch } from 'vue';
import { useVbenForm, type VbenFormProps } from '@vben/common-ui';
import { $t } from '#/locales';
import { SystemUserApi } from '#/api/system/user';

const props = defineProps<{
  values: Partial<SystemUserApi.SaveReq>;
}>();

const formOptions: VbenFormProps = {
  commonConfig: {
    labelWidth: 100,
  },
  schema: [
    {
      component: 'Input',
      fieldName: 'username',
      label: $t('page.system.user.form.username'),
      rules: 'required',
    },
    {
      component: 'Input',
      fieldName: 'nickname',
      label: $t('page.system.user.form.nickname'),
      rules: 'required',
    },
    {
      component: 'Input',
      fieldName: 'email',
      label: $t('page.system.user.form.email'),
      rules: 'required|email',
    },
    {
      component: 'RadioGroup',
      fieldName: 'status',
      label: $t('page.system.user.form.status'),
      defaultValue: 'enabled',
      componentProps: {
        options: [
          { label: $t('page.system.user.form.statusEnabled'), value: 'enabled' },
          { label: $t('page.system.user.form.statusDisabled'), value: 'disabled' },
        ],
      },
    },
    {
      component: 'Select',
      fieldName: 'roles',
      label: $t('page.system.user.form.roles'),
      componentProps: {
        multiple: true,
        options: [
          { label: '超级管理员', value: 'super' },
          { label: '管理员', value: 'admin' },
          { label: '普通用户', value: 'user' },
        ],
      },
    },
  ],
  showDefaultActions: false,
};

const [Form, formApi] = useVbenForm({ ...formOptions });

// 把 formApi 暴露给父级
defineExpose({ formApi });

watch(
  () => props.values,
  (v) => {
    v && formApi.setValues(v);
  },
  { immediate: true },
);
</script>

<template>
  <Form />
</template>
```

### 6. Mock `apps/web-antd/mock/system-user.mock.ts`

```ts
import { defineMock } from 'vite-plugin-mock-dev-server';

const users = [
  { id: '1', username: 'admin', nickname: '超级管理员', email: 'admin@example.com', status: 'enabled', roles: ['super'], createdAt: '2025-01-01 10:00:00' },
  { id: '2', username: 'user1', nickname: '测试用户1', email: 'user1@example.com', status: 'enabled', roles: ['user'], createdAt: '2025-01-02 10:00:00' },
];

export default defineMock([
  {
    url: '/api/system/user/list',
    method: 'GET',
    body: { items: users, total: users.length },
  },
  {
    url: '/api/system/user',
    method: 'POST',
    body: { code: 0, message: 'ok' },
  },
  {
    url: '/api/system/user/:id',
    method: 'PUT',
    body: { code: 0, message: 'ok' },
  },
  {
    url: '/api/system/user/:id',
    method: 'DELETE',
    body: { code: 0, message: 'ok' },
  },
]);
```

---

## 关键技巧

### 表格自适应高度

```vue
<Page auto-content-height>
  <Grid />
</Page>
```

### 表格自定义工具栏

```ts
const gridOptions: VxeGridProps = {
  toolbarConfig: {
    buttons: [
      { code: 'create', name: '新增' },
    ],
    tools: {
      // 右侧
    },
  },
};
```

### 表单初始值

```ts
const [Form] = useVbenForm({
  initialValues: { status: 'enabled' },
});
```

### 表单联动

```ts
const [Form] = useVbenForm({
  schema: [
    {
      component: 'Select',
      fieldName: 'type',
      label: '类型',
      componentProps: {
        options: [{ label: 'A', value: 'a' }, { label: 'B', value: 'b' }],
        onChange: (v) => console.log('change', v),
      },
    },
  ],
});
```

### 详情页（带 Tab）

```vue
<Page>
  <Tabs v-model:active-key="activeKey">
    <Tabs.TabPane key="basic" tab="基础信息">
      <BasicInfo />
    </Tabs.TabPane>
    <Tabs.TabPane key="logs" tab="操作日志">
      <OperationLogs />
    </Tabs.TabPane>
  </Tabs>
</Page>
```
