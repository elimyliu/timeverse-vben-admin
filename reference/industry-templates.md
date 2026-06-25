# 行业模板与默认菜单

当用户提出"搭建后台管理系统"时，**必须先询问用户需要哪种类型的系统**，然后使用对应模板初始化基础架构（路由、菜单、页面结构、权限码）。

## 询问话术

```
请选择要搭建的后台系统类型：

  [运营/增长类]
   1. 电商后台     — 商品、订单、营销、财务管理
   2. O2O 平台     — 门店、预约、技师、核销
   3. 外卖/餐饮系统 — 菜品、桌台、厨打、配送
   4. 酒店管理 PMS  — 房态、预订、入住/退房、客房服务
  [企业资源类]
   5. ERP 系统     — 采购、销售、库存、生产、财务、人事
  [客户/内容类]
   6. CRM 系统     — 客户、销售漏斗、工单、报表
   7. CMS 系统     — 内容、分类、标签、评论管理
  [金融/财务类]
   8. 支付系统     — 商户、渠道、交易、清结算、对账
   9. 金融后台     — 账户、理财、借款、风控
  10. 财务系统 FMS — 凭证、账务、资产、预算、税务
  [行业垂直类]
  11. 医疗 HIS     — 挂号、门诊/住院、药房、病历
  12. 教育系统     — 学生、课程、排课、成绩、招生
  13. 物业系统     — 房产、业主、收费、报修、巡检
  14. 物流 TMS     — 运单、路由、车辆、签收
  15. MES 制造执行 — 工单、质检、设备、工艺、看板
  [平台/协作类]
  16. SaaS 平台    — 租户、套餐、应用、账单管理
  17. OA/办公系统  — 审批、考勤、公告、会议、文档
  18. API 开放平台 — 应用管理、API 文档、流量控制、调用统计
  [通用]
  19. 通用后台     — 用户/角色/菜单/部门/字典/监控
  20. 自定义       — 由你描述需求，我为你定制
```

---

## 1. 电商后台

### 默认菜单结构

| 一级菜单 | 二级菜单 | 路由 path | 权限码 | 图标 |
|---|---|---|---|---|
| Dashboard | 销售概览 | `/dashboard/analytics` | - | `mdi:chart-box-outline` |
| Dashboard | 工作台 | `/dashboard/workspace` | - | `mdi:view-dashboard` |
| 商品管理 | 商品列表 | `/product/list` | `product:list` | `mdi:package-variant-closed` |
| 商品管理 | 商品分类 | `/product/category` | `product:category` | `mdi:shape` |
| 商品管理 | 商品品牌 | `/product/brand` | `product:brand` | `mdi:trademark` |
| 商品管理 | 商品标签 | `/product/tag` | `product:tag` | `mdi:tag` |
| 订单管理 | 订单列表 | `/order/list` | `order:list` | `mdi:clipboard-list` |
| 订单管理 | 退款管理 | `/order/refund` | `order:refund` | `mdi:cash-refund` |
| 订单管理 | 物流管理 | `/order/logistics` | `order:logistics` | `mdi:truck` |
| 用户管理 | 会员列表 | `/user/member` | `user:member` | `mdi:account-group` |
| 用户管理 | 会员等级 | `/user/level` | `user:level` | `mdi:account-star` |
| 营销中心 | 优惠券 | `/marketing/coupon` | `marketing:coupon` | `mdi:ticket-percent` |
| 营销中心 | 秒杀活动 | `/marketing/seckill` | `marketing:seckill` | `mdi:flash` |
| 营销中心 | 广告管理 | `/marketing/ad` | `marketing:ad` | `mdi:bullhorn` |
| 财务管理 | 对账管理 | `/finance/reconciliation` | `finance:reconciliation` | `mdi:book-check` |
| 财务管理 | 结算管理 | `/finance/settlement` | `finance:settlement` | `mdi:cash-multiple` |
| 设置 | 店铺设置 | `/setting/shop` | `setting:shop` | `mdi:store-cog` |
| 设置 | 运费模板 | `/setting/shipping` | `setting:shipping` | `mdi:truck-delivery` |
| 设置 | 支付方式 | `/setting/payment` | `setting:payment` | `mdi:credit-card` |

### 默认权限角色

| 角色 | 说明 | 权限范围 |
|---|---|---|
| `super_admin` | 超级管理员 | 所有权限 |
| `shop_manager` | 店铺管理员 | 商品/订单/用户/营销，不含财务 |
| `customer_service` | 客服 | 订单/用户（只读） |
| `finance` | 财务 | 订单（只读）/ 财务管理 |

### 默认功能特性

- 商品 SKU/多规格管理
- 订单状态流转（待付款 → 已付款 → 已发货 → 已完成 → 已退款）
- 会员积分/成长值体系
- 优惠券发放与核销
- 数据看板：今日订单数、销售额、访客数、转化率

---

## 2. ERP 系统

### 默认菜单结构

| 一级菜单 | 二级菜单 | 路由 path | 权限码 | 图标 |
|---|---|---|---|---|
| Dashboard | 生产概览 | `/dashboard/analytics` | - | `mdi:chart-box-outline` |
| Dashboard | 工作台 | `/dashboard/workspace` | - | `mdi:view-dashboard` |
| 采购管理 | 采购单 | `/purchase/order` | `purchase:order` | `mdi:cart-arrow-down` |
| 采购管理 | 供应商管理 | `/purchase/supplier` | `purchase:supplier` | `mdi:account-tie` |
| 采购管理 | 采购退货 | `/purchase/return` | `purchase:return` | `mdi:cart-arrow-up` |
| 销售管理 | 销售订单 | `/sales/order` | `sales:order` | `mdi:cart-check` |
| 销售管理 | 客户管理 | `/sales/customer` | `sales:customer` | `mdi:account-group` |
| 销售管理 | 销售退货 | `/sales/return` | `sales:return` | `mdi:cart-minus` |
| 库存管理 | 库存列表 | `/inventory/list` | `inventory:list` | `mdi:warehouse` |
| 库存管理 | 入库管理 | `/inventory/inbound` | `inventory:inbound` | `mdi:arrow-collapse-down` |
| 库存管理 | 出库管理 | `/inventory/outbound` | `inventory:outbound` | `mdi:arrow-expand-up` |
| 库存管理 | 库存盘点 | `/inventory/check` | `inventory:check` | `mdi:clipboard-check` |
| 生产管理 | 生产工单 | `/production/order` | `production:order` | `mdi:factory` |
| 生产管理 | BOM 管理 | `/production/bom` | `production:bom` | `mdi:code-tags` |
| 生产管理 | 生产排期 | `/production/schedule` | `production:schedule` | `mdi:calendar-clock` |
| 财务管理 | 应收管理 | `/finance/receivable` | `finance:receivable` | `mdi:cash-plus` |
| 财务管理 | 应付管理 | `/finance/payable` | `finance:payable` | `mdi:cash-minus` |
| 财务管理 | 成本核算 | `/finance/costing` | `finance:costing` | `mdi:calculator` |
| 人力资源管理 | 员工管理 | `/hr/employee` | `hr:employee` | `mdi:account-multiple` |
| 人力资源管理 | 考勤管理 | `/hr/attendance` | `hr:attendance` | `mdi:calendar-check` |
| 人力资源管理 | 薪资管理 | `/hr/payroll` | `hr:payroll` | `mdi:cash` |
| 系统设置 | 基础数据 | `/setting/basic` | `setting:basic` | `mdi:cog` |
| 系统设置 | 流程配置 | `/setting/workflow` | `setting:workflow` | `mdi:file-settings` |

### 默认权限角色

| 角色 | 说明 | 权限范围 |
|---|---|---|
| `super_admin` | 超级管理员 | 所有权限 |
| `purchase_manager` | 采购经理 | 采购管理全部 |
| `sales_manager` | 销售经理 | 销售管理全部 |
| `warehouse_keeper` | 仓管员 | 库存管理 |
| `production_manager` | 生产主管 | 生产管理 |
| `finance_staff` | 财务 | 财务管理 |
| `hr_staff` | HR | 人力资源管理 |

### 默认功能特性

- 单据审批流转（采购单审核 → 入库确认 → 财务结算）
- 库存预警（低于安全库存自动提醒）
- 批次/序列号追踪

---

## 3. CRM 系统

### 默认菜单结构

