---
title: EIP-1559 以太坊Gas机制
aliases: [EIP-1559 以太坊Gas机制, EIP-1559]
tags: [区块链/标准]
up: "[[_blockchain_moc]]"
status: active
maturity: budding
---

# EIP-1559 以太坊Gas机制

EIP-1559（Ethereum Improvement Proposal 1559）是以太坊在 2021 年 8 月"[[EIP-1559 与伦敦硬分叉]]"中引入的交易手续费机制改革提案。它引入了 Base Fee（基础费）+ Priority Fee（小费）+ ETH 销毁机制，取代传统的 gasPrice 拍卖机制。当前已成为以太坊主网和多数 Layer2 的默认手续费结构。

## Why（为什么重要）

传统拍卖模式 gas 价格不可预测、用户体验差、矿工有动机操纵交易池。EIP-1559 改善用户体验、增强手续费可预测性、降低前置攻击风险，并引入销毁机制实现 ETH 通缩潜力。

## How（如何实现）

### 引入交易字段

- `maxFeePerGas`：用户设定的最高支付价格
- `maxPriorityFeePerGas`：给验证者的小费

### Base Fee 自动调整

根据区块拥堵程度变化：

- 拥堵 → base fee 上升
- 空闲 → base fee 下降

Base Fee 被销毁，不计入验证者收入，只保留小费部分。

### 核心机制

- **Base Fee**：协议自动设定，随区块拥堵度浮动；每个区块只有一个，所有用户共同承担
- **Priority Fee（Tip）**：用户自愿支付，激励矿工/验证者优先打包
- **Max Fee**：用户愿意支付的总上限，保护用户不被网络高波动"多收费"
- **ETH 销毁机制**：Base Fee 不给矿工，而是直接销毁，从而形成通缩机制
- **动态目标区块大小**：目标填充度为 50%，允许区块大小在 50%~100% 动态调整

### 交易有效 gas 费用计算

```
effectiveFee = baseFee + priorityFee
totalCost = min(maxFeePerGas, baseFee + priorityFee)
```

## How much（效果与反思）

- 提升交易预测性，优化用户体验
- 累计销毁超 4M ETH，具备通缩作用
- 减少手续费浪费
- 仍需进一步解决 MEV 问题
- Layer2 上的 gas 模型需做适配性扩展

## 参考链接

- [EIP-1559 官方文档](https://eips.ethereum.org/EIPS/eip-1559)
- [实时 ETH 销毁数据（Ultrasound.money）](https://ultrasound.money)
