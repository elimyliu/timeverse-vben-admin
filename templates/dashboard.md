# Dashboard 页面模板

Dashboard 是管理系统的核心入口。按复杂度分为两种常见形态：

- **工作台（Workspace）** — 面向日常操作：待办任务、快捷入口、最近动态
- **分析页（Analytics）** — 面向数据监控：KPI 卡片、趋势图表、排行表格

---

## 1. 路由配置

```ts
// src/router/routes/modules/dashboard.ts
import type { RouteRecordRaw } from 'vue-router';
import { $t } from '#/locales';

const routes: RouteRecordRaw[] = [
  {
    name: 'DashboardWorkspace',
    path: '/dashboard/workspace',
    component: () => import('#/views/dashboard/workspace/index.vue'),
    meta: {
      title: $t('page.dashboard.workspace.title'),
      icon: 'mdi:view-dashboard',
      order: 1,
      keepAlive: true,
    },
  },
  {
    name: 'DashboardAnalytics',
    path: '/dashboard/analytics',
    component: () => import('#/views/dashboard/analytics/index.vue'),
    meta: {
      title: $t('page.dashboard.analytics.title'),
      icon: 'mdi:chart-box-outline',
      order: 2,
      keepAlive: true,
    },
  },
];

export default routes;
```

---

## 2. 国际化

```ts
// src/locales/langs/zh-CN.ts
page: {
  dashboard: {
    workspace: {
      title: '工作台',
      welcome: '欢迎回来，{name}',
      todayStats: '今日概览',
      quickActions: '快捷操作',
      recentActivities: '最近动态',
      pendingTasks: '待办任务',
    },
    analytics: {
      title: '分析页',
      totalSales: '总销售额',
      todayOrders: '今日订单',
      activeUsers: '活跃用户',
      conversionRate: '转化率',
      salesTrend: '销售趋势',
      orderStats: '订单统计',
      customerSource: '客户来源',
      topProducts: '热销商品排行',
    },
  },
}
```

---

## 3. 工作台页面

适合作为系统首页，展示待办事项、快捷入口和最近动态。