| 一级菜单 | 二级菜单 | 路由 path | 权限码 | 图标 |
|---|---|---|---|---|
| Dashboard | 销售看板 | `/dashboard/analytics` | - | `mdi:chart-box-outline` |
| Dashboard | 工作台 | `/dashboard/workspace` | - | `mdi:view-dashboard` |
| 客户管理 | 客户列表 | `/customer/list` | `customer:list` | `mdi:account-group` |
| 客户管理 | 客户公海 | `/customer/pool` | `customer:pool` | `mdi:account-multiple-outline` |
| 客户管理 | 客户标签 | `/customer/tag` | `customer:tag` | `mdi:tag-multiple` |
| 客户管理 | 客户分级 | `/customer/rating` | `customer:rating` | `mdi:star` |
| 销售管理 | 销售漏斗 | `/sales/funnel` | `sales:funnel` | `mdi:chart-funnel` |
| 销售管理 | 商机管理 | `/sales/opportunity` | `sales:opportunity` | `mdi:target` |
| 销售管理 | 报价管理 | `/sales/quote` | `sales:quote` | `mdi:currency-usd` |
| 销售管理 | 合同管理 | `/sales/contract` | `sales:contract` | `mdi:file-sign` |
| 工单管理 | 工单列表 | `/ticket/list` | `ticket:list` | `mdi:ticket-outline` |
| 工单管理 | 工单分类 | `/ticket/category` | `ticket:category` | `mdi:shape` |
| 工单管理 | SLA 管理 | `/ticket/sla` | `ticket:sla` | `mdi:clock-alert` |
| 报表分析 | 销售报表 | `/report/sales` | `report:sales` | `mdi:chart-line` |
| 报表分析 | 客户分析 | `/report/customer` | `report:customer` | `mdi:chart-bar` |
| 报表分析 | 客服报表 | `/report/service` | `report:service` | `mdi:chart-timeline` |
| 设置 | 字段配置 | `/setting/field` | `setting:field` | `mdi:table-cog` |
| 设置 | 审批流程 | `/setting/approval` | `setting:approval` | `mdi:file-check` |
| 设置 | 通知模板 | `/setting/notification` | `setting:notification` | `mdi:bell-cog` |

### 默认权限角色

| 角色 | 说明 | 权限范围 |
|---|---|---|
| `super_admin` | 超级管理员 | 所有权限 |
| `sales_rep` | 销售代表 | 客户/销售管理（本人数据） |
| `sales_manager` | 销售主管 | 客户/销售管理（全部数据） |
| `cs_staff` | 客服人员 | 工单管理 |
| `cs_manager` | 客服主管 | 工单管理 + 报表 |

### 默认功能特性

- 客户跟进记录时间线
- 销售漏斗阶段转换（线索 → 意向 → 报价 → 谈判 → 成交）
- 工单自动分配 + SLA 超时提醒
- 客户公海规则（超时未跟进自动回收）

---

## 4. CMS 系统

### 默认菜单结构

| 一级菜单 | 二级菜单 | 路由 path | 权限码 | 图标 |
|---|---|---|---|---|
| Dashboard | 内容概览 | `/dashboard/analytics` | - | `mdi:chart-box-outline` |
| Dashboard | 工作台 | `/dashboard/workspace` | - | `mdi:view-dashboard` |
| 内容管理 | 文章列表 | `/content/article` | `content:article` | `mdi:file-document` |
| 内容管理 | 文章编辑 | `/content/article/edit/:id` | `content:article:edit` | `mdi:file-edit` |
| 内容管理 | 专题管理 | `/content/feature` | `content:feature` | `mdi:book-open-variant` |
| 内容管理 | 素材管理 | `/content/media` | `content:media` | `mdi:folder-multiple-image` |
| 分类管理 | 文章分类 | `/category/article` | `category:article` | `mdi:shape` |
| 分类管理 | 专题分类 | `/category/feature` | `category:feature` | `mdi:shape-plus` |
| 评论管理 | 评论列表 | `/comment/list` | `comment:list` | `mdi:comment-text` |
| 评论管理 | 评论审核 | `/comment/review` | `comment:review` | `mdi:comment-check` |
| 用户管理 | 注册用户 | `/user/registered` | `user:registered` | `mdi:account-group` |
| 用户管理 | 用户角色 | `/user/role` | `user:role` | `mdi:account-cog` |
| 设置 | 站点设置 | `/setting/site` | `setting:site` | `mdi:cog` |
| 设置 | 导航菜单 | `/setting/nav` | `setting:nav` | `mdi:menu` |
| 设置 | 友情链接 | `/setting/link` | `setting:link` | `mdi:link-variant` |

### 默认权限角色

| 角色 | 说明 | 权限范围 |
|---|---|---|
| `super_admin` | 超级管理员 | 所有权限 |
| `editor` | 编辑 | 内容管理/分类管理 |
| `author` | 作者 | 文章管理（本人） |
| `comment_moderator` | 评论审核员 | 评论管理 |

### 默认功能特性

- Markdown / 富文本编辑器
- 文章自动摘要生成
- 定时发布
- 多站点/多语言支持

---

## 5. SaaS 平台

### 默认菜单结构

| 一级菜单 | 二级菜单 | 路由 path | 权限码 | 图标 |
|---|---|---|---|---|
| Dashboard | 平台概览 | `/dashboard/analytics` | - | `mdi:chart-box-outline` |
| Dashboard | 工作台 | `/dashboard/workspace` | - | `mdi:view-dashboard` |
| 租户管理 | 租户列表 | `/tenant/list` | `tenant:list` | `mdi:domain` |
| 租户管理 | 租户审核 | `/tenant/review` | `tenant:review` | `mdi:domain-plus` |
| 租户管理 | 租户配置 | `/tenant/config` | `tenant:config` | `mdi:domain-cog` |
| 套餐管理 | 套餐列表 | `/plan/list` | `plan:list` | `mdi:package` |
| 套餐管理 | 套餐订单 | `/plan/order` | `plan:order` | `mdi:clipboard-list` |
| 应用管理 | 应用列表 | `/app/list` | `app:list` | `mdi:apps` |
| 应用管理 | 应用审核 | `/app/review` | `app:review` | `mdi:apps-plus` |
| 用户管理 | 平台用户 | `/user/platform` | `user:platform` | `mdi:account-supervisor` |
| 用户管理 | 操作日志 | `/user/log` | `user:log` | `mdi:history` |
| 账单管理 | 费用账单 | `/billing/invoice` | `billing:invoice` | `mdi:file-invoice` |
| 账单管理 | 充值记录 | `/billing/recharge` | `billing:recharge` | `mdi:cash-plus` |
| 账单管理 | 发票管理 | `/billing/invoice` | `billing:invoice` | `mdi:receipt` |
| 系统设置 | 全局配置 | `/setting/global` | `setting:global` | `mdi:cog` |
| 系统设置 | 邮件/短信 | `/setting/notification` | `setting:notification` | `mdi:email-cog` |
| 系统设置 | 安全设置 | `/setting/security` | `setting:security` | `mdi:shield-cog` |

### 默认权限角色

| 角色 | 说明 | 权限范围 |
|---|---|---|
| `super_admin` | 超级管理员 | 所有权限 |
| `ops_manager` | 运营经理 | 租户/套餐/应用管理 |
| `finance_staff` | 财务 | 账单管理 |
| `support_staff` | 技术支持 | 租户查看/工单管理 |

### 默认功能特性

- 租户隔离（独立数据库/独立域名）
- 套餐订阅与自动续费
- 用量监控与配额限制
- 操作审计日志

---

## 6. 通用后台

### 默认菜单结构

| 一级菜单 | 二级菜单 | 路由 path | 权限码 | 图标 |
|---|---|---|---|---|
| Dashboard | 分析页 | `/dashboard/analytics` | - | `mdi:chart-box-outline` |
| Dashboard | 工作台 | `/dashboard/workspace` | - | `mdi:view-dashboard` |
| 系统管理 | 用户管理 | `/system/user` | `system:user` | `mdi:account-cog` |
| 系统管理 | 角色管理 | `/system/role` | `system:role` | `mdi:account-key` |
| 系统管理 | 菜单管理 | `/system/menu` | `system:menu` | `mdi:menu` |
| 系统管理 | 部门管理 | `/system/dept` | `system:dept` | `mdi:office-building` |
| 系统管理 | 岗位管理 | `/system/post` | `system:post` | `mdi:badge-account` |
| 系统管理 | 字典管理 | `/system/dict` | `system:dict` | `mdi:book-open` |
| 系统管理 | 参数设置 | `/system/params` | `system:params` | `mdi:tune` |
| 系统管理 | 操作日志 | `/system/log` | `system:log` | `mdi:history` |
| 系统监控 | 在线用户 | `/monitor/online` | `monitor:online` | `mdi:account-online` |
| 系统监控 | 定时任务 | `/monitor/job` | `monitor:job` | `mdi:clock` |
| 系统监控 | 数据监控 | `/monitor/data` | `monitor:data` | `mdi:database` |
| 系统监控 | 服务监控 | `/monitor/server` | `monitor:server` | `mdi:server` |

