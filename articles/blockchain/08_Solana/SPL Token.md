---
title: "SPL Token（Solana Program Library Token Standard）"
aliases: ["SPL Token（Solana Program Library Token Standard）", "SPL Token", "SPLToken"]
tags: ["区块链/Solana"]
up: "[[_blockchain_moc]]"
status: active
maturity: budding
---

# SPL Token（Solana Program Library Token Standard）

## 定义（What）

- Solana 上的同质化（FT）和非同质化（NFT）代币标准
- 对应以太坊 ERC-20（FT）和部分 ERC-721 / ERC-1155（NFT）功能
- 由 SPL Token Program 实现的通用代币逻辑

## 核心组成（Components）

SPL Token Program：
- 程序 ID: TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA
- 代币操作的唯一执行入口（Mint、Burn、Transfer、Freeze 等）

Mint Account：
- 存储代币元数据（精度、总供应量、铸币权限等）
- 每个代币类型唯一对应一个 Mint Account

Token Account：
- 存储某个钱包在某个代币下的余额和授权信息
- 每个 (钱包地址 + Mint Account) 对应唯一 Token Account

[[Associated Token Account（ATA）]]：
- Token Account 的默认地址规范（PDA 派生）
- 由 (owner, mint, Token Program ID) 计算

## 为什么重要（Why）

- 统一标准 → 所有 Solana 钱包、DEX、NFT 市场都能识别
- 安全性 → 由 Solana 官方维护的标准程序
- 可组合性 → 任何应用都能直接调用 Token Program

## 谁在用（Who）

- DeFi 协议（Raydium、Orca）
- NFT 项目（Metaplex）
- 稳定币（USDC、USDT 在 Solana 上）

## 何时使用（When）

- 创建同质化代币（FT）
- 创建非同质化代币（NFT）
- 在合约中管理代币交易（质押、收益分配、兑换）

## 如何运作（How）

创建代币：
- 调用 Token Program 创建新的 Mint Account
- 设置 mintAuthority 和 freezeAuthority

分发代币：
- 创建 Token Account（或 ATA）
- 调用 mint_to

转账：
- 检查双方 Token Account 的 mint 是否相同
- 扣减发送方余额、增加接收方余额

销毁：
- 调用 burn 从 Token Account 扣除余额并减少总供应量

## 与 Ethereum ERC-20 对比

| 特性 | SPL Token | ERC-20 |
| --- | --- | --- |
| 账户模型 | Mint Account + Token Account | EVM 地址直接持有余额 |
| Token Program | 链上已部署的通用程序 | 每个代币都是独立合约 |
| 地址可预测性 | ATA 可预测 | 无原生可预测机制 |
| NFT 支持 | 同一标准可扩展到 NFT | 需单独 ERC-721 / ERC-1155 |

## 架构图

```
[User Wallet]
    |
    | owns
    v
[Token Account] --(linked to)--> [Mint Account] --(controlled by)--> [SPL Token Program]
```
