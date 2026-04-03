---
title: "如何寻找Uniswap交易对"
aliases: ["如何寻找Uniswap交易对", "如何寻找Uniswap交易对 笔记"]
tags: [区块链/DeFi]
up: "[[_blockchain_moc]]"
status: active
maturity: budding
---

# 如何找到 Uniswap 的交易对 (pair)

## 方法 1：链上 Factory 查询

- 调用 `UniswapV2Factory.getPair(tokenA, tokenB)`
- 返回交易对地址，0x0 表示不存在

## 方法 2：区块链浏览器

- 在 Etherscan 搜索 Factory 地址
- 使用 Read Contract 面板调用 getPair

## 方法 3：The Graph / Subgraph

- 查询 https://thegraph.com/hosted-service/subgraph/uniswap/uniswap-v2
- 用 GraphQL 获取热门交易对

## 方法 4：SDK / viem.js 查询

- 使用 viem.js 调用 getPair
- 适合在应用中动态获取

## 前瞻

- 多链 L2/L3 上需要聚合查询
- 未来可以通过 AI 自动筛选高流动性和安全池