### 默认权限角色

| 角色 | 说明 | 权限范围 |
|---|---|---|
| `super_admin` | 超级管理员 | 所有权限 |
| `system_manager` | 系统管理员 | 系统管理全部 |
| `operator` | 运营人员 | Dashboard + 部分系统管理（只读） |
| `auditor` | 审计员 | 操作日志（只读） |

### 默认功能特性

- RBAC 权限模型（用户 → 角色 → 菜单/按钮权限）
- 数据字典（类型/标签/状态等枚举值管理）
- 操作日志审计
- 定时任务可视化配置

---

## 7. O2O 平台（运营/增长类）

### 默认菜单结构

| 一级菜单 | 二级菜单 | 路由 path | 权限码 | 图标 |
|---|---|---|---|---|
| Dashboard | 运营概览 | `/dashboard/analytics` | - | `mdi:chart-box-outline` |
| Dashboard | 工作台 | `/dashboard/workspace` | - | `mdi:view-dashboard` |
| 门店管理 | 门店列表 | `/store/list` | `store:list` | `mdi:store` |
| 门店管理 | 门店审核 | `/store/review` | `store:review` | `mdi:store-check` |
| 门店管理 | 门店分类 | `/store/category` | `store:category` | `mdi:shape` |
| 预约管理 | 预约列表 | `/booking/list` | `booking:list` | `mdi:calendar-check` |
| 预约管理 | 排班管理 | `/booking/schedule` | `booking:schedule` | `mdi:calendar-clock` |
| 预约管理 | 服务项目管理 | `/booking/service` | `booking:service` | `mdi:clipboard-list` |
| 技师/服务人员管理 | 人员列表 | `/staff/list` | `staff:list` | `mdi:account-tie` |
| 技师/服务人员管理 | 等级管理 | `/staff/level` | `staff:level` | `mdi:account-star` |
| 技师/服务人员管理 | 提成管理 | `/staff/commission` | `staff:commission` | `mdi:percent` |
| 订单管理 | 订单列表 | `/order/list` | `order:list` | `mdi:clipboard-list` |
| 订单管理 | 核销管理 | `/order/verify` | `order:verify` | `mdi:qrcode-scan` |
| 订单管理 | 退款管理 | `/order/refund` | `order:refund` | `mdi:cash-refund` |
| 营销中心 | 优惠券 | `/marketing/coupon` | `marketing:coupon` | `mdi:ticket-percent` |
| 营销中心 | 活动管理 | `/marketing/activity` | `marketing:activity` | `mdi:gift` |
| 营销中心 | 评价管理 | `/marketing/review` | `marketing:review` | `mdi:star` |
| 财务管理 | 交易流水 | `/finance/transactions` | `finance:transactions` | `mdi:transaction` |
| 财务管理 | 结算管理 | `/finance/settlement` | `finance:settlement` | `mdi:cash-multiple` |
| 设置 | 平台设置 | `/setting/platform` | `setting:platform` | `mdi:cog` |
| 设置 | 抽佣配置 | `/setting/commission` | `setting:commission` | `mdi:percentage` |

### 默认权限角色

| 角色 | 说明 | 权限范围 |
|---|---|---|
| `super_admin` | 超级管理员 | 所有权限 |
| `store_manager` | 门店店长 | 本店预约/订单/人员/评价 |
| `staff` | 服务人员 | 本人的预约/订单 |
| `finance` | 财务 | 交易流水/结算 |
| `operator` | 运营 | 门店/营销（不含财务） |

### 默认功能特性

- 基于 LBS 的门店推荐
- 在线预约 + 自动排班
- 服务完成核销（二维码/验证码）
- 技师提成自动计算
- 评价回复与投诉处理

---

## 8. 外卖/餐饮系统（运营/增长类）

### 默认菜单结构

| 一级菜单 | 二级菜单 | 路由 path | 权限码 | 图标 |
|---|---|---|---|---|
| Dashboard | 营业概览 | `/dashboard/analytics` | - | `mdi:chart-box-outline` |
| Dashboard | 工作台 | `/dashboard/workspace` | - | `mdi:view-dashboard` |
| 菜品管理 | 菜品列表 | `/dish/list` | `dish:list` | `mdi:food` |
| 菜品管理 | 菜品分类 | `/dish/category` | `dish:category` | `mdi:shape` |
| 菜品管理 | 菜品规格 | `/dish/spec` | `dish:spec` | `mdi:food-variant` |
| 菜品管理 | 套餐管理 | `/dish/combo` | `dish:combo` | `mdi:food-fork-drink` |
| 桌台管理 | 桌台列表 | `/table/list` | `table:list` | `mdi:table-furniture` |
| 桌台管理 | 桌台区域 | `/table/zone` | `table:zone` | `mdi:map` |
| 订单管理 | 堂食订单 | `/order/dine-in` | `order:dine-in` | `mdi:seat` |
| 订单管理 | 外卖订单 | `/order/delivery` | `order:delivery` | `mdi:moped` |
| 订单管理 | 自取订单 | `/order/pickup` | `order:pickup` | `mdi:walk` |
| 订单管理 | 退款/退菜 | `/order/refund` | `order:refund` | `mdi:cash-refund` |
| 厨打管理 | 厨打配置 | `/kitchen/printer` | `kitchen:printer` | `mdi:printer` |
| 厨打管理 | 出餐管理 | `/kitchen/out` | `kitchen:out` | `mdi:food-turkey` |
| 配送管理 | 配送员管理 | `/delivery/rider` | `delivery:rider` | `mdi:account-tie` |
| 配送管理 | 配送区域 | `/delivery/zone` | `delivery:zone` | `mdi:map-marker-radius` |
| 配送管理 | 配送费配置 | `/delivery/fee` | `delivery:fee` | `mdi:cash` |
| 评价管理 | 评价列表 | `/review/list` | `review:list` | `mdi:star` |
| 评价管理 | 评价分析 | `/review/analysis` | `review:analysis` | `mdi:chart-bar` |
| 营销中心 | 优惠活动 | `/marketing/promo` | `marketing:promo` | `mdi:sale` |
| 营销中心 | 满减配置 | `/marketing/discount` | `marketing:discount` | `mdi:percent` |
| 设置 | 店铺设置 | `/setting/shop` | `setting:shop` | `mdi:store-cog` |
| 设置 | 营业时间 | `/setting/hours` | `setting:hours` | `mdi:clock-outline` |
| 设置 | 支付方式 | `/setting/payment` | `setting:payment` | `mdi:credit-card` |

### 默认权限角色

| 角色 | 说明 | 权限范围 |
|---|---|---|
| `super_admin` | 超级管理员 | 所有权限 |
| `shop_manager` | 店长 | 菜品/桌台/订单/评价 |
| `chef` | 厨师 | 厨打管理（只读） |
| `rider` | 配送员 | 配送管理（本人） |
| `operator` | 运营 | 营销/评价分析 |

### 默认功能特性

- 扫码点餐 + 厨打自动分单
- 堂食/外卖/自取多模式订单
- 智能配送调度
- 菜品库存预警（估清）
- 营业日报：翻台率、客单价、出餐时长

---

## 9. 酒店管理 PMS（运营/增长类）

### 默认菜单结构