```vue
<!-- src/views/dashboard/workspace/index.vue -->
<script lang="ts" setup>
import { ref, onMounted } from 'vue';
import { useUserStore } from '#/store';
import VChart from '#/components/Charts/VChart.vue'; // 来自 data-visualization.md

// ── 用户信息 ──
const userStore = useUserStore();
const username = userStore.userInfo?.realName ?? '用户';

// ── 今日概览 ──
interface StatItem {
  label: string;
  value: string;
  trend: 'up' | 'down';
  change: string;
  icon: string;
  color: string;
}
const stats = ref<StatItem[]>([
  { label: '访问量', value: '8,432', trend: 'up', change: '12.5%', icon: 'mdi:eye', color: '#1890ff' },
  { label: '订单数', value: '1,280', trend: 'up', change: '8.3%', icon: 'mdi:clipboard-list', color: '#52c41a' },
  { label: '消息', value: '36', trend: 'down', change: '5.2%', icon: 'mdi:message', color: '#faad14' },
  { label: '待办', value: '12', trend: 'down', change: '0%', icon: 'mdi:checkbox-marked-circle', color: '#ff4d4f' },
]);

// ── 快捷操作 ──
interface QuickAction {
  label: string;
  icon: string;
  color: string;
  route: string;
  desc: string;
}
const quickActions = ref<QuickAction[]>([
  { label: '新增用户', icon: 'mdi:account-plus', color: '#1890ff', route: '/system/user', desc: '创建系统用户账号' },
  { label: '创建订单', icon: 'mdi:cart-plus', color: '#52c41a', route: '/order/list', desc: '手动录入新订单' },
  { label: '发布公告', icon: 'mdi:bullhorn', color: '#faad14', route: '/notice/create', desc: '向全员发送通知' },
  { label: '数据报表', icon: 'mdi:file-chart', color: '#722ed1', route: '/report/sales', desc: '查看经营数据' },
]);

// ── 待办任务 ──
interface TodoItem {
  id: string;
  content: string;
  priority: 'high' | 'medium' | 'low';
  deadline: string;
  done: boolean;
}
const todos = ref<TodoItem[]>([
  { id: '1', content: '审核新注册用户', priority: 'high', deadline: '今天 18:00', done: false },
  { id: '2', content: '确认 3 月份财务报表', priority: 'high', deadline: '明天 12:00', done: false },
  { id: '3', content: '更新商品库存数据', priority: 'medium', deadline: '本周五', done: false },
  { id: '4', content: '检查服务器运行状态', priority: 'low', deadline: '本周日', done: true },
]);

function toggleTodo(id: string) {
  const item = todos.value.find((t) => t.id === id);
  if (item) item.done = !item.done;
}

// ── 最近动态 ──
interface Activity {
  user: string;
  action: string;
  target: string;
  time: string;
  avatar?: string;
}
const activities = ref<Activity[]>([
  { user: '张三', action: '创建了', target: '采购订单 #2024-0312', time: '5 分钟前' },
  { user: '李四', action: '审批通过了', target: '报销申请 #2024-0089', time: '15 分钟前' },
  { user: '王五', action: '更新了', target: '商品「智能手表」库存', time: '1 小时前' },
  { user: '系统', action: '完成了', target: '每日数据备份', time: '2 小时前' },
  { user: '赵六', action: '提交了', target: '周报 (第 10 周)', time: '3 小时前' },
]);

// ── 迷你折线图（周趋势） ──
const weekTrend = {
  xAxis: { type: 'category', show: false, data: ['一', '二', '三', '四', '五', '六', '日'] },
  yAxis: { type: 'value', show: false },
  grid: { left: 0, right: 0, top: 5, bottom: 0 },
  series: [{ type: 'line', data: [820, 932, 901, 1234, 1290, 1330, 1120], smooth: true, lineStyle: { width: 2 }, areaStyle: { opacity: 0.1 } }],
};
</script>

<template>
  <div class="p-6 space-y-6">
    <!-- 欢迎语 -->
    <div class="text-xl font-semibold">
      欢迎回来，{{ username }}
      <span class="text-gray-400 text-sm font-normal ml-2">{{ new Date().toLocaleDateString('zh-CN', { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' }) }}</span>
    </div>

    <!-- 今日概览卡片 -->
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
      <div v-for="stat in stats" :key="stat.label"
        class="bg-white rounded-lg p-4 shadow-sm border border-gray-100 hover:shadow-md transition-shadow"
      >
        <div class="flex items-start justify-between">
          <div>
            <div class="text-gray-500 text-sm">{{ stat.label }}</div>
            <div class="text-2xl font-bold mt-1">{{ stat.value }}</div>
            <div class="flex items-center mt-2 text-xs">
              <span :class="stat.trend === 'up' ? 'text-green-500' : 'text-red-500'">
                {{ stat.trend === 'up' ? '↑' : '↓' }} {{ stat.change }}
              </span>
              <span class="text-gray-400 ml-1">较昨日</span>
            </div>
          </div>
          <div class="w-12 h-12 rounded-lg flex items-center justify-center text-white text-xl"
            :style="{ backgroundColor: stat.color }"
          >
            <span class="iconify" :data-icon="stat.icon" />
          </div>
        </div>
      </div>
    </div>

    <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
      <!-- 快速入口 -->
      <div class="bg-white rounded-lg p-4 shadow-sm border border-gray-100">
        <div class="font-semibold mb-3">快捷操作</div>
        <div class="grid grid-cols-2 gap-3">
          <div v-for="action in quickActions" :key="action.label"
            class="border border-gray-100 rounded-lg p-3 cursor-pointer hover:border-blue-200 hover:bg-blue-50 transition-colors"
            @click="$router.push(action.route)"
          >
            <div class="w-8 h-8 rounded flex items-center justify-center text-white mb-2"
              :style="{ backgroundColor: action.color }"
            >
              <span class="iconify text-sm" :data-icon="action.icon" />
            </div>
            <div class="text-sm font-medium">{{ action.label }}</div>
            <div class="text-xs text-gray-400">{{ action.desc }}</div>
          </div>
        </div>
      </div>

      <!-- 最近动态 -->
      <div class="bg-white rounded-lg p-4 shadow-sm border border-gray-100">
        <div class="font-semibold mb-3">最近动态</div>
        <div class="space-y-3">
          <div v-for="(activity, idx) in activities" :key="idx" class="flex items-start gap-3">
            <div class="w-8 h-8 rounded-full bg-gray-200 flex items-center justify-center text-xs font-medium text-gray-600 flex-shrink-0">
              {{ activity.user.charAt(0) }}
            </div>
            <div class="flex-1 min-w-0">
              <div class="text-sm">
                <span class="font-medium">{{ activity.user }}</span>
                {{ activity.action }}<span class="text-blue-600">「{{ activity.target }}」</span>
              </div>
              <div class="text-xs text-gray-400 mt-0.5">{{ activity.time }}</div>
            </div>
          </div>
        </div>
      </div>

      <!-- 待办任务 -->
      <div class="bg-white rounded-lg p-4 shadow-sm border border-gray-100">
        <div class="font-semibold mb-3">待办任务</div>
        <div class="space-y-2">
          <div v-for="todo in todos" :key="todo.id"
            class="flex items-start gap-2 cursor-pointer"
            @click="toggleTodo(todo.id)"
          >
            <div :class="todo.done ? 'bg-blue-500 border-blue-500' : 'border-gray-300'"
              class="w-4 h-4 rounded border mt-1 flex-shrink-0 flex items-center justify-center transition-colors"
            >
              <span v-if="todo.done" class="text-white text-xs">✓</span>
            </div>
            <div class="flex-1">
              <div :class="todo.done ? 'line-through text-gray-400' : ''" class="text-sm">{{ todo.content }}</div>
              <div class="flex items-center gap-2 mt-1">
                <span :class="{
                  'text-red-500': todo.priority === 'high',
                  'text-yellow-500': todo.priority === 'medium',
                  'text-gray-400': todo.priority === 'low',
                }" class="text-xs">
                  {{ { high: '高', medium: '中', low: '低' }[todo.priority] }}
                </span>
                <span class="text-xs text-gray-400">{{ todo.deadline }}</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
```

