# 高级 CRUD 场景模板

> 基于 [crud-page.md](crud-page.md) 的基础模式，补充企业后台常见的高级交互场景。

---

## 1. 树形表格（部门/分类管理）

适用于部门管理、分类管理、菜单管理等树形层级结构。

### 路由

```ts
// src/router/routes/modules/system.ts
import type { RouteRecordRaw } from 'vue-router';
import { $t } from '#/locales';

const routes: RouteRecordRaw[] = [
  {
    name: 'SystemDept',
    path: '/system/dept',
    component: () => import('#/views/system/dept/index.vue'),
    meta: {
      title: $t('page.system.dept.title'),
      icon: 'mdi:office-building',
      authority: ['super_admin', 'system_manager'],
      keepAlive: true,
    },
  },
];

export default routes;
```

### API

```ts
// src/api/system/dept.ts
import { requestClient } from '#/api/request';

export namespace SystemDeptApi {
  export interface DeptEntity {
    id: string;
    parentId: string | null;
    name: string;
    order: number;
    status: 'enabled' | 'disabled';
    leader?: string;
    phone?: string;
    email?: string;
    children?: DeptEntity[];   // 树形子节点
    hasChildren?: boolean;      // 是否有子节点（懒加载标识）
  }

  export interface SaveReq {
    id?: string;
    parentId: string | null;
    name: string;
    order: number;
    status: 'enabled' | 'disabled';
    leader?: string;
    phone?: string;
    email?: string;
  }
}

/** 获取部门树（一次性加载全部） */
export async function getDeptTreeApi() {
  return requestClient.get<SystemDeptApi.DeptEntity[]>('/system/dept/tree');
}

/** 获取子节点（懒加载） */
export async function getDeptChildrenApi(parentId: string) {
  return requestClient.get<SystemDeptApi.DeptEntity[]>('/system/dept/children', {
    params: { parentId },
  });
}

export async function saveDeptApi(data: SystemDeptApi.SaveReq) {
  return data.id
    ? requestClient.put(`/system/dept/${data.id}`, data)
    : requestClient.post('/system/dept', data);
}

export async function deleteDeptApi(id: string) {
  return requestClient.delete(`/system/dept/${id}`);
}
```

### 国际化

```ts
// src/locales/langs/zh-CN.ts
page: {
  system: {
    dept: {
      title: '部门管理',
      name: '部门名称',
      leader: '负责人',
      phone: '联系电话',
      email: '邮箱',
      order: '排序',
      status: '状态',
      action: '操作',
      addChild: '新增子部门',
      addRoot: '新增顶级部门',
      deleteConfirm: '确认删除该部门？\n子部门将一并删除。',
    },
  },
}
```

### 视图