| 一级菜单 | 二级菜单 | 路由 path | 权限码 | 图标 |
|---|---|---|---|---|
| Dashboard | 经营概览 | `/dashboard/analytics` | - | `mdi:chart-box-outline` |
| Dashboard | 工作台 | `/dashboard/workspace` | - | `mdi:view-dashboard` |
| 房态管理 | 房态图 | `/room/status` | `room:status` | `mdi:grid` |
| 房态管理 | 房型管理 | `/room/type` | `room:type` | `mdi:door` |
| 房态管理 | 房价策略 | `/room/price` | `room:price` | `mdi:cash-multiple` |
| 房态管理 | 房态设置 | `/room/config` | `room:config` | `mdi:cog` |
| 预订管理 | 预订列表 | `/reservation/list` | `reservation:list` | `mdi:calendar-check` |
| 预订管理 | 团队预订 | `/reservation/group` | `reservation:group` | `mdi:account-group` |
| 预订管理 | 渠道管理 | `/reservation/channel` | `reservation:channel` | `mdi:link` |
| 前台管理 | 入住登记 | `/front/check-in` | `front:check-in` | `mdi:login` |
| 前台管理 | 退房结账 | `/front/check-out` | `front:check-out` | `mdi:logout` |
| 前台管理 | 换房/续住 | `/front/change` | `front:change` | `mdi:swap-horizontal` |
| 前台管理 | 客人信息 | `/front/guest` | `front:guest` | `mdi:account` |
| 客房服务 | 打扫管理 | `/housekeeping/clean` | `housekeeping:clean` | `mdi:broom` |
| 客房服务 | 报修管理 | `/housekeeping/repair` | `housekeeping:repair` | `mdi:tools` |
| 客房服务 | 物品管理 | `/housekeeping/item` | `housekeeping:item` | `mdi:package` |
| 客房服务 | 失物招领 | `/housekeeping/lost` | `housekeeping:lost` | `mdi:bag-personal` |
| 财务管理 | 应收管理 | `/finance/receivable` | `finance:receivable` | `mdi:cash-plus` |
| 财务管理 | 押金管理 | `/finance/deposit` | `finance:deposit` | `mdi:cash-lock` |
| 财务管理 | 报表统计 | `/finance/report` | `finance:report` | `mdi:chart-line` |
| 设置 | 酒店设置 | `/setting/hotel` | `setting:hotel` | `mdi:city-variant` |
| 设置 | 用户权限 | `/setting/role` | `setting:role` | `mdi:account-cog` |

### 默认权限角色

| 角色 | 说明 | 权限范围 |
|---|---|---|
| `super_admin` | 超级管理员 | 所有权限 |
| `front_desk` | 前台 | 房态/预订/入住/退房/客人信息 |
| `housekeeper` | 客房服务员 | 客房服务全部 |
| `finance` | 财务 | 财务管理/报表 |
| `reservation_clerk` | 预订员 | 预订管理 |

### 默认功能特性

- 可视化房态图（拖拽换房/续住）
- 多渠道房价策略（OTA 直连）
- 身份证 OCR 快速入住
- 自动夜审（日租房费过账）
- 会员积分 + 储值卡

---

## 10. 支付系统（金融/财务类）

### 默认菜单结构

| 一级菜单 | 二级菜单 | 路由 path | 权限码 | 图标 |
|---|---|---|---|---|
| Dashboard | 交易概览 | `/dashboard/analytics` | - | `mdi:chart-box-outline` |
| Dashboard | 工作台 | `/dashboard/workspace` | - | `mdi:view-dashboard` |
| 商户管理 | 商户列表 | `/merchant/list` | `merchant:list` | `mdi:store` |
| 商户管理 | 商户审核 | `/merchant/review` | `merchant:review` | `mdi:store-check` |
| 商户管理 | 商户配置 | `/merchant/config` | `merchant:config` | `mdi:store-cog` |
| 商户管理 | 费率管理 | `/merchant/rate` | `merchant:rate` | `mdi:percent` |
| 渠道管理 | 支付渠道 | `/channel/list` | `channel:list` | `mdi:credit-card` |
| 渠道管理 | 渠道配置 | `/channel/config` | `channel:config` | `mdi:cog` |
| 渠道管理 | 渠道对账 | `/channel/reconciliation` | `channel:reconciliation` | `mdi:book-check` |
| 交易管理 | 交易流水 | `/transaction/list` | `transaction:list` | `mdi:format-list-bulleted` |
| 交易管理 | 退款管理 | `/transaction/refund` | `transaction:refund` | `mdi:cash-refund` |
| 交易管理 | 交易详情 | `/transaction/detail` | `transaction:detail` | `mdi:information` |
| 清结算 | 结算记录 | `/settlement/list` | `settlement:list` | `mdi:cash-multiple` |
| 清结算 | 分账管理 | `/settlement/split` | `settlement:split` | `mdi:account-cash` |
| 清结算 | 结算报表 | `/settlement/report` | `settlement:report` | `mdi:file-document` |
| 对账管理 | 平台对账 | `/reconciliation/platform` | `reconciliation:platform` | `mdi:book-check` |
| 对账管理 | 差错处理 | `/reconciliation/error` | `reconciliation:error` | `mdi:alert-circle` |
| 对账管理 | 对账报表 | `/reconciliation/report` | `reconciliation:report` | `mdi:file-chart` |
| 风控管理 | 风控规则 | `/risk/rule` | `risk:rule` | `mdi:shield-check` |
| 风控管理 | 风控事件 | `/risk/event` | `risk:event` | `mdi:alert` |
| 风控管理 | 黑白名单 | `/risk/blacklist` | `risk:blacklist` | `mdi:account-cancel` |
| 设置 | 系统配置 | `/setting/system` | `setting:system` | `mdi:cog` |
| 设置 | 通知配置 | `/setting/notification` | `setting:notification` | `mdi:bell-cog` |

### 默认权限角色

| 角色 | 说明 | 权限范围 |
|---|---|---|
| `super_admin` | 超级管理员 | 所有权限 |
| `merchant_manager` | 商户经理 | 商户管理全部 |
| `channel_manager` | 渠道运营 | 渠道管理/交易查询 |
| `finance` | 财务 | 清结算/对账 |
| `risk_officer` | 风控专员 | 风控管理全部 |

### 默认功能特性

- 多渠道聚合支付（微信/支付宝/银联）
- T+1 自动结算 + 可配分账
- 渠道/平台双向对账 + 差错处理
- 实时风控（交易频率/金额阈值/IP 检测）
- 商户自助对账单下载

---

## 11. 金融后台（金融/财务类）

### 默认菜单结构

| 一级菜单 | 二级菜单 | 路由 path | 权限码 | 图标 |
|---|---|---|---|---|
| Dashboard | 运营概览 | `/dashboard/analytics` | - | `mdi:chart-box-outline` |
| Dashboard | 工作台 | `/dashboard/workspace` | - | `mdi:view-dashboard` |
| 用户管理 | 用户列表 | `/user/list` | `user:list` | `mdi:account-group` |
| 用户管理 | 实名认证 | `/user/kyc` | `user:kyc` | `mdi:badge-account` |
| 用户管理 | 用户分级 | `/user/level` | `user:level` | `mdi:account-star` |
| 用户管理 | 黑名单 | `/user/blacklist` | `user:blacklist` | `mdi:account-cancel` |
| 账户管理 | 账户列表 | `/account/list` | `account:list` | `mdi:wallet` |
| 账户管理 | 账户冻结 | `/account/freeze` | `account:freeze` | `mdi:wallet-outline` |
| 账户管理 | 交易记录 | `/account/transaction` | `account:transaction` | `mdi:swap-horizontal` |
| 理财产品 | 产品管理 | `/product/list` | `product:list` | `mdi:package` |
| 理财产品 | 申购管理 | `/product/subscribe` | `product:subscribe` | `mdi:cart-plus` |
| 理财产品 | 赎回管理 | `/product/redeem` | `product:redeem` | `mdi:cash-minus` |
| 理财产品 | 收益发放 | `/product/interest` | `product:interest` | `mdi:cash-plus` |
| 借款管理 | 借款申请 | `/loan/apply` | `loan:apply` | `mdi:file-document` |
| 借款管理 | 借款审核 | `/loan/review` | `loan:review` | `mdi:file-check` |
| 借款管理 | 放款管理 | `/loan/disburse` | `loan:disburse` | `mdi:cash` |
| 借款管理 | 还款管理 | `/loan/repay` | `loan:repay` | `mdi:calendar-check` |
| 借款管理 | 催收管理 | `/loan/collection` | `loan:collection` | `mdi:phone` |
| 风控管理 | 风控规则 | `/risk/rule` | `risk:rule` | `mdi:shield-check` |
| 风控管理 | 风控事件 | `/risk/event` | `risk:event` | `mdi:alert` |
| 风控管理 | 额度管理 | `/risk/limit` | `risk:limit` | `mdi:scale-balance` |
| 报表中心 | 资金报表 | `/report/fund` | `report:fund` | `mdi:chart-line` |
| 报表中心 | 运营报表 | `/report/operation` | `report:operation` | `mdi:chart-bar` |
| 设置 | 产品参数 | `/setting/product` | `setting:product` | `mdi:cog` |
| 设置 | 费率配置 | `/setting/rate` | `setting:rate` | `mdi:percent` |

