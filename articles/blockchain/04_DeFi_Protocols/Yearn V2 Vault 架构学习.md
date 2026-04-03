---
title: Yearn V2 Vault 架构学习
aliases: [Yearn V2, Yearn Vault, yearn-v2]
tags: [区块链/DeFi, 区块链/Vault]
up: "[[_defi_protocols_moc]]"
status: active
maturity: budding
---

# Yearn V2 Vault 架构学习

## 三层架构

| 层 | 合约 | 职责 |
|----|------|------|
| Vault | `Vault.sol` | 前台，用户存取入口 |
| Controller | `Controller.sol` | 路由合约，控制 Strategy 的选择，路由不同的投资组合 |
| Strategy | `StrategyDAICompoundBasic.sol` | 具体的投资策略，可更换 |

设计原则：
- **开闭原则**：Strategy 可更换，无需修改 Vault 和 Controller 代码
- **风险隔离**：某个 Strategy 出问题不影响其他合约



## 资金流向

存钱：用户 → Vault → Controller → Strategy → Compound（换 cDAI）

取钱：Compound → Strategy → Controller → Vault → 用户



## 复利机制（harvest）

1. 从 Compound 领取 COMP 奖励
2. 通过 Uniswap 将 COMP 卖成 DAI（路径：COMP → WETH → DAI）
3. 扣 5% 绩效费转到团队金库（rewards 地址）
4. 剩余 DAI 再存入 Compound，继续赚利息（复利）



## 份额定价

份额单价 = 总资产 / 总份额

其中总资产 = Vault 闲置资金 + Strategy 在 Compound 中的资金（不仅是存款）

harvest 复利使总资产增长 → 份额单价上升 → 后来者同样的钱拿到更少份额，早期存入者享受增值收益



## 流动性储备

强制保留约 5% 的资金在 Vault 中（minFloat = 9500 / maxFloat = 10000 → 95% 投资，5% 留存），这笔钱不存入 Compound，用于应对日常存取，避免频繁调用 Compound 合约



## 手续费

| 类型 | 比例 | 触发时机 | 收取方 |
|------|------|----------|--------|
| 取款手续费 | 0.5%（50/10000） | 用户取款时 | rewards 地址 |
| 绩效费 | 5%（500/10000） | harvest 复利时 | rewards 地址 |



## 安全知识点

### approve front-running 漏洞

ERC-20 的 `approve` 存在抢跑风险：Alice 将授权从 100 改为 50 时，Bob 可以在交易确认前抢跑花掉旧的 100，新授权生效后再花 50，总共花 150。

防御方式：先 approve 0 归零，再 approve 新金额，防止残留授权叠加。

```solidity
IERC20(want).approve(cDAI, 0);       // 先归零
IERC20(want).approve(cDAI, _want);   // 再授权新金额
```

### withdraw 的 shares 未赋值 bug

Vault.sol 的 `withdraw` 函数中，`shares` 在第 74 行被用于扣减授权额度，但直到第 80 行才被赋值。此时 `shares = 0`，导致授权额度没有被扣减，被授权方可以无限次取款。

修复方式：将 `shares = previewWithdraw(amount)` 移到授权检查之前。

## 关联笔记

- [[ERC-4626 金库合约标准]]
- [[Coumpound 协议深度学习]]