```vue
<!-- src/views/system/dept/index.vue -->
<script lang="ts" setup>
import { ref, onMounted } from 'vue';
import { useVbenVxeGrid, type VxeGridProps } from '#/adapter/vxe-table';
import { useVbenModal, type VbenFormProps } from '@vben/common-ui';
import {
  getDeptTreeApi,
  getDeptChildrenApi,
  saveDeptApi,
  deleteDeptApi,
  SystemDeptApi,
} from '#/api/system/dept';
import { $t } from '#/locales';
import { message, Modal } from 'ant-design-vue';

// ── 树形表格配置 ──────────────────────────────────

const gridOptions: VxeGridProps<SystemDeptApi.DeptEntity> = {
  columns: [
    {
      type: 'checkbox',
      width: 50,
      align: 'center',
    },
    { title: $t('page.system.dept.name'), field: 'name', treeNode: true, minWidth: 200 },
    { title: $t('page.system.dept.leader'), field: 'leader', width: 120 },
    { title: $t('page.system.dept.phone'), field: 'phone', width: 140 },
    { title: $t('page.system.dept.email'), field: 'email', minWidth: 180 },
    { title: $t('page.system.dept.order'), field: 'order', width: 80 },
    {
      title: '操作',
      field: 'action',
      width: 200,
      slots: { default: 'action' },
    },
  ],
  data: [],    // 树形数据通过 async 加载
  treeConfig: {
    // 树形配置 ↓
    transform: true,               // 将 children 转换为树形结构
    rowField: 'id',                // 行主键
    parentField: 'parentId',       // 父级字段
    hasChildField: 'hasChildren',  // 是否可展开字段
    // 懒加载 ↓
    lazy: true,
    loadMethod: async ({ row }) => {
      const children = await getDeptChildrenApi(row.id);
      return { children };
    },
  },
  sortConfig: {
    remote: true,                  // 远程排序
  },
  toolbarConfig: {
    slots: { buttons: 'toolbar_buttons' },
  },
  height: 'auto',
};

const [Grid, gridApi] = useVbenVxeGrid({ gridOptions });

// ── 加载数据 ───────────────────────────────────────

async function loadData() {
  const tree = await getDeptTreeApi();
  gridApi.setGridOptions({ data: tree });
}

onMounted(loadData);

// ── 编辑弹窗 ───────────────────────────────────────

const formData = ref<SystemDeptApi.SaveReq>({
  parentId: null,
  name: '',
  order: 0,
  status: 'enabled',
  leader: '',
  phone: '',
  email: '',
});

const formOptions: VbenFormProps = {
  schema: [
    { field: 'name', label: '部门名称', component: 'Input', rules: 'required' },
    { field: 'order', label: '排序', component: 'InputNumber', defaultValue: 0 },
    { field: 'leader', label: '负责人', component: 'Input' },
    { field: 'phone', label: '联系电话', component: 'Input' },
    { field: 'email', label: '邮箱', component: 'Input' },
    {
      field: 'status',
      label: '状态',
      component: 'RadioGroup',
      defaultValue: 'enabled',
      componentProps: {
        options: [
          { label: '启用', value: 'enabled' },
          { label: '禁用', value: 'disabled' },
        ],
      },
    },
  ],
  showDefaultActions: false,
};

const [ModalComponent, modalApi] = useVbenModal({
  title: '部门',
  onConfirm: async () => {
    const valid = await modalApi.getData()?.formApi?.validate();
    if (!valid) return false;
    try {
      await saveDeptApi(modalApi.getData().values);
      message.success('保存成功');
      modalApi.close();
      await loadData();
    } catch {
      return false;
    }
  },
});

function onAddRoot() {
  formData.value = {
    parentId: null, name: '', order: 0, status: 'enabled',
  };
  modalApi.setData({ values: formData.value }).open();
}

function onAddChild(row: SystemDeptApi.DeptEntity) {
  formData.value = {
    parentId: row.id, name: '', order: 0, status: 'enabled',
  };
  modalApi.setData({ values: formData.value }).open();
}

function onEdit(row: SystemDeptApi.DeptEntity) {
  formData.value = { ...row };
  modalApi.setData({ values: formData.value }).open();
}

async function onDelete(row: SystemDeptApi.DeptEntity) {
  try {
    await Modal.confirm({
      title: '确认删除',
      content: $t('page.system.dept.deleteConfirm'),
      type: 'warning',
    });
    await deleteDeptApi(row.id);
    message.success('删除成功');
    await loadData();
  } catch {}
}
</script>

<template>
  <Grid>
    <!-- 工具栏按钮 -->
    <template #toolbar_buttons>
      <a-button type="primary" @click="onAddRoot">
        + 新增顶级部门
      </a-button>
    </template>

    <!-- 操作列插槽 -->
    <template #action="{ row }">
      <a-button link type="primary" @click="onAddChild(row)">新增子级</a-button>
      <a-button link type="primary" @click="onEdit(row)">编辑</a-button>
      <a-button link type="danger" @click="onDelete(row)">删除</a-button>
    </template>
  </Grid>

  <ModalComponent>
    <template #default>
      <VbenForm :schema="formOptions" />
    </template>
  </ModalComponent>
</template>
```

### 关键点

- `treeConfig.transform: true` — 将平铺的 `children` 数组渲染为树
- `treeConfig.lazy` + `loadMethod` — 点击展开时懒加载子节点
- `addChild` / `addRoot` — 分别在顶级和指定节点下新增
- 删除时需要注意级联删除子节点

---

## 2. 批量操作（批量删除 / 批量状态更新）

在列表页增加多选、全选和批量操作按钮。

### 视图（部分代码）

在基础 CRUD 表格基础上增加以下配置和函数：

