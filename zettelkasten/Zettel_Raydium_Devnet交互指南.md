---
title: "Raydium Devnet 交互指南"
date: 2026-01-14
tags:
  - blockchain
  - solana
  - raydium
  - devnet
up: "[[200_Areas/Area_区块链/_blockchain_moc]]"
status: evergreen
uid: 20260114033500
related:
  - "[[100_Projects/Project_ipflow/CALL_FLOW/01-architecture]]"
source: "https://docs.raydium.io/raydium/protocol/developers/addresses"
maturity: evergreen
---

# Raydium Devnet 交互指南

> [!abstract] 核心观点
> 仅需提供 CPMM 池子地址，通过 `@raydium-io/raydium-sdk-v2` 的 `getRpcPoolInfo` 即可自动化解析并获取该池子所有 Swap 交互所需的详细信息（Mint、Vault、价格、费率等）。

## 笔记内容

### 1. 核心程序地址 (Program IDs)
Raydium 在 Devnet 上的 Program ID 与主网不一致，开发时必须切换：
- **CPMM (Constant Product)**: `DRaycpLY18LhpbydsBWbVJtxpNv9oXPgjRSfpF2bWpYb`
- **Legacy AMM v4**: `DRaya7Kj3aMWQSy19kSjvmuwq9docCHofyP9kanQGaav`
- **CLMM (Concentrated Liquidity)**: `DRayAUgENGQBKVaX8owNhgzkEDyoHTGVEGHVJT1E9pfH`

### 2. 账户结构解析 (CPMM PoolState)
池子账户大小为 **637 字节**。通过解析数据段（偏移量基于 Anchor 8字节判别码）：
- **Vaults**: 存储 Token A/B 的账户地址。
- **Mints**: 确定交易对（如 WSOL/测试币）。

### 3. 推荐 SDK
使用官方 V2 版本以获得完整的 CPMM 支持：
- **Package**: `@raydium-io/raydium-sdk-v2`
- **关键 API**: `raydium.cpmm.getRpcPoolInfo(poolAddress)`

## 关联引用
- **向上索引**: [[200_Areas/Area_区块链/_blockchain_moc|区块链领域 MOC]]
- **验证实例**: `4uVNR4kBu79vUeJyLSbAip6dw58oGkEKQQtGCNdAZtXy` (WSOL/EMky...Xchv 池子)

## 参考资料
- [Raydium 官方开发文档](https://docs.raydium.io/raydium/for-developers/program-addresses)
