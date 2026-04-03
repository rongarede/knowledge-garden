---
title: "MasterChef"
aliases: ["MasterChef", "MasterChef 笔记"]
tags: [区块链/DeFi]
up: "[[_blockchain_moc]]"
status: active
maturity: budding
---

# MasterChef

tags: DeFi, Staking, RewardDistribution

## 4W1H

- What：一种按"质押数量 × 持续区块数"线性分配奖励的合约范式，源自 SushiSwap，用 `accRewardPerShare` / `rewardDebt` 结算用户应得奖励。
- Why：公平且高效地把每区块固定（或可调）的奖励分发给质押者，避免逐块逐用户发放的高成本。
- Who：质押者（Stake/Unstake/Harvest）；管理员/DAO（调参、增池、暂停）；奖励代币合约（被授权铸造/转账）。
- When：每次用户交互（stake/unstake/harvest）前先 `updatePool()`；治理事件（改奖励、增池）通过 Timelock 定期执行；奖励随区块线性累计、在交互瞬间结算。

### How

全局状态：`rewardPerBlock`, `lastRewardBlock`, `accRewardPerShare`, `totalStaked`

更新池：

```
reward = (block.number - lastRewardBlock) * rewardPerBlock
accRewardPerShare += reward * 1e12 / totalStaked
lastRewardBlock = block.number
```

- 用户结算：`pending = amount * accRewardPerShare / 1e12 - rewardDebt`
- 更新用户：`rewardDebt = amount * accRewardPerShare / 1e12`
- 安全/运维：ReentrancyGuard、SafeERC20、事件日志、emergencyWithdraw、参数权限/暂停

## 质疑点 & 风险

- 无限通胀？需总量上限或减半曲线
- `block.number` 可被微操纵；是否换 `timestamp`/预言机
- 闪电贷同块套利？考虑锁定期或退出费
- 单池集中：后续需多池/多奖励抽象

## 扩展/替代

- MasterChefV2/V3、MiniChef（拆 Rewarder、多链轻量）
- Curve Gauge / veToken、周期快照 + Merkle 空投等替代分配机制