```ts
// 开启行复选框
const gridOptions: VxeGridProps = {
  columns: [
    { type: 'checkbox', width: 50, align: 'center' },      // ← 多选框列
    // ... 其他列
  ],
  // 工具栏：批量操作按钮
  toolbarConfig: {
    slots: { buttons: 'toolbar_buttons' },
  },
  // 行选中配置
  checkboxConfig: {
    labelField: 'id',
    reserve: true,                // 翻页保留选中
    highlight: true,
  },
};

// ── 批量操作 ──

const [Grid, gridApi] = useVbenVxeGrid({ gridOptions });

/** 获取选中行的 ID 数组 */
function getSelectedIds(): string[] {
  // VxeTable 获取选中行（支持跨页）
  const records = gridApi.grid?.getCheckboxRecords() ?? [];
  return records.map((r: any) => r.id);
}

/** 批量删除 */
async function onBatchDelete() {
  const ids = getSelectedIds();
  if (ids.length === 0) {
    message.warning('请先选择需要删除的项');
    return;
  }
  try {
    await Modal.confirm({
      title: '确认批量删除',
      content: `确认删除选中的 ${ids.length} 条记录？此操作不可撤销。`,
      type: 'warning',
    });
    await requestClient.post('/system/user/batch-delete', { ids });
    message.success(`成功删除 ${ids.length} 条记录`);
    await gridApi.query();
  } catch {}
}

/** 批量更新状态 */
async function onBatchStatus(status: 'enabled' | 'disabled') {
  const ids = getSelectedIds();
  if (ids.length === 0) {
    message.warning('请先选择需要操作的项');
    return;
  }
  await requestClient.put('/system/user/batch-status', { ids, status });
  message.success(`状态已更新`);
  await gridApi.query();
}

// ── 按钮 API ──

export async function batchDeleteApi(ids: string[]) {
  return requestClient.post('/system/user/batch-delete', { ids });
}

export async function batchUpdateStatusApi(ids: string[], status: string) {
  return requestClient.put('/system/user/batch-status', { ids, status });
}
```

```vue
<!-- 工具栏插槽 -->
<template #toolbar_buttons>
  <a-popconfirm title="确认批量删除？" @confirm="onBatchDelete">
    <a-button danger>批量删除</a-button>
  </a-popconfirm>
  <a-button @click="onBatchStatus('enabled')">批量启用</a-button>
  <a-button @click="onBatchStatus('disabled')">批量禁用</a-button>
  <a-divider type="vertical" />
  已选择 {{ gridApi.grid?.getCheckboxRecords()?.length ?? 0 }} 项
</template>
```

### 关键点

- `checkboxConfig.reserve: true` — 跨页保留已选中的行
- 批量操作接口建议加事务保证（全部成功或全部回滚）
- 前端做二次确认，防止误操作

---

## 3. 导入 / 导出

使用 `xlsx` 库实现 Excel 导入导出。

### 安装

```bash
pnpm add xlsx
```

### 工具函数

```ts
// src/utils/excel.ts
import * as XLSX from 'xlsx';

/** 导出为 Excel */
export function exportToExcel<T extends Record<string, any>>(
  data: T[],
  headers: Record<string, string>,    // { field: '列名' }
  filename: string,
) {
  const worksheet = XLSX.utils.json_to_sheet(
    data.map((row) => {
      const mapped: Record<string, any> = {};
      for (const [key, label] of Object.entries(headers)) {
        mapped[label] = row[key] ?? '';
      }
      return mapped;
    }),
  );

  // 自动列宽
  const colWidths = Object.values(headers).map((label) => ({
    wch: Math.max(label.length * 2, 12),
  }));
  worksheet['!cols'] = colWidths;

  const workbook = XLSX.utils.book_new();
  XLSX.utils.book_append_sheet(workbook, worksheet, 'Sheet1');
  XLSX.writeFile(workbook, `${filename}.xlsx`);
}

/** 从 Excel 导入，返回 JSON 数组 */
export function importFromExcel<T = Record<string, any>>(
  file: File,
  mapping: Record<string, string>,   // { '列名': 'field' }
): Promise<T[]> {
  return new Promise((resolve, reject) => {
    const reader = new FileReader();
    reader.onload = (e) => {
      try {
        const data = new Uint8Array(e.target!.result as ArrayBuffer);
        const workbook = XLSX.read(data, { type: 'array' });
        const sheet = workbook.Sheets[workbook.SheetNames[0]];
        const json = XLSX.utils.sheet_to_json<Record<string, any>>(sheet);

        const result = json.map((row) => {
          const mapped: Record<string, any> = {};
          for (const [colLabel, field] of Object.entries(mapping)) {
            mapped[field] = row[colLabel] ?? '';
          }
          return mapped as T;
        });
        resolve(result);
      } catch (err) {
        reject(new Error('文件解析失败'));
      }
    };
    reader.readAsArrayBuffer(file);
  });
}
```

### API

```ts
// src/api/system/user.ts（追加）
export async function exportUserApi(params: SystemUserApi.PageQuery) {
  return requestClient.get('/system/user/export', {
    params,
    responseType: 'blob',
  });
}

export async function importUserApi(file: File) {
  const formData = new FormData();
  formData.append('file', file);
  return requestClient.post('/system/user/import', formData, {
    headers: { 'Content-Type': 'multipart/form-data' },
  });
}

export async function downloadTemplateApi() {
  return requestClient.get('/system/user/import-template', {
    responseType: 'blob',
  });
}
```

### 视图（导入导出按钮）