### 默认权限角色

| 角色 | 说明 | 权限范围 |
|---|---|---|
| `super_admin` | 超级管理员 | 所有权限 |
| `account_manager` | 账户经理 | 用户/账户管理 |
| `product_manager` | 产品经理 | 理财产品管理 |
| `loan_officer` | 信审员 | 借款审核 |
| `risk_manager` | 风控经理 | 风控管理/额度管理 |
| `finance` | 财务 | 报表中心 |

### 默认功能特性

- 多级实名认证（KYC）
- 自动计息 + 收益每日发放
- 风控评分卡模型
- 催收策略（S0-S7 逾期阶段）
- 合规报表导出（监管报送）

---

## 12. 财务系统 FMS（金融/财务类）

### 默认菜单结构

| 一级菜单 | 二级菜单 | 路由 path | 权限码 | 图标 |
|---|---|---|---|---|
| Dashboard | 财务概览 | `/dashboard/analytics` | - | `mdi:chart-box-outline` |
| Dashboard | 工作台 | `/dashboard/workspace` | - | `mdi:view-dashboard` |
| 凭证管理 | 凭证录入 | `/voucher/entry` | `voucher:entry` | `mdi:file-document-edit` |
| 凭证管理 | 凭证审核 | `/voucher/review` | `voucher:review` | `mdi:file-check` |
| 凭证管理 | 凭证查询 | `/voucher/list` | `voucher:list` | `mdi:file-search` |
| 凭证管理 | 凭证打印 | `/voucher/print` | `voucher:print` | `mdi:printer` |
| 账务核算 | 总账管理 | `/accounting/general` | `accounting:general` | `mdi:book-open` |
| 账务核算 | 明细账 | `/accounting/detail` | `accounting:detail` | `mdi:format-list-bulleted` |
| 账务核算 | 辅助核算 | `/accounting/auxiliary` | `accounting:auxiliary` | `mdi:tag` |
| 账务核算 | 期末结账 | `/accounting/close` | `accounting:close` | `mdi:calendar-end` |
| 固定资产 | 资产卡片 | `/asset/card` | `asset:card` | `mdi:card-bulleted` |
| 固定资产 | 资产购置 | `/asset/purchase` | `asset:purchase` | `mdi:cart-plus` |
| 固定资产 | 资产折旧 | `/asset/depreciation` | `asset:depreciation` | `mdi:chart-line` |
| 固定资产 | 资产盘点 | `/asset/inventory` | `asset:inventory` | `mdi:clipboard-check` |
| 应收应付 | 应收管理 | `/ar/list` | `ar:list` | `mdi:cash-plus` |
| 应收应付 | 应付管理 | `/ap/list` | `ap:list` | `mdi:cash-minus` |
| 应收应付 | 账龄分析 | `/ar/aging` | `ar:aging` | `mdi:chart-timeline` |
| 预算管理 | 预算编制 | `/budget/plan` | `budget:plan` | `mdi:clipboard-text` |
| 预算管理 | 预算执行 | `/budget/execution` | `budget:execution` | `mdi:chart-donut` |
| 预算管理 | 预算调整 | `/budget/adjust` | `budget:adjust` | `mdi:swap-horizontal` |
| 税务管理 | 发票管理 | `/tax/invoice` | `tax:invoice` | `mdi:receipt` |
| 税务管理 | 纳税申报 | `/tax/return` | `tax:return` | `mdi:file-document` |
| 税务管理 | 税务测算 | `/tax/estimate` | `tax:estimate` | `mdi:calculator` |
| 报表中心 | 财务报表 | `/report/financial` | `report:financial` | `mdi:file-chart` |
| 报表中心 | 管理报表 | `/report/management` | `report:management` | `mdi:chart-box` |
| 设置 | 科目设置 | `/setting/account` | `setting:account` | `mdi:book-cog` |
| 设置 | 凭证模板 | `/setting/voucher-template` | `setting:voucher-template` | `mdi:file-settings` |

### 默认权限角色

| 角色 | 说明 | 权限范围 |
|---|---|---|
| `super_admin` | 超级管理员 | 所有权限 |
| `accountant` | 会计 | 凭证/账务/资产 |
| `finance_manager` | 财务经理 | 凭证审核 + 报表 |
| `budget_manager` | 预算员 | 预算管理 |
| `tax_staff` | 税务专员 | 税务管理 |
| `auditor` | 审计员 | 全部只读 |

### 默认功能特性

- 凭证智能录入（OCR/导入）
- 自动结转（损益/期间）
- 多维度辅助核算（部门/项目/客户）
- 预算预警（超预算自动拦截）
- 税务自动测算 + 申报表生成

---

## 13. 医疗 HIS 系统（行业垂直类）

### 默认菜单结构

| 一级菜单 | 二级菜单 | 路由 path | 权限码 | 图标 |
|---|---|---|---|---|
| Dashboard | 医院概览 | `/dashboard/analytics` | - | `mdi:chart-box-outline` |
| Dashboard | 工作台 | `/dashboard/workspace` | - | `mdi:view-dashboard` |
| 挂号管理 | 挂号列表 | `/registration/list` | `registration:list` | `mdi:clipboard-list` |
| 挂号管理 | 号源管理 | `/registration/source` | `registration:source` | `mdi:calendar` |
| 挂号管理 | 排班管理 | `/registration/schedule` | `registration:schedule` | `mdi:calendar-clock` |
| 挂号管理 | 退号管理 | `/registration/refund` | `registration:refund` | `mdi:cash-refund` |
| 门诊管理 | 接诊管理 | `/outpatient/consult` | `outpatient:consult` | `mdi:stethoscope` |
| 门诊管理 | 处方管理 | `/outpatient/prescription` | `outpatient:prescription` | `mdi:pill` |
| 门诊管理 | 检查检验 | `/outpatient/exam` | `outpatient:exam` | `mdi:microscope` |
| 门诊管理 | 门诊病历 | `/outpatient/record` | `outpatient:record` | `mdi:file-document` |
| 住院管理 | 入院登记 | `/inpatient/admit` | `inpatient:admit` | `mdi:login` |
| 住院管理 | 床位管理 | `/inpatient/bed` | `inpatient:bed` | `mdi:bed` |
| 住院管理 | 医嘱管理 | `/inpatient/order` | `inpatient:order` | `mdi:clipboard-text` |
| 住院管理 | 出院管理 | `/inpatient/discharge` | `inpatient:discharge` | `mdi:logout` |
| 药房管理 | 药品目录 | `/pharmacy/drug` | `pharmacy:drug` | `mdi:pill` |
| 药房管理 | 入库管理 | `/pharmacy/inbound` | `pharmacy:inbound` | `mdi:arrow-collapse-down` |
| 药房管理 | 出库管理 | `/pharmacy/outbound` | `pharmacy:outbound` | `mdi:arrow-expand-up` |
| 药房管理 | 库存预警 | `/pharmacy/warning` | `pharmacy:warning` | `mdi:alert` |
| 收费管理 | 门诊收费 | `/billing/outpatient` | `billing:outpatient` | `mdi:cash` |
| 收费管理 | 住院收费 | `/billing/inpatient` | `billing:inpatient` | `mdi:cash-multiple` |
| 收费管理 | 发票管理 | `/billing/invoice` | `billing:invoice` | `mdi:receipt` |
| 病历管理 | 病历查询 | `/record/list` | `record:list` | `mdi:file-search` |
| 病历管理 | 病历模板 | `/record/template` | `record:template` | `mdi:file-settings` |
| 设置 | 科室管理 | `/setting/dept` | `setting:dept` | `mdi:office-building` |
| 设置 | 收费标准 | `/setting/fee` | `setting:fee` | `mdi:currency-cny` |
| 设置 | 字典管理 | `/setting/dict` | `setting:dict` | `mdi:book-open` |

### 默认权限角色

| 角色 | 说明 | 权限范围 |
|---|---|---|
| `super_admin` | 超级管理员 | 所有权限 |
| `doctor` | 医生 | 门诊/住院/病历 |
| `nurse` | 护士 | 住院/医嘱执行 |
| `pharmacist` | 药师 | 药房管理全部 |
| `registration_clerk` | 挂号员 | 挂号管理/收费 |
| `finance` | 财务 | 收费管理 |

