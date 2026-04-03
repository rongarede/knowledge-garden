---
title: "Solidity 编程规范：CEI 模式（Check → Effects → Interactions）【4W1H】"
aliases: ["Solidity 编程规范：CEI 模式（Check → Effects → Interactions）【4W1H】", "CEI模式", "Solidity 编程规范：CEI 模式（Check → Effects → Interactions）【4W1H】笔记"]
tags: ["区块链/安全"]
up: "[[_blockchain_moc]]"
status: active
maturity: budding
---

# Solidity 编程规范：CEI 模式（Check → Effects → Interactions）【4W1H】

## What（它是什么）

CEI 是 Solidity 智能合约中的一种**推荐代码结构模式**，全称为：
- Check（检查）
- Effects（状态更新）
- Interactions（外部调用）

它规定编写函数时，应首先执行安全检查（如 require）、其次修改本地状态变量，最后才调用外部合约或转账。目的在于确保在进行外部交互前，合约内部状态已处于**一致、确定、不可被滥用的状态**。

## Why（为什么需要）

- 为了防止严重的安全漏洞，尤其是**重入攻击（Reentrancy）**。
- 如果先执行外部调用，再修改内部状态，攻击者可通过回调再次调用函数，在状态还未更新前**重复执行逻辑**，造成资金盗窃或逻辑混乱。
- CEI 模式提供一个简单而有效的防线，即使没有使用 ReentrancyGuard 也能显著提升安全性。
- 也提高了合约的**可读性、可预测性和维护性**。

## When（什么时候使用）

在所有**涉及外部合约调用或 ETH 转账的函数中**都应使用 CEI 模式。

特别适用于以下函数：
- `withdraw()`, `claimReward()`, `requestTokens()`, `transferToVault()` 等
- 也适用于任何需要调用 `call`, `transfer`, `send`, 或 `token.transfer()` 的场景。

## Where（在哪些场景使用）

适用于：
- [[代币水龙头]]（Faucet）合约中的 `requestTokens()`
- 金库提取合约 `withdraw()`
- GameFi 中领取奖励 `claimReward()`
- DAO 分红派发 `distributeDividends()`
- 所有需要与用户地址或外部合约交互的场景
- 也适用于多签钱包、DeFi 协议、NFT mint 合约等。

## How（如何实现）

编写函数时遵循以下结构：

```solidity
function withdraw(uint256 amount) public {
    require(balances[msg.sender] >= amount, "Not enough balance"); // Check
    balances[msg.sender] -= amount;                                // Effects
    (bool success, ) = msg.sender.call{value: amount}("");         // Interactions
    require(success, "Transfer failed");
}
```

避免如下顺序错误（先外部调用，再状态更新）：

```solidity
(bool success, ) = msg.sender.call{value: amount}("");  // Interactions 在前
require(success);
balances[msg.sender] -= amount;                         // Effects 太晚
```

搭配使用：
- `ReentrancyGuard`（[[OpenZeppelin库]]）
- `nonReentrant` 修饰器
- `checks-effects-interactions` 是审计重点项之一