```vue
<script setup>
import { exportToExcel, importFromExcel } from '#/utils/excel';
import { getUserListApi, importUserApi, downloadTemplateApi } from '#/api/system/user';

// ── 导出当前页 ──

async function onExport() {
  try {
    const res = await getUserListApi({ page: 1, pageSize: 9999 });
    exportToExcel(
      res.items,
      {
        username: '用户名',
        nickname: '昵称',
        email: '邮箱',
        status: '状态',
        createdAt: '创建时间',
      },
      `用户数据_${new Date().toISOString().slice(0, 10)}`,
    );
    message.success('导出成功');
  } catch {}
}

// ── 导入 ──

const fileInput = ref<HTMLInputElement>();

async function onImport() {
  const file = fileInput.value?.files?.[0];
  if (!file) return;

  try {
    const mapping = {
      '用户名': 'username',
      '昵称': 'nickname',
      '邮箱': 'email',
    };
    const records = await importFromExcel<any>(file, mapping);
    // 分批次提交（每批 100 条）
    const batchSize = 100;
    for (let i = 0; i < records.length; i += batchSize) {
      const batch = records.slice(i, i + batchSize);
      for (const record of batch) {
        await importUserApi(record);
      }
    }
    message.success(`成功导入 ${records.length} 条数据`);
    await gridApi.reload();
  } catch {
    message.error('导入失败，请检查文件格式');
  }
}
</script>

<template>
  <!-- 工具栏 -->
  <template #toolbar_buttons>
    <a-button @click="onExport">导出 Excel</a-button>
    <a-button @click="downloadTemplate()">下载导入模板</a-button>
    <a-upload
      :before-upload="(file: File) => { handleImport(file); return false; }"
      :show-upload-list="false"
      accept=".xlsx,.xls,.csv"
    >
      <a-button>导入 Excel</a-button>
    </a-upload>
  </template>
</template>
```

### 关键点

- 导出时设置 `responseType: 'blob'` 以处理二进制流
- 导入建议分批次提交，单批 100-200 条
- 下载模板提供标准列头，用户按模板填写

---

## 4. 行拖拽排序

适用于配置项、方案排序等需要手动调整顺序的场景。

### 配置

```ts
const gridOptions: VxeGridProps = {
  columns: [
    { type: 'seq', title: '序号', width: 60 },    // 自动编号
    // ... 其他列
    { title: '拖拽', field: 'drag', width: 60, slots: { default: 'drag' } },
  ],
  // 拖拽排序配置 ↓
  sortConfig: {
    remote: true,
  },
  dragConfig: {
    target: 'row',                   // 行拖拽
    //
    //
  },
};

// ── 拖拽事件 ──

async function onDragChange({ newList }: { newList: any[] }) {
  // 计算新的排序值
  const orders = newList.map((item, index) => ({
    id: item.id,
    order: (index + 1) * 10,         // 步长 10，方便插入
  }));
  await requestClient.put('/system/dept/sort', { orders });
  message.success('排序已保存');
}
```

### 关键点

- 排序值建议使用步长（10、20、30...），方便在中间插入新数据
- 拖拽完成后立即保存排序结果
- 配合 `Pagination` 时注意只在当前页排序

---

## 5. 其他常见场景速查

| 场景 | 实现方式 | 参考 |
|---|---|---|
| **级联选择**（省市区） | `Cascader` 组件 + 异步加载 | Ant Design Vue Cascader |
| **图片上传**（单张/多张） | `a-upload` + `listType="picture-card"` | Ant Design Vue Upload |
| **富文本编辑** | `@vueup/vue-quill` 或 `tinymce` | 需额外安装 |
| **详情抽屉** | `useVbenDrawer` + `VbenDescriptions` | Vben common-ui |
| **批量导入预览** | 解析 Excel 后弹窗展示预览表格，确认后提交 | 结合 import + drawer |
| **审核流程弹窗** | 弹窗显示审批意见输入框 + 通过/驳回按钮 | Modal + TextArea |
| **二次确认后执行** | `Modal.confirm` + `onOk` | Ant Design Vue Modal |

---

## 模板组合建议

```
templates/
├── crud-page.md          ← 基础 CRUD（用户管理）[已存在]
├── crud-advanced.md      ← 本文件
│
实际项目使用示例：
├── src/views/system/dept/index.vue    ← 树形表格（参考场景 1）
├── src/views/system/user/index.vue    ← 基础 CRUD + 批量操作（场景 2）
├── src/views/system/user/index.vue    ← 基础 CRUD + 导入导出（场景 3）
└── src/views/system/menu/index.vue    ← 树形 + 拖拽排序（场景 1 + 4）
```
