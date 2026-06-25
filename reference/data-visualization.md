# 数据可视化

Vben Admin 5.x 默认不内置图表库，推荐的集成方案是 **ECharts**（最成熟、Vben 社区最常用）。

---

## 1. 安装 ECharts

```bash
pnpm add echarts vue-echarts
```

- `echarts` — 核心库
- `vue-echarts` — Vue 3 的 ECharts 封装组件（可选，也可自己封装）

> 如果只需要极简使用，也可以只装 `echarts` 自己封装组件。

---

## 2. 封装图表组件

```vue
<!-- src/components/Charts/VChart.vue -->
<script setup lang="ts">
import { ref, onMounted, onBeforeUnmount, watch, shallowRef } from 'vue';
import * as echarts from 'echarts';

const props = withDefaults(
  defineProps<{
    options: echarts.EChartsOption;
    width?: string;
    height?: string;
    theme?: string;
    resizeDelay?: number;
  }>(),
  { width: '100%', height: '400px', resizeDelay: 200 },
);

const domRef = ref<HTMLDivElement>();
const chartRef = shallowRef<echarts.ECharts>();
let resizeTimer: ReturnType<typeof setTimeout>;

function initChart() {
  if (!domRef.value) return;
  chartRef.value?.dispose();
  chartRef.value = echarts.init(domRef.value, props.theme);
  chartRef.value.setOption(props.options);
}

// 窗口自适应
function onResize() {
  clearTimeout(resizeTimer);
  resizeTimer = setTimeout(() => chartRef.value?.resize(), props.resizeDelay);
}

onMounted(() => {
  initChart();
  window.addEventListener('resize', onResize);
});

onBeforeUnmount(() => {
  window.removeEventListener('resize', onResize);
  chartRef.value?.dispose();
});

watch(() => props.options, () => chartRef.value?.setOption(props.options), { deep: true });
watch(() => props.theme, () => initChart());
</script>

<template>
  <div ref="domRef" :style="{ width, height }" />
</template>
```

---

## 3. 常见图表示例

### 折线图 — 销售趋势

```vue
<script setup>
import VChart from '#/components/Charts/VChart.vue';

const lineOptions = {
  tooltip: { trigger: 'axis' },
  legend: { data: ['本月', '上月'] },
  xAxis: {
    type: 'category',
    data: ['1月', '2月', '3月', '4月', '5月', '6月'],
  },
  yAxis: { type: 'value' },
  series: [
    {
      name: '本月',
      type: 'line',
      data: [820, 932, 901, 1234, 1290, 1330],
      smooth: true,
      areaStyle: { opacity: 0.15 },
    },
    {
      name: '上月',
      type: 'line',
      data: [720, 812, 850, 980, 1050, 1100],
      smooth: true,
      lineStyle: { type: 'dashed' },
    },
  ],
};
</script>

<template>
  <VChart :options="lineOptions" height="350px" />
</template>
```

### 柱状图 — 订单统计

```vue
<script setup>
const barOptions = {
  tooltip: { trigger: 'axis' },
  xAxis: {
    type: 'category',
    data: ['待付款', '已付款', '已发货', '已完成', '已退款'],
  },
  yAxis: { type: 'value' },
  series: [
    {
      name: '订单数',
      type: 'bar',
      data: [120, 200, 150, 80, 70],
      itemStyle: {
        borderRadius: [4, 4, 0, 0],
        color: {
          type: 'linear',
          x: 0, y: 0, x2: 0, y2: 1,
          colorStops: [
            { offset: 0, color: '#1890ff' },
            { offset: 1, color: '#69c0ff' },
          ],
        },
      },
    },
  ],
};
</script>

<template>
  <VChart :options="barOptions" height="350px" />
</template>
```

### 饼图 — 客户来源

```vue
<script setup>
const pieOptions = {
  tooltip: { trigger: 'item', formatter: '{b}: {c} ({d}%)' },
  legend: { bottom: '0%' },
  series: [
    {
      name: '来源',
      type: 'pie',
      radius: ['40%', '70%'],
      center: ['50%', '45%'],
      avoidLabelOverlap: true,
      label: { show: false },
      emphasis: {
        label: { show: true, fontSize: 14, fontWeight: 'bold' },
      },
      data: [
        { value: 1048, name: '搜索引擎', itemStyle: { color: '#1890ff' } },
        { value: 735, name: '社交媒体', itemStyle: { color: '#52c41a' } },
        { value: 580, name: '直接访问', itemStyle: { color: '#faad14' } },
        { value: 484, name: '广告投放', itemStyle: { color: '#ff4d4f' } },
        { value: 300, name: '其他', itemStyle: { color: '#722ed1' } },
      ],
    },
  ],
};
</script>

<template>
  <VChart :options="pieOptions" height="350px" />
</template>
```

### 仪表盘 — 关键指标

