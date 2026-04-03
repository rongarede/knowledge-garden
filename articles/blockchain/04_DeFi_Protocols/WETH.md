---
title: "WETH"
aliases: ["WETH", "WETH 笔记"]
tags: [区块链/DeFi]
up: "[[_blockchain_moc]]"
status: active
maturity: budding
---

# WETH (Wrapped Ether)

## What（是什么）

- WETH 是将原生 ETH 封装为符合 [[ERC-20 同质化代币标准]] 的代币，使其能在 DeFi 协议中像普通代币一样使用。
- WETH 是 1:1 锁定 ETH 的 ERC-20 Token，用户可以随时将 ETH 转换为 WETH，反之亦然。

## Why（为什么需要）

- 原生 ETH 并不符合 ERC-20 标准，不能直接用于需要 ERC-20 接口的智能合约。
- 许多 DeFi 协议（如 Uniswap、Aave）使用统一的 ERC-20 接口以简化合约逻辑。
- 使用 WETH 可增强互操作性、降低开发复杂度。

## Who（谁使用）

- DeFi 用户在去中心化交易所（DEX）或借贷平台进行 ETH 的交易或质押时。
- 智能合约开发者需处理 ETH 与其他 ERC-20 Token 的交互时。
- 流动性提供者在提供交易对如 WETH/DAI 时。

## When（何时使用）

- 参与需要 ERC-20 代币的合约时（如 Uniswap、Balancer）。
- 在 DApp 中统一代币处理方式（将 ETH 与 ERC-20 Token 统一处理）。
- 在进行自动化交易策略或资产组合管理时需要。

## How（如何实现）

- 用户通过调用 WETH 合约的 `deposit()` 函数发送 ETH，获取等量的 WETH。
- 用户通过调用 `withdraw()` 函数销毁 WETH 并赎回 ETH。

核心接口包括：

- `function deposit() public payable` —— 存入 ETH，获得 WETH。
- `function withdraw(uint wad) public` —— 提出 WETH，赎回 ETH。