---

## 4. 分析页

展示经营数据，适合作为管理者的数据看板。

```vue
<!-- src/views/dashboard/analytics/index.vue -->
<script lang="ts" setup>
import { ref, onMounted } from 'vue';
import VChart from '#/components/Charts/VChart.vue';

// ── KPI 卡片数据 ──
const kpis = ref([
  { label: '总销售额', value: '¥ 126,560', unit: '', change: '+12.5%', trend: 'up', color: '#1890ff' },
  { label: '今日订单', value: '1,280', unit: '单', change: '-3.2%', trend: 'down', color: '#52c41a' },
  { label: '活跃用户', value: '8,432', unit: '人', change: '+8.1%', trend: 'up', color: '#faad14' },
  { label: '转化率', value: '3.24', unit: '%', change: '+0.6%', trend: 'up', color: '#722ed1' },
]);

// ── 销售趋势（ECharts 折线图） ──
const salesTrend = {
  tooltip: { trigger: 'axis' },
  legend: { data: ['本月', '上月'] },
  xAxis: { type: 'category', data: ['1月', '2月', '3月', '4月', '5月', '6月'] },
  yAxis: { type: 'value' },
  grid: { left: 50, right: 20, bottom: 30 },
  series: [
    {
      name: '本月', type: 'line', smooth: true,
      data: [820, 932, 901, 1234, 1290, 1330],
      areaStyle: { opacity: 0.15 },
    },
    {
      name: '上月', type: 'line', smooth: true,
      data: [720, 812, 850, 980, 1050, 1100],
      lineStyle: { type: 'dashed' },
    },
  ],
};

// ── 订单统计（柱状图） ──
const orderStats = {
  tooltip: { trigger: 'axis' },
  xAxis: { type: 'category', data: ['待付款', '已付款', '已发货', '已完成', '已退款'] },
  yAxis: { type: 'value' },
  grid: { left: 40, right: 20, bottom: 30 },
  series: [{
    type: 'bar',
    data: [120, 200, 150, 80, 70],
    itemStyle: {
      borderRadius: [4, 4, 0, 0],
      color: { type: 'linear', x: 0, y: 0, x2: 0, y2: 1, colorStops: [
        { offset: 0, color: '#1890ff' }, { offset: 1, color: '#69c0ff' },
      ]},
    },
  }],
};

// ── 客户来源（饼图） ──
const customerSource = {
  tooltip: { trigger: 'item', formatter: '{b}: {c} ({d}%)' },
  legend: { bottom: '0%' },
  series: [{
    type: 'pie',
    radius: ['40%', '70%'],
    data: [
      { value: 1048, name: '搜索引擎', itemStyle: { color: '#1890ff' } },
      { value: 735, name: '社交媒体', itemStyle: { color: '#52c41a' } },
      { value: 580, name: '直接访问', itemStyle: { color: '#faad14' } },
      { value: 484, name: '广告投放', itemStyle: { color: '#ff4d4f' } },
      { value: 300, name: '其他', itemStyle: { color: '#722ed1' } },
    ],
  }],
};

// ── 热销商品排行 ──
const topProducts = ref([
  { rank: 1, name: '智能手表 Pro', sales: 1256, amount: '¥ 376,800', growth: '+15.2%' },
  { rank: 2, name: '无线蓝牙耳机', sales: 982, amount: '¥ 196,400', growth: '+8.7%' },
  { rank: 3, name: '便携充电宝', sales: 876, amount: '¥ 87,600', growth: '-2.1%' },
  { rank: 4, name: '手机壳', sales: 654, amount: '¥ 32,700', growth: '+22.3%' },
  { rank: 5, name: '数据线', sales: 543, amount: '¥ 16,290', growth: '+5.4%' },
]);
</script>

<template>
  <div class="p-6 space-y-6">
    <!-- KPI 卡片 -->
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
      <div v-for="kpi in kpis" :key="kpi.label"
        class="bg-white rounded-lg p-4 shadow-sm border border-gray-100"
      >
        <div class="text-gray-500 text-sm">{{ kpi.label }}</div>
        <div class="flex items-baseline mt-1">
          <div class="text-2xl font-bold">{{ kpi.value }}</div>
          <span class="text-gray-400 text-sm ml-1">{{ kpi.unit }}</span>
        </div>
        <div class="flex items-center mt-2 text-xs">
          <span :class="kpi.trend === 'up' ? 'text-green-500' : 'text-red-500'">
            {{ kpi.trend === 'up' ? '↑' : '↓' }} {{ kpi.change }}
          </span>
          <span class="text-gray-400 ml-1">较上月</span>
        </div>
      </div>
    </div>

    <!-- 销售趋势全宽 -->
    <div class="bg-white rounded-lg p-4 shadow-sm border border-gray-100">
      <div class="font-semibold mb-3">销售趋势</div>
      <VChart :options="salesTrend" height="300px" />
    </div>

    <!-- 图表行 -->
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
      <div class="bg-white rounded-lg p-4 shadow-sm border border-gray-100">
        <div class="font-semibold mb-3">订单统计</div>
        <VChart :options="orderStats" height="280px" />
      </div>
      <div class="bg-white rounded-lg p-4 shadow-sm border border-gray-100">
        <div class="font-semibold mb-3">客户来源</div>
        <VChart :options="customerSource" height="280px" />
      </div>
    </div>

    <!-- 排行表格 -->
    <div class="bg-white rounded-lg shadow-sm border border-gray-100">
      <div class="p-4 font-semibold border-b border-gray-100">热销商品排行</div>
      <table class="w-full">
        <thead>
          <tr class="text-left text-gray-500 text-sm border-b border-gray-50">
            <th class="p-3 pl-4 w-12">排名</th>
            <th class="p-3">商品名称</th>
            <th class="p-3 text-right">销量</th>
            <th class="p-3 text-right">销售额</th>
            <th class="p-3 text-right pr-4">增长率</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(item, idx) in topProducts" :key="item.rank"
            class="text-sm hover:bg-gray-50 transition-colors"
            :class="{ 'bg-blue-50': idx === 0 }"
          >
            <td class="p-3 pl-4">
              <span :class="idx < 3 ? 'text-red-500 font-bold' : 'text-gray-400'">{{ item.rank }}</span>
            </td>
            <td class="p-3 font-medium">{{ item.name }}</td>
            <td class="p-3 text-right">{{ item.sales.toLocaleString() }}</td>
            <td class="p-3 text-right">{{ item.amount }}</td>
            <td class="p-3 text-right pr-4">
              <span :class="item.growth.startsWith('+') ? 'text-green-500' : 'text-red-500'">
                {{ item.growth }}
              </span>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>
```