```vue
<script setup>
const gaugeOptions = {
  series: [
    {
      type: 'gauge',
      min: 0,
      max: 100,
      progress: { show: true, width: 12 },
      axisLine: {
        lineStyle: { width: 12, color: [[0.5, '#52c41a'], [0.8, '#faad14'], [1, '#ff4d4f']] },
      },
      axisTick: { show: false },
      splitLine: { length: 8 },
      axisLabel: { distance: 20 },
      detail: {
        valueAnimation: true,
        formatter: '{value}%',
        fontSize: 20,
      },
      data: [{ value: 82.5, name: '完成率' }],
    },
  ],
};
</script>

<template>
  <VChart :options="gaugeOptions" height="280px" />
</template>
```

### KPI 卡片 + 迷你趋势

```vue
<template>
  <div class="grid grid-cols-4 gap-4 mb-4">
    <div class="bg-white rounded-lg p-4 shadow-sm">
      <div class="text-gray-500 text-sm">总销售额</div>
      <div class="text-2xl font-bold mt-1">¥ 126,560</div>
      <div class="flex items-center mt-2 text-xs">
        <span class="text-green-500">↑ 12.5%</span>
        <span class="text-gray-400 ml-2">较上月</span>
      </div>
    </div>
    <div class="bg-white rounded-lg p-4 shadow-sm">
      <div class="text-gray-500 text-sm">今日订单</div>
      <div class="text-2xl font-bold mt-1">1,280</div>
      <div class="flex items-center mt-2 text-xs">
        <span class="text-red-500">↓ 3.2%</span>
        <span class="text-gray-400 ml-2">较昨日</span>
      </div>
    </div>
    <div class="bg-white rounded-lg p-4 shadow-sm">
      <div class="text-gray-500 text-sm">活跃用户</div>
      <div class="text-2xl font-bold mt-1">8,432</div>
      <div class="flex items-center mt-2 text-xs">
        <span class="text-green-500">↑ 8.1%</span>
        <span class="text-gray-400 ml-2">较上周</span>
      </div>
    </div>
    <div class="bg-white rounded-lg p-4 shadow-sm">
      <div class="text-gray-500 text-sm">转化率</div>
      <div class="text-2xl font-bold mt-1">3.24%</div>
      <div class="flex items-center mt-2 text-xs">
        <span class="text-green-500">↑ 0.6%</span>
        <span class="text-gray-400 ml-2">较上月</span>
      </div>
    </div>
  </div>
</template>
```

---

## 4. 与 Vben VxeTable 集成（迷你图表）

VxeTable 支持在列中内嵌迷你走势图（Sparkline），适合在表格中展示趋势：

```ts
const gridOptions = {
  columns: [
    { title: '商品', field: 'name', minWidth: 120 },
    {
      title: '周趋势',
      field: 'trend',
      width: 160,
      align: 'center',
      cellRender: {
        name: 'VxeChartLine',
        props: {
          options: { xAxis: false, yAxis: false },
        },
      },
    },
    { title: '销量', field: 'sales', width: 100 },
  ],
  data: [
    { name: '商品A', trend: [120, 135, 110, 160, 145, 170, 190], sales: 1230 },
    { name: '商品B', trend: [80, 95, 100, 85, 110, 105, 130], sales: 705 },
  ],
};
```

---

## 5. 其他图表库选项

| 库 | 特点 | 安装 |
|---|---|---|
| [ECharts](https://echarts.apache.org/) | 功能最全，社区最成熟，Vben 首选 | `echarts + vue-echarts` |
| [AntV G2](https://antv.vision/) | 阿里巴巴出品，语法简洁，统计图表强 | `@antv/g2` |
| [Chart.js](https://www.chartjs.org/) | 轻量，API 简单，适合简单图表 | `chart.js + vue-chartjs` |
| [TinyChart](https://tiny-charts.vercel.app/) | 极简迷你图表，适合表格内嵌 | `tiny-chart` |
| [VxeChart](https://vxetable.cn/) | VxeTable 自带，表格内嵌图表 | 已随 VxeTable 内置 |

---

## 6. 在 Dashboard 中使用

Dashboard 页面通常组合多种图表卡片，推荐布局：

```
┌─────────────┬─────────────┬─────────────┬─────────────┐
│   KPI 卡片   │   KPI 卡片   │   KPI 卡片   │   KPI 卡片   │
├─────────────┴─────────────┴─────────────┴─────────────┤
│                    折线图（销售趋势）                      │
├─────────────┬─────────────┬─────────────┬─────────────┤
│  柱状图       │   柱状图      │   饼图       │   仪表盘      │
│  (订单统计)   │   (分类统计)  │   (来源分布)  │   (完成率)    │
├─────────────┴─────────────┴─────────────┴─────────────┤
│                 表格（Top N 排行）                        │
└────────────────────────────────────────────────────────┘
```

详见 [industry-templates.md](industry-templates.md) 中各系统类型的 Dashboard 数据卡片配置。