### 默认功能特性

- 电子病历（结构化模板）
- 药品库存自动化（近效期/缺货预警）
- 医保接口对接（实时结算）
- 门诊/住院一体化收费
- 医疗统计报表（门急诊量、住院率、药品消耗）

---

## 14. 教育系统（行业垂直类）

### 默认菜单结构

| 一级菜单 | 二级菜单 | 路由 path | 权限码 | 图标 |
|---|---|---|---|---|
| Dashboard | 学校概览 | `/dashboard/analytics` | - | `mdi:chart-box-outline` |
| Dashboard | 工作台 | `/dashboard/workspace` | - | `mdi:view-dashboard` |
| 学生管理 | 学生列表 | `/student/list` | `student:list` | `mdi:account-school` |
| 学生管理 | 班级管理 | `/student/class` | `student:class` | `mdi:chair-school` |
| 学生管理 | 学籍管理 | `/student/enrollment` | `student:enrollment` | `mdi:card-account-details` |
| 学生管理 | 奖惩记录 | `/student/reward` | `student:reward` | `mdi:star` |
| 教师管理 | 教师列表 | `/teacher/list` | `teacher:list` | `mdi:account-tie` |
| 教师管理 | 教师考核 | `/teacher/evaluation` | `teacher:evaluation` | `mdi:clipboard-check` |
| 教师管理 | 教学计划 | `/teacher/plan` | `teacher:plan` | `mdi:book-open` |
| 课程管理 | 课程列表 | `/course/list` | `course:list` | `mdi:book` |
| 课程管理 | 课程分类 | `/course/category` | `course:category` | `mdi:shape` |
| 课程管理 | 教材管理 | `/course/material` | `course:material` | `mdi:book-open-variant` |
| 排课管理 | 课表管理 | `/schedule/list` | `schedule:list` | `mdi:calendar-month` |
| 排课管理 | 教室管理 | `/schedule/room` | `schedule:room` | `mdi:door` |
| 排课管理 | 调课管理 | `/schedule/adjust` | `schedule:adjust` | `mdi:swap-horizontal` |
| 成绩管理 | 成绩录入 | `/grade/entry` | `grade:entry` | `mdi:pen` |
| 成绩管理 | 成绩查询 | `/grade/list` | `grade:list` | `mdi:file-search` |
| 成绩管理 | 成绩分析 | `/grade/analysis` | `grade:analysis` | `mdi:chart-bar` |
| 招生管理 | 招生计划 | `/admission/plan` | `admission:plan` | `mdi:target` |
| 招生管理 | 报名管理 | `/admission/apply` | `admission:apply` | `mdi:clipboard-list` |
| 招生管理 | 录取管理 | `/admission/admit` | `admission:admit` | `mdi:check-circle` |
| 收费管理 | 学费管理 | `/fee/tuition` | `fee:tuition` | `mdi:cash` |
| 收费管理 | 杂费管理 | `/fee/misc` | `fee:misc` | `mdi:cash-multiple` |
| 收费管理 | 减免管理 | `/fee/discount` | `fee:discount` | `mdi:percent` |
| 设置 | 学年学期 | `/setting/term` | `setting:term` | `mdi:calendar` |
| 设置 | 系统配置 | `/setting/system` | `setting:system` | `mdi:cog` |

### 默认权限角色

| 角色 | 说明 | 权限范围 |
|---|---|---|
| `super_admin` | 超级管理员 | 所有权限 |
| `teacher` | 教师 | 课程/成绩（本人班级） |
| `class_master` | 班主任 | 学生/成绩/奖惩（本班） |
| `academic_affairs` | 教务员 | 排课/教师/课程管理 |
| `admission_officer` | 招生办 | 招生管理全部 |
| `finance` | 财务 | 收费管理 |

### 默认功能特性

- 自动排课算法（教师/教室/时间冲突检测）
- 成绩分段统计 + 排名
- 学生成长档案（成绩曲线 + 综合素质评价）
- 招生数据看板（报名进度 / 录取率）
- 家校互通（通知/作业/成绩推送）

---

## 15. 物业系统（行业垂直类）

### 默认菜单结构

| 一级菜单 | 二级菜单 | 路由 path | 权限码 | 图标 |
|---|---|---|---|---|
| Dashboard | 物业概览 | `/dashboard/analytics` | - | `mdi:chart-box-outline` |
| Dashboard | 工作台 | `/dashboard/workspace` | - | `mdi:view-dashboard` |
| 房产管理 | 楼盘管理 | `/property/estate` | `property:estate` | `mdi:city` |
| 房产管理 | 楼栋管理 | `/property/building` | `property:building` | `mdi:domain` |
| 房产管理 | 房屋管理 | `/property/unit` | `property:unit` | `mdi:home` |
| 房产管理 | 车位管理 | `/property/parking` | `property:parking` | `mdi:car` |
| 业主管理 | 业主列表 | `/owner/list` | `owner:list` | `mdi:account-group` |
| 业主管理 | 家庭成员 | `/owner/family` | `owner:family` | `mdi:account-multiple` |
| 业主管理 | 业主变更 | `/owner/transfer` | `owner:transfer` | `mdi:swap-horizontal` |
| 收费管理 | 物业费 | `/fee/property` | `fee:property` | `mdi:cash` |
| 收费管理 | 水电费 | `/fee/utility` | `fee:utility` | `mdi:water` |
| 收费管理 | 停车费 | `/fee/parking` | `fee:parking` | `mdi:car` |
| 收费管理 | 催缴管理 | `/fee/reminder` | `fee:reminder` | `mdi:bell` |
| 报修管理 | 报修工单 | `/repair/ticket` | `repair:ticket` | `mdi:wrench` |
| 报修管理 | 工单派单 | `/repair/dispatch` | `repair:dispatch` | `mdi:account-arrow-right` |
| 报修管理 | 维修评价 | `/repair/review` | `repair:review` | `mdi:star` |
| 巡检管理 | 巡检计划 | `/patrol/plan` | `patrol:plan` | `mdi:calendar-check` |
| 巡检管理 | 巡检记录 | `/patrol/record` | `patrol:record` | `mdi:clipboard-check` |
| 巡检管理 | 巡检路线 | `/patrol/route` | `patrol:route` | `mdi:map-marker-path` |
| 投诉建议 | 投诉列表 | `/complaint/list` | `complaint:list` | `mdi:message-alert` |
| 投诉建议 | 建议管理 | `/complaint/suggestion` | `complaint:suggestion` | `mdi:lightbulb` |
| 设备管理 | 设备台账 | `/device/list` | `device:list` | `mdi:server` |
| 设备管理 | 设备维保 | `/device/maintenance` | `device:maintenance` | `mdi:tools` |
| 设置 | 收费标准 | `/setting/fee` | `setting:fee` | `mdi:currency-cny` |
| 设置 | 公告管理 | `/setting/notice` | `setting:notice` | `mdi:bullhorn` |

### 默认权限角色

| 角色 | 说明 | 权限范围 |
|---|---|---|
| `super_admin` | 超级管理员 | 所有权限 |
| `property_manager` | 物业经理 | 房产/业主/收费/投诉 |
| `repairman` | 维修工 | 报修工单（本人的） |
| `security_guard` | 保安 | 巡检管理 |
| `finance` | 财务 | 收费管理 |

### 默认功能特性

- 房产树状结构（楼盘 → 楼栋 → 单元 → 房屋）
- 物业费自动计费 + 滞纳金
- 报修工单自动派单
- 设备维保计划 + 到期提醒
- 业主公告/投票/问卷调查

---

## 16. 物流 TMS（行业垂直类）

### 默认菜单结构

