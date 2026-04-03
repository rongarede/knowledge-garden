---
title: "DAO治理"
aliases: ["DAO治理", "DAO治理 笔记"]
tags: [区块链/DeFi]
up: "[[_blockchain_moc]]"
status: active
maturity: budding
---

# DAO 治理机制对比：Compound vs Aave vs Uniswap

## 概述

三个协议都是 DeFi 核心项目，治理系统决定了其协议参数、资产新增、升级路径等关键操作。虽都宣称为 DAO，但其治理机制在实现层面存在明显差异，尤其体现在链上程度、激励结构、安全模型上。

## 治理代币

- Compound：COMP
- Aave：AAVE / stkAAVE（质押版）
- Uniswap：UNI

## 投票权计算方式

- Compound：COMP 快照机制，支持委托，全链上计算（GovernorBravo 内 getPriorVotes）
- Aave：Snapshot 快照，支持质押 stkAAVE 与跨链投票（支持 L2）
- Uniswap：Snapshot 快照，支持委托，但无质押系统

## 提案门槛与流程

### Compound

- 提案门槛：≥ 65,000 COMP（含委托）
- 合约：GovernorBravo
- 投票方式：On-chain，需 gas
- 执行：经 Timelock 延迟 2 天后由链上执行

### Aave

- 提案门槛：≥ 0.5% stkAAVE 投票权（大约 8万 AAVE）
- 合约：Snapshot + 多签执行器 + Aave Governance V2
- 投票方式：Snapshot 投票（无需 gas）
- 执行：投票通过后由执行人（多签）执行链上操作

### Uniswap

- 提案门槛：≥ 2.5M UNI（约数千万美元）
- 合约：Snapshot + Timelock + GovernorAlpha
- 投票方式：Snapshot（无激励）
- 执行：投票通过后进入 Timelock 延迟执行

## 激励机制与治理参与度

### Compound

- 没有原生投票激励
- 仅少数大户或基金参与治理
- 缺乏治理 "bribe" 机制

### Aave

- 有 Safety Module（stkAAVE），质押获得收益与治理权
- 激励更强，风险和权利绑定
- 提案可获得激励（如 DAO treasury 分发）

### Uniswap

- 无质押、无激励
- 治理空转，实际控制权偏向基金会/核心团队

## 安全模型

### Compound

- Timelock：延迟执行以防止提案攻击
- Guardian（历史上由 Compound Labs 控制）：可否决恶意提案

### Aave

- Safety Module 提供协议安全缓冲，staking 被 slash 时用于清偿损失
- Execution Layer 中有多签控制

### Uniswap

- 也使用 Timelock 延迟执行
- 没有明确的质押安全模块

## 执行路径对比

- Compound：propose() → vote() → queue() → execute() → 合约执行
- Aave：forum 讨论 → snapshot → on-chain 执行人（Aave DAO Executor）提交并执行
- Uniswap：propose → snapshot → timelock queue → execute（治理影响极小）

## 去中心化程度评估

### Compound

- 全链上投票+执行，较为去中心化
- 提案门槛高，普通用户无法发起

### Aave

- 提案门槛相对合理
- 执行环节集中于多签，中心化风险高

### Uniswap

- 提案门槛极高
- Snapshot + 没有实际产品治理影响，治理形同虚设

## 技术组件一览

- Compound：GovernorBravo, Timelock, Comp token
- Aave：Snapshot, Aave Governance V2, Safety Module, stkAAVE
- Uniswap：GovernorAlpha, Snapshot, UNI token, Timelock

## 小结

- Compound 以"治理即协议"理念设计，追求纯粹链上治理，但激励设计较弱。
- Aave 将治理、安全和激励三者整合，设计复杂但较有效。
- Uniswap 治理流于形式，对产品路径实际控制权微弱，治理 Token 更像标志性象征。
