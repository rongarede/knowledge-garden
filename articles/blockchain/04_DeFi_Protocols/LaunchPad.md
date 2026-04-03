---
title: "LaunchPad"
aliases: ["LaunchPad", "LaunchPad 笔记"]
tags: [区块链/DeFi]
up: "[[_blockchain_moc]]"
status: active
maturity: budding
---

# Launchpad 概览

**定义**：Launchpad 是一类帮助加密项目完成公开发行 / 募资 / 初期流动性注入的一站式平台，可托管白名单、额度分配、LP 锁仓等流程。

## 目的（Why）

- 降低项目方技术与合规门槛
- 汇聚早期投资者流量、提升曝光
- 通过标准化合约降低 Rug 与漏洞风险
- 自动注入并锁定流动性，缓冲二级市场波动

## 参与者（Who）

- 项目方 / 代币发行者
- 早期投资者 / 社区用户
- 平台运营方

## 出现与适用时机（When）

2019–2020 DeFi 热潮后，IDO 取代 ICO；适用于公链生态成熟且 DEX 深度充足的网络。

## 部署位置（Where）

智能合约层（EVM、Solana…），Web 前端 Dashboard，社群渠道（Discord / TG / X）。

## 工作流程（How）

1. 项目提交 → 审核 / 治理投票
2. 创建发行池（目标金额、价格、时间）
3. 用户认购（质押/抽签）
4. 结束后资金自动分账并注入 LP
5. 代币领取 / 线性解锁并在 DEX 交易

## 主流 Launchpad 分类

### 交易所型（CEX Launchpad）

- Binance Launchpad – 流动性与募资规模最大
- KuCoin Spotlight
- OKX Jumpstart / Gate Startup / Bybit Launchpad

### 去中心化 IDO Launchpad

- DAO Maker（多链，Social Mining）
- Polkastarter（跨链 IDO）
- Seedify（BNB 链，GameFi 专注）
- BSCPad / BullPerks / TrustPad（BNB 链）
- Red Kite / Bounce / ScaleSwap / Ignition（以太坊系）

### NFT Launchpad

- Magic Eden Launchpad（Solana & 多链）
- MagicMoca

### 合规早期轮

- CoinList – 抽签、KYC、较长解锁

### 对比指标

- 历史 ROI / 募资额
- 锁仓与解锁规则
- 参与门槛（质押、KYC、地域限制）

## Pump.fun —— 超轻量 Meme Launchpad

**定位**：Solana 的零代码迷因币生成器，1 分钟创建代币并挂载递增曲线池。

**机制**：一次性铸出全部供给；曲线售卖；市值≈9 万 USD 可"毕业"迁移至 Raydium。

**与传统 Launchpad 的主要差别**：

- 无项目审查 / KYC → 风险更高
- 发行即交易，无预售、无白名单
- 平台盈利模式：每笔交易 1% 手续费 + 毕业费 1.5 SOL

**风险**：软 Rug、骗局代币、价格剧烈波动。

**一句话总结**：Pump.fun 属于"超轻量、高风险、高波动"的 Meme Launchpad，与 Binance Launchpad 等审查型平台定位、目标用户完全不同。

## 常见攻击与防护

- 闪电贷操纵 → 采用 TWAP 价格或滑点上限
- 提前解锁 / 拔池 → 锁 LP + 多签/时间锁
- 预言机失真 → 多源预言机 + 延迟缓冲
- 重入 → nonReentrant 修饰

## 后续笔记

- [[/docs/ARCHITECTURE.md]] – 详细模块设计
- [[/test/MemeFactory.t.sol]] – Foundry 测试脚本
- [[/script/Deploy.s.sol]] – 部署脚本

## TODO

- 评估 V3 集中流动性适配
- 添加自动批量 LP 逻辑
- 集成 Chainlink Automation 做定时操作