| 一级菜单 | 二级菜单 | 路由 path | 权限码 | 图标 |
|---|---|---|---|---|
| Dashboard | 物流概览 | `/dashboard/analytics` | - | `mdi:chart-box-outline` |
| Dashboard | 工作台 | `/dashboard/workspace` | - | `mdi:view-dashboard` |
| 运单管理 | 运单列表 | `/waybill/list` | `waybill:list` | `mdi:clipboard-list` |
| 运单管理 | 运单录入 | `/waybill/create` | `waybill:create` | `mdi:plus-circle` |
| 运单管理 | 运单跟踪 | `/waybill/tracking` | `waybill:tracking` | `mdi:map-marker-path` |
| 运单管理 | 异常运单 | `/waybill/exception` | `waybill:exception` | `mdi:alert-circle` |
| 路由规划 | 路由管理 | `/route/list` | `route:list` | `mdi:map` |
| 路由规划 | 中转管理 | `/route/transfer` | `route:transfer` | `mdi:swap-horizontal` |
| 路由规划 | 时效配置 | `/route/transit-time` | `route:transit-time` | `mdi:clock-outline` |
| 车辆管理 | 车辆列表 | `/vehicle/list` | `vehicle:list` | `mdi:truck` |
| 车辆管理 | 车辆维修 | `/vehicle/maintenance` | `vehicle:maintenance` | `mdi:tools` |
| 车辆管理 | 车辆保险 | `/vehicle/insurance` | `vehicle:insurance` | `mdi:shield` |
| 车辆管理 | 油耗管理 | `/vehicle/fuel` | `vehicle:fuel` | `mdi:gas-station` |
| 驾驶员管理 | 驾驶员列表 | `/driver/list` | `driver:list` | `mdi:account-tie` |
| 驾驶员管理 | 证件管理 | `/driver/license` | `driver:license` | `mdi:card-account-details` |
| 驾驶员管理 | 违章管理 | `/driver/violation` | `driver:violation` | `mdi:alert` |
| 签收管理 | 签收记录 | `/sign/list` | `sign:list` | `mdi:clipboard-check` |
| 签收管理 | 异常签收 | `/sign/exception` | `sign:exception` | `mdi:alert-circle` |
| 签收管理 | 电子签收 | `/sign/electronic` | `sign:electronic` | `mdi:draw` |
| 财务管理 | 运费结算 | `/finance/freight` | `finance:freight` | `mdi:cash` |
| 财务管理 | 代收货款 | `/finance/cod` | `finance:cod` | `mdi:cash-multiple` |
| 财务管理 | 成本核算 | `/finance/cost` | `finance:cost` | `mdi:calculator` |
| 报表中心 | 运营报表 | `/report/operation` | `report:operation` | `mdi:chart-bar` |
| 报表中心 | 时效报表 | `/report/transit-time` | `report:transit-time` | `mdi:chart-timeline` |
| 设置 | 运费模板 | `/setting/freight` | `setting:freight` | `mdi:file-cog` |
| 设置 | 网点管理 | `/setting/branch` | `setting:branch` | `mdi:domain` |

### 默认权限角色

| 角色 | 说明 | 权限范围 |
|---|---|---|
| `super_admin` | 超级管理员 | 所有权限 |
| `ops_manager` | 运营经理 | 运单/路由/签收 |
| `dispatcher` | 调度员 | 路由规划/车辆调度 |
| `driver` | 驾驶员 | 运单（本人的）/签收 |
| `finance` | 财务 | 运费结算/成本核算 |
| `branch_manager` | 网点经理 | 本网点运单/签收 |

### 默认功能特性

- 运单全程路由追踪（始发 → 中转 → 到达 → 签收）
- 智能路由规划（成本/时效最优）
- 车辆维保计划 + 保险到期提醒
- 电子签收（PDA/手机端）
- 运费自动计算 + 到付/月结合同

---

## 17. MES 制造执行系统（行业垂直类）

### 默认菜单结构

| 一级菜单 | 二级菜单 | 路由 path | 权限码 | 图标 |
|---|---|---|---|---|
| Dashboard | 生产看板 | `/dashboard/analytics` | - | `mdi:chart-box-outline` |
| Dashboard | 工作台 | `/dashboard/workspace` | - | `mdi:view-dashboard` |
| 工单管理 | 生产工单 | `/production/order` | `production:order` | `mdi:file-document` |
| 工单管理 | 工单排程 | `/production/schedule` | `production:schedule` | `mdi:calendar-clock` |
| 工单管理 | 工单报工 | `/production/report` | `production:report` | `mdi:clipboard-check` |
| 工单管理 | 工单拆分 | `/production/split` | `production:split` | `mdi:call-split` |
| 质量管理 | 来料检验 | `/quality/incoming` | `quality:incoming` | `mdi:package-variant` |
| 质量管理 | 过程检验 | `/quality/ipqc` | `quality:ipqc` | `mdi:progress-check` |
| 质量管理 | 成品检验 | `/quality/oqc` | `quality:oqc` | `mdi:check-circle` |
| 质量管理 | 不良品管理 | `/quality/defect` | `quality:defect` | `mdi:close-circle` |
| 质量管理 | 质量追溯 | `/quality/trace` | `quality:trace` | `mdi:timeline` |
| 设备管理 | 设备台账 | `/device/list` | `device:list` | `mdi:server` |
| 设备管理 | 设备点检 | `/device/check` | `device:check` | `mdi:clipboard-check` |
| 设备管理 | 设备维保 | `/device/maintenance` | `device:maintenance` | `mdi:tools` |
| 设备管理 | 设备报警 | `/device/alarm` | `device:alarm` | `mdi:alarm-light` |
| 工艺管理 | 工艺路线 | `/process/route` | `process:route` | `mdi:timeline` |
| 工艺管理 | 工艺参数 | `/process/parameter` | `process:parameter` | `mdi:tune` |
| 工艺管理 | BOM 管理 | `/process/bom` | `process:bom` | `mdi:code-tags` |
| 物料管理 | 物料清单 | `/material/list` | `material:list` | `mdi:package` |
| 物料管理 | 物料消耗 | `/material/consumption` | `material:consumption` | `mdi:chart-line` |
| 物料管理 | 物料追溯 | `/material/trace` | `material:trace` | `mdi:timeline` |
| 看板管理 | 生产看板 | `/kanban/production` | `kanban:production` | `mdi:monitor-dashboard` |
| 看板管理 | 质量看板 | `/kanban/quality` | `kanban:quality` | `mdi:monitor-eye` |
| 看板管理 | 设备看板 | `/kanban/device` | `kanban:device` | `mdi:monitor-server` |
| 报表中心 | 生产报表 | `/report/production` | `report:production` | `mdi:chart-bar` |
| 报表中心 | OEE 分析 | `/report/oee` | `report:oee` | `mdi:chart-donut` |
| 设置 | 工厂建模 | `/setting/factory` | `setting:factory` | `mdi:factory` |
| 设置 | 产线管理 | `/setting/line` | `setting:line` | `mdi:conveyor-belt` |

### 默认权限角色

| 角色 | 说明 | 权限范围 |
|---|---|---|
| `super_admin` | 超级管理员 | 所有权限 |
| `production_manager` | 生产主管 | 工单/排程/看板 |
| `operator` | 产线操作工 | 工单报工（本人的） |
| `qc_inspector` | 质检员 | 质量管理全部 |
| `maintenance_tech` | 设备维护员 | 设备维保/点检 |
| `process_engineer` | 工艺工程师 | 工艺管理/BOM |

### 默认功能特性

- 工单全生命周期（创建 → 排程 → 报工 → 完工）
- 生产过程防错（Andon 系统）
- 设备 OEE 自动计算（稼动率 × 性能 × 良品率）
- 质量追溯（正向/反向，批次级 → 单品级）
- 实时生产看板（大屏展示）

---

## 18. OA/办公系统（办公/协作类）

### 默认菜单结构

