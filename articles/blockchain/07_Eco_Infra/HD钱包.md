---
title: "HD 钱包与派生协议标准（BIP-32 / BIP-39 / BIP-44）"
aliases: ["HD 钱包与派生协议标准（BIP-32 / BIP-39 / BIP-44）", "HD钱包", "HD 钱包与派生协议标准（BIP-32 / BIP-39 / BIP-44）笔记"]
tags: ["区块链/基础设施"]
up: "[[_blockchain_moc]]"
status: active
maturity: budding
---

# HD 钱包与派生协议标准（BIP-32 / BIP-39 / BIP-44）

## What — 定义

**HD 钱包（Hierarchical Deterministic Wallet）**：一种通过**单个种子**（通常由助记词生成）派生出无限个子私钥/地址的钱包结构。它支持**分层派生、多账户、多币种**，广泛应用于以太坊、比特币、Solana 等主流区块链。

**BIP-32**：定义了 HD 钱包的"树状结构"，支持主私钥推导出无限子私钥/公钥（支持硬化路径），是 HD 钱包的底层算法。

**BIP-39**：定义了如何通过**助记词（Mnemonic）生成种子**，再用于 BIP-32 中的主密钥推导，增强了钱包的可备份性与用户友好性。

**BIP-44**：在 BIP-32 基础上，进一步规范了路径格式，形成了**多币种、多账户、多地址的派生标准路径结构**。

## Why — 重要性

- **统一标准**：让不同钱包软件（如 MetaMask、Ledger）可互通导入
- **更安全的备份方式**：只需保存助记词（BIP-39），即可恢复全部子地址
- **批量地址管理**：适合多账户/多签名场景，支持分层结构
- **多币种派生**：一个种子管理多个链（如 ETH, BTC, SOL）
- **跨平台兼容**：遵循这三大协议的 HD 钱包，可在任何合规工具中恢复与使用

## When — 适用场景

- 创建个人钱包、冷钱包、硬件钱包（如 Trezor/Ledger/onekey）
- 去中心化应用（DApp）中批量派生身份子地址
- 交易所、支付系统中统一生成地址并管理私钥
- 使用助记词快速跨设备恢复钱包
- 多币种统一派生（如在一个助记词下同时管理 ETH 和 BTC）

## Where — 工具与实现

- **Ethers.js**：`HDNodeWallet.fromPhrase(...)`
- **Viem**：`mnemonicToAccount()`、`deriveAccount()`
- **Bitcoinjs-lib**：支持 BIP32/BIP44 全套功能
- **钱包支持**：MetaMask、TrustWallet、Argent、Ledger、Trezor
- **CLI 工具**：`ethers-wallet`, `bip39`, `viem hd` 脚本等

## How — 协同工作流程

1. **BIP-39 助记词生成种子**：12 或 24 个英文单词表示一个 128/256 位熵，转换为种子（seed），作为 HD 钱包主入口。

   ```bash
   abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about
   ```

2. **BIP-32 从种子派生密钥树**：使用 `master seed → master key → 子私钥` 路径；可分层派生、支持硬化路径（防止公钥反推）。

   ```
   m / 0' / 1 / 2
   ```

3. **BIP-44 规范路径格式用于多币种**：路径结构如下，典型以太坊路径为 `m/44'/60'/0'/0/0`。

   ```
   m / purpose' / coin_type' / account' / change / address_index
   ```

   | 字段 | 含义 | 示例 |
   |------|------|------|
   | `44'` | 固定值，代表使用 BIP-44 | 44' |
   | `60'` | `coin_type`，60 表示 Ethereum（Bitcoin 是 0） | 60' |
   | `0'` | 账户编号 | 0' |
   | `0` | 外部地址（1 为找零） | 0 |
   | `0` | 第 0 个地址 | 0 |

## 参考链接

- [BIP-32 原文](https://github.com/bitcoin/bips/blob/master/bip-0032.mediawiki)
- [BIP-39 原文](https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki)
- [BIP-44 原文](https://github.com/bitcoin/bips/blob/master/bip-0044.mediawiki)
- [Ethers.js HD 钱包文档](https://docs.ethers.org/v6/api/wallet/#HDNodeWallet)
- [Viem HD 钱包派生](https://viem.sh/docs/accounts/mnemonic.html)