---

## 5. 行业 Dashboard 卡片参考

各行业模板的 Dashboard 页面推荐展示哪些数据卡片，详见下表：

| 系统类型 | KPI 卡片 | 主图表 | 辅助图表 | 列表区 |
|---|---|---|---|---|
| 电商后台 | 订单数、销售额、访客数、转化率 | 销售趋势（折线图） | 订单状态分布（饼图） | 热销商品排行 |
| ERP | 工单数、库存周转、采购金额、产出量 | 生产趋势（折线图） | 物料消耗（柱状图） | 待处理工单 |
| CRM | 新增客户、商机数、成交额、续费率 | 销售漏斗（漏斗图） | 客户来源（饼图） | 近期商机列表 |
| CMS | 发布量、访客数、评论数、订阅数 | 内容浏览量趋势（折线图） | 内容分类分布（饼图） | 最新评论 |
| SaaS | 租户数、活跃应用、收入、续费率 | 收入趋势（折线图） | 套餐分布（饼图） | 待审核租户 |
| O2O | 预约数、核销率、营收、好评率 | 预约趋势（折线图） | 服务分类占比（饼图） | 待处理预约 |
| 外卖/餐饮 | 订单数、客单价、翻台率、出餐时长 | 时段订单分布（柱状图） | 菜品销量排行（条形图） | 催单列表 |
| PMS | 入住率、ADR、RevPAR、预订量 | 入住率趋势（折线图） | 渠道来源（柱状图） | 今日预抵/预离 |
| 支付系统 | 交易量、交易额、成功率、退款率 | 交易趋势（折线图） | 渠道占比（饼图） | 异常交易 |
| 金融后台 | 用户数、在投资产、借款余额、逾期率 | 资产趋势（折线图） | 产品类型分布（饼图） | 待审核借款 |
| FMS | 收入、支出、净利润、预算执行率 | 收支趋势（折线图） | 费用分类占比（饼图） | 待审核凭证 |
| HIS | 门急诊量、住院率、药品消耗、收入 | 门急诊趋势（折线图） | 科室收入分布（柱状图） | 待处理处方 |
| 教育系统 | 在校生、教师数、课时数、升学率 | 招生趋势（折线图） | 年级人数分布（柱状图） | 待审批请假 |
| 物业系统 | 入住率、收费率、报修数、投诉数 | 收费趋势（折线图） | 报修分类（饼图） | 未处理报修 |
| TMS | 运单数、签收率、准点率、运输成本 | 运单趋势（折线图） | 运输方式占比（饼图） | 异常运单 |
| MES | 工单完成率、良品率、OEE、设备开机率 | 生产趋势（折线图） | 不良类型分布（饼图） | 设备报警列表 |
| OA | 待审批数、考勤异常、公告数、会议数 | - | - | 待办审批列表 |
| API 开放平台 | 调用量、应用数、成功率、平均延迟 | 调用趋势（折线图） | 应用调用排行（柱状图） | 告警列表 |
| 通用后台 | 访问量、用户数、订单数、待办数 | 周趋势（迷你折线图） | - | 待办任务列表 |

---

## 6. 常见问题

### 图表与主题色联动

ECharts 默认不跟随 Vben 主题色切换。如需联动，监听主题变化后重新 `setOption`：

```ts
import { usePreferences } from '@vben/preferences';

const { preferences } = usePreferences();

watch(() => preferences.theme, (newTheme) => {
  const isDark = newTheme === 'dark';
  chart.setOption({
    backgroundColor: isDark ? '#1a1a2e' : '#ffffff',
    // ... 跟随主题的样式变化
  });
});
```

### 大屏适配

Dashboard 做可视化大屏展示时：

```css
/* 使用 vw/vh 单位 */
.kpi-card {
  font-size: 2.5vw;
}
```

---

## 模板文件结构

创建 Dashboard 后，项目的 `src/views/dashboard/` 目录结构：

```
src/views/dashboard/
├── workspace/
│   └── index.vue            ← 工作台页面
├── analytics/
│   └── index.vue            ← 分析页
└── components/              ← Dashboard 级别的复用组件
    ├── KpiCard.vue
    ├── QuickActions.vue
    ├── RecentActivity.vue
    └── TodoList.vue
```

如需将图表组件抽离为全局共享，建议放在 `src/components/Charts/` 下。
