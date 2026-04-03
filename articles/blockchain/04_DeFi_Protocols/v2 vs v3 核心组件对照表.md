---
title: "v2 vs v3 核心组件对照表"
aliases: ["v2 vs v3 核心组件对照表", "v2vsv3核心组件对照表", "v2 vs v3 核心组件对照表 笔记"]
tags: [区块链/DeFi]
up: "[[_blockchain_moc]]"
status: active
maturity: budding
---

# Compound｜V2 ↔ V3 核心组件对照

## 快速结论

- V2 → 模块化（多合约、多市场）
- V3 → 一体化（单合约单市场，核心内嵌到 Comet）
- cToken / Comptroller / InterestRateModel 在 V3 中被合并或移除
- 价格读取入口移入 Comet

## 对照明细

### 用户资产映射 & 代币化

- V2：cToken（每资产一个，ERC-20；存款映射、利息累积、赎回）
- V3：无独立代币化组件（抵押仅内部记账，不生息）
- 变化：取消多 cToken 市场 → 单市场 + 内部账户；抵押不生息
- 状态影响：exchangeRate 语义弱化/移除；只对 base 计息

### 借贷与资金流核心

- V2：cToken 内部资金池 + 与 Comptroller 协作
- V3：Comet（单一基础借款资产市场）
- 变化：借贷、计息、风控、清算集中到 Comet

### 风险控制（风控参数/健康度）

- V2：Comptroller（Collateral Factor、清算阈值等）
- V3：Comet 内置风险参数 + Collateral Registry
- 变化：风控从独立合约变为内嵌；按市场（Comet 实例）参数化

### 利率模型

- V2：InterestRateModel 独立合约（每市场一份）
- V3：Comet 内置 base 利率曲线（利用率驱动）
- 变化：外部 IRM → 内置；仅对基础借款资产生效

### 价格预言机

- V2：PriceOracle（由 Comptroller 统一查询）
- V3：Comet 直接读取外部价格源（Chainlink / Uni TWAP）
- 变化：价格入口移入 Comet；可治理切换实现

### 储备与费用管理

- V2：cToken 内 reserves（协议费用/坏账缓冲）
- V3：Comet 内 reserves 模块
- 变化：职责保留；结算路径更直接（与清算/坏账同仓）

### 清算逻辑

- V2：Comptroller + cToken 协作（liquidateBorrow）
- V3：Comet 内置清算引擎（absorb / buyCollateral）
- 变化：参数（折价/罚金）与流程统一在 Comet

### 市场结构

- V2：多市场（每资产一个 cToken 市场）
- V3：单市场（单一 base + 多种抵押品）
- 变化：结构简化；隔离度依赖参数化抵押与上限

### 治理与升级

- V2：Governor + Timelock（多市场多目标）
- V3：相同框架；针对单个 Comet 市场调参/升级
- 变化：管理粒度从多合约 → 按市场实例

### 激励分发

- V2：Comptroller 负责 COMP 分发
- V3：可选 Rewards Router 发放
- 变化：激励逻辑从核心拆出为独立模块

## 记忆卡片（速记）

- V3 = Comet 一体化
- cToken / Comptroller / IRM 内嵌或移除
- 单 base、生息只在 base
- 价格入口在 Comet；清算/储备/计息同仓

## 关联

- 架构图：[[Compound V3（Comet）架构总览]]
- 深入方向：利率路径 / 清算路径 / 关键状态变量（borrowIndex, baseBorrowScaled, collateral 余额与 CF/LF）