| 一级菜单 | 二级菜单 | 路由 path | 权限码 | 图标 |
|---|---|---|---|---|
| Dashboard | 办公概览 | `/dashboard/analytics` | - | `mdi:chart-box-outline` |
| Dashboard | 工作台 | `/dashboard/workspace` | - | `mdi:view-dashboard` |
| 审批管理 | 待办审批 | `/approval/pending` | `approval:pending` | `mdi:clock-outline` |
| 审批管理 | 我发起的 | `/approval/initiated` | `approval:initiated` | `mdi:file-document` |
| 审批管理 | 审批模板 | `/approval/template` | `approval:template` | `mdi:file-settings` |
| 审批管理 | 审批统计 | `/approval/statistics` | `approval:statistics` | `mdi:chart-bar` |
| 考勤管理 | 考勤打卡 | `/attendance/clock` | `attendance:clock` | `mdi:clock` |
| 考勤管理 | 考勤统计 | `/attendance/statistics` | `attendance:statistics` | `mdi:calendar-check` |
| 考勤管理 | 排班管理 | `/attendance/schedule` | `attendance:schedule` | `mdi:calendar-clock` |
| 考勤管理 | 请假管理 | `/attendance/leave` | `attendance:leave` | `mdi:briefcase-clock` |
| 考勤管理 | 加班管理 | `/attendance/overtime` | `attendance:overtime` | `mdi:clock-plus` |
| 公告管理 | 公告列表 | `/notice/list` | `notice:list` | `mdi:bullhorn` |
| 公告管理 | 公告发布 | `/notice/create` | `notice:create` | `mdi:bullhorn-outline` |
| 公告管理 | 公告分类 | `/notice/category` | `notice:category` | `mdi:shape` |
| 日程管理 | 我的日程 | `/calendar/my` | `calendar:my` | `mdi:calendar` |
| 日程管理 | 会议室管理 | `/calendar/room` | `calendar:room` | `mdi:door` |
| 日程管理 | 会议预约 | `/calendar/meeting` | `calendar:meeting` | `mdi:video` |
| 会议管理 | 会议列表 | `/meeting/list` | `meeting:list` | `mdi:video` |
| 会议管理 | 会议纪要 | `/meeting/minutes` | `meeting:minutes` | `mdi:file-document` |
| 文档管理 | 文档库 | `/document/list` | `document:list` | `mdi:folder` |
| 文档管理 | 文档分类 | `/document/category` | `document:category` | `mdi:folder-multiple` |
| 文档管理 | 共享文档 | `/document/shared` | `document:shared` | `mdi:folder-account` |
| 通讯录 | 组织架构 | `/contact/org` | `contact:org` | `mdi:organisation` |
| 通讯录 | 员工通讯录 | `/contact/employee` | `contact:employee` | `mdi:account-group` |
| 设置 | 流程配置 | `/setting/workflow` | `setting:workflow` | `mdi:file-cog` |
| 设置 | 表单设计 | `/setting/form` | `setting:form` | `mdi:form-select` |
| 设置 | 组织管理 | `/setting/org` | `setting:org` | `mdi:organisation` |

### 默认权限角色

| 角色 | 说明 | 权限范围 |
|---|---|---|
| `super_admin` | 超级管理员 | 所有权限 |
| `hr` | HR | 考勤/请假/加班/组织管理 |
| `department_head` | 部门主管 | 本部门审批/考勤 |
| `employee` | 普通员工 | 本人的审批/考勤/日程/文档 |
| `admin_assistant` | 行政 | 公告/会议/通讯录 |

### 默认功能特性

- 可视化流程审批（拖拽式流程设计器）
- 考勤规则灵活配置（固定/弹性/排班）
- 会议室自动冲突检测
- 在线文档协同编辑
- 移动端打卡（GPS / WiFi 打卡）

---

## 19. API 开放平台（平台/技术类）

### 默认菜单结构

| 一级菜单 | 二级菜单 | 路由 path | 权限码 | 图标 |
|---|---|---|---|---|
| Dashboard | 平台概览 | `/dashboard/analytics` | - | `mdi:chart-box-outline` |
| Dashboard | 工作台 | `/dashboard/workspace` | - | `mdi:view-dashboard` |
| 应用管理 | 应用列表 | `/app/list` | `app:list` | `mdi:apps` |
| 应用管理 | 应用审核 | `/app/review` | `app:review` | `mdi:apps-plus` |
| 应用管理 | 应用配置 | `/app/config` | `app:config` | `mdi:cog` |
| 应用管理 | 应用密钥 | `/app/secret` | `app:secret` | `mdi:key` |
| API 管理 | API 列表 | `/api/list` | `api:list` | `mdi:code-tags` |
| API 管理 | API 分组 | `/api/category` | `api:category` | `mdi:shape` |
| API 管理 | API 文档 | `/api/doc` | `api:doc` | `mdi:file-document` |
| API 管理 | API 版本 | `/api/version` | `api:version` | `mdi:source-branch` |
| 流量控制 | 限流策略 | `/traffic/limit` | `traffic:limit` | `mdi:traffic-light` |
| 流量控制 | 配额管理 | `/traffic/quota` | `traffic:quota` | `mdi:gauge` |
| 流量控制 | IP 白名单 | `/traffic/whitelist` | `traffic:whitelist` | `mdi:shield-check` |
| 认证管理 | 签名管理 | `/auth/signature` | `auth:signature` | `mdi:key-chain` |
| 认证管理 | OAuth 管理 | `/auth/oauth` | `auth:oauth` | `mdi:account-key` |
| 认证管理 | 回调管理 | `/auth/callback` | `auth:callback` | `mdi:webhook` |
| 调用统计 | 调用量统计 | `/statistics/calls` | `statistics:calls` | `mdi:chart-bar` |
| 调用统计 | 响应分析 | `/statistics/response` | `statistics:response` | `mdi:chart-timeline` |
| 调用统计 | 错误分析 | `/statistics/error` | `statistics:error` | `mdi:chart-areaspline` |
| 调用统计 | 应用排行 | `/statistics/ranking` | `statistics:ranking` | `mdi:trending-up` |
| 告警管理 | 告警规则 | `/alert/rule` | `alert:rule` | `mdi:bell-ring` |
| 告警管理 | 告警记录 | `/alert/history` | `alert:history` | `mdi:bell` |
| 日志管理 | 调用日志 | `/log/api` | `log:api` | `mdi:format-list-bulleted` |
| 日志管理 | 操作日志 | `/log/operation` | `log:operation` | `mdi:history` |
| 设置 | 平台配置 | `/setting/platform` | `setting:platform` | `mdi:cog` |
| 设置 | 公告管理 | `/setting/notice` | `setting:notice` | `mdi:bullhorn` |

### 默认权限角色

| 角色 | 说明 | 权限范围 |
|---|---|---|
| `super_admin` | 超级管理员 | 所有权限 |
| `api_manager` | API 产品经理 | API 管理/文档/版本 |
| `app_operator` | 应用运营 | 应用审核/调用统计 |
| `security_officer` | 安全专员 | 流量控制/认证管理/告警 |
| `developer` | 开发者 | API 文档（只读）/调用统计（本人） |

### 默认功能特性

- API 文档自动生成（OpenAPI/Swagger）
- 多认证方式（AK/SK、OAuth2.0、JWT）
- 分级限流（应用级/API 级/用户级）
- 调用链追踪 + 耗时分析
- 开发者自助门户（注册 → 申请 → 调试 → 上线）

---

## 实施指南

### 当用户选择系统类型后

1. 根据对应模板创建 `src/router/routes/modules/` 下的路由文件
2. 在 `src/views/` 下创建对应目录结构（可以先放占位页面）
3. 在 `src/locales/langs/zh-CN.ts` 中添加菜单文案
4. 在 `src/api/` 下创建对应的业务接口目录
5. 配置对应的权限码与角色
6. 在 Dashboard 中添加该类型默认的数据卡片（统计数、图表）

### 路由文件命名规范

```
src/router/routes/modules/
├── dashboard.ts         # Dashboard 路由
├── product.ts           # 电商/商品管理
├── order.ts             # 电商/订单管理
├── store.ts             # O2O/门店管理
├── booking.ts           # O2O/预约管理
├── dish.ts              # 餐饮/菜品管理
├── room.ts              # PMS/房态管理
├── reservation.ts       # PMS/预订管理
├── merchant.ts          # 支付/商户管理
├── transaction.ts       # 支付/交易管理
├── purchase.ts          # ERP/采购管理
├── sales.ts             # ERP 销售 / CRM 销售
├── customer.ts          # CRM/客户管理
├── content.ts           # CMS/内容管理
├── tenant.ts            # SaaS/租户管理
├── student.ts           # 教育/学生管理
├── course.ts            # 教育/课程管理
├── property.ts          # 物业/房产管理
├── waybill.ts           # 物流/运单管理
├── production.ts        # MES/生产管理 / ERP/生产管理
├── quality.ts           # MES/质量管理
├── system.ts            # 通用/系统管理
├── monitor.ts           # 通用/系统监控
├── setting.ts           # 系统设置
└── ...                  # 按业务模块继续扩展
```

### 示例：生成通用后台用户管理的路由文件

```ts
// src/router/routes/modules/system.ts
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
      authority: ['super_admin', 'system_manager'],
      keepAlive: true,
    },
  },
  {
    name: 'SystemRole',
    path: '/system/role',
    component: () => import('#/views/system/role/index.vue'),
    meta: {
      title: $t('page.system.role.title'),
      icon: 'mdi:account-key',
      authority: ['super_admin', 'system_manager'],
      keepAlive: true,
    },
  },
  // ... 更多
];

export default routes;
```