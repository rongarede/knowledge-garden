---
title: "Coumpound 协议深度学习"
aliases: ["Coumpound 协议深度学习", "Coumpound协议深度学习", "Coumpound 协议深度学习 笔记"]
tags: [区块链/DeFi]
up: "[[_blockchain_moc]]"
status: active
maturity: budding
---

# [[Compound 协议深度学习 ToDo（细分版）]]

## 模块 1｜协议总览与架构

- DONE 阅读 Compound v2 白皮书 & v3 文档
- DONE 归纳核心组件：cToken、Comptroller、InterestRateModel、PriceOracle
- DONE 理解会计恒等式：`TotalCash + TotalBorrows - TotalReserves = TotalSupply`
- TODO 下载 Compound v3 源码，建立 Foundry 环境
- TODO 生成合约调用图（Slither / Graphviz）
- TODO mainnet fork 模拟一次 supply → borrow → repay → withdraw
- TODO 记录关键状态变量变化：cash、borrows、reserves、exchangeRate
- TODO 绘制资金流图（用户→cToken→底层资产）
- TODO 输出笔记：《Compound 协议架构与资金流》

## 模块 2｜cToken 合约

- TODO 理解 cToken 的 ERC20 包装逻辑与 exchangeRate
- TODO 梳理 mint/redeem、borrow/repay、liquidate 调用路径
- TODO 标记状态变量更新相关函数
- TODO 分析 `exchangeRateStored` 与 `exchangeRateCurrent` 区别
- TODO fork 模式下 mint & redeem，验证 exchangeRate 单调递增
- TODO 计算 APY 与链上值对比
- TODO 绘制 exchangeRate–时间曲线
- TODO 输出笔记：《cToken 机制与 exchangeRate 计算》

## 模块 3｜利率模型

- TODO 理解 UtilizationRate、BorrowRate、SupplyRate 公式
- TODO 对比 WhitePaperInterestRateModel 与 JumpRateModel
- TODO 分析利率计算入口函数调用链
- TODO fork 模式下构造不同利用率（0%、50%、100%），获取利率
- TODO 绘制 APY–利用率曲线
- TODO 输出笔记：《Compound 利率模型对比与验证》

## 模块 4｜Comptroller 与风险参数

- TODO 理解市场列表、抵押因子、清算阈值、closeFactor、liquidationIncentive
- TODO 梳理 `enterMarkets` / `exitMarket` / `getAccountLiquidity`
- TODO 定位清算条件判断逻辑（HF < 1）
- TODO fork 模式下模拟 HF 降到 1 以下，触发清算
- TODO 绘制 HF–清算触发关系图
- TODO 输出笔记：《Comptroller 风险参数与清算条件》

## 模块 5｜清算机制

- TODO 梳理清算公式（repayAmount、collateralSeized）
- TODO 定位 `liquidateBorrow` 流程及事件
- TODO fork 模式下一次完整清算（自铸小仓位）
- TODO 断言债务减少≈扣抵押×价×(1-折价)±ε；清算人收益≥0
- TODO 绘制清算收益–折价参数曲线
- TODO 输出笔记：《Compound 清算机制实验报告》

## 模块 6｜会计不变式

- TODO 理解会计守恒与非负性原则
- TODO 定位所有修改现金/借款/储备的函数
- TODO 写 6 条 invariants，运行 fuzz 测试
- TODO 记录不变式触发率（假红、真红）
- TODO 输出笔记：《Compound 会计不变式验证》

## 模块 7｜预言机与价格源

- TODO 理解 Compound 价格预言机结构
- TODO 对比 TWAP、Chainlink、Uniswap V3 TWAP
- TODO 定位价格获取接口与缓存逻辑
- TODO fork 模式下篡改预言机价格，观察清算触发变化
- TODO 绘制价格变化–清算触发对比图
- TODO 输出笔记：《Compound 预言机机制与风险分析》

## 模块 8｜数据可视化与监控

- TODO 理解 The Graph 子图结构
- TODO 确定所需实体（Market、Account、Borrow、Liquidation）
- TODO 部署最小版 Compound 子图
- TODO 统计市场利用率变化、清算分布
- TODO 输出笔记：《Compound 数据可视化与指标监控》

## 模块 9｜治理与储备管理

- TODO 阅读 GovernorAlpha/GovernorBravo 合约结构
- TODO 梳理 Proposal → Voting → Queue → Execute 流程
- TODO 理解 Timelock 合约及执行延迟机制
- TODO 分析储备管理函数 `addReserves` 与 `reduceReserves` 权限控制
- TODO 在 fork 模式下模拟 addReserves 操作，观察 TotalReserves 变化
- TODO 在 fork 模式下模拟 reduceReserves 操作，验证权限检查
- TODO 绘制治理流程图与储备变动流程图
- TODO 输出笔记：《Compound 治理机制与储备管理分析》
