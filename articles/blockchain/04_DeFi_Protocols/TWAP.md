---
title: "TWAP"
aliases: ["TWAP", "TWAP 笔记"]
tags: [区块链/DeFi]
up: "[[_blockchain_moc]]"
status: active
maturity: budding
---

# TWAP (Time-Weighted Average Price)

## What

- 在一段时间区间内，对不同时间点的价格进行加权平均
- 不考虑成交量，仅以时间为权重，得到平滑后的价格
- 常用于预言机和 DeFi 协议中的价格计算

## Why

- 防止短时间内的价格操纵（如闪电贷攻击）
- 提供更稳定的参考价格，降低单块价格波动影响
- 适合链上使用，计算成本较低

## Who

- 链上预言机（如 Uniswap v2/v3、Chainlink）
- DeFi 协议开发者（借贷、AMM、Launchpad）
- 需要稳定价格指标的量化策略开发者

## When

- 清算、借贷、质押等场景需要参考长期价格时
- DAO 治理或参数调整需要一个平滑价格时
- NFT 拍卖、IDO 等希望避免单点操纵的场景

## How

- 公式：TWAP = (累计价格差) ÷ (时间差)
- 通过在智能合约中记录价格累积值与时间戳
- 在需要时取当前累积值减去历史累积值，再除以时间跨度
- 依赖区块时间，理论上仍可能受矿工微调时间戳影响
