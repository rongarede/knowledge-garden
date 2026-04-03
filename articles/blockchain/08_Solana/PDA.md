---
title: "PDA（Program Derived Address）"
aliases: ["PDA（Program Derived Address）", "PDA", "PDA（Program Derived Address）笔记"]
tags: ["区块链/Solana"]
up: "[[_blockchain_moc]]"
status: active
maturity: budding
---

# PDA（Program Derived Address）

## 定义

- 一种由程序通过公钥和种子（seed）推导出来的、没有私钥的特殊账户地址
- 只能由生成它的程序通过程序签名（Program Signer）操作
- 常用于存储协议资金池、全局配置、用户仓位等"协议所有"的状态

## 特性

- 无私钥：无法被外部直接签名控制
- 可预测：由 seeds + program_id 唯一确定
- 唯一性：同一组合唯一对应一个 PDA
- 安全性：外部无法绕过程序直接操作
- 地址范围：避开所有有效 Ed25519 公钥

## 创建规则

Rust API：

```rust
let (pda, bump) = Pubkey::find_program_address(&[seeds...], program_id);
```

参数：
- seeds：一组字节数组（如字符串、Pubkey、u64）
- program_id：部署的程序地址
- bump：0~255 的单字节值，用于防止碰撞

## 使用场景

- 资金池账户（AMM、借贷）
- 用户仓位账户（user_pubkey + market_id）
- 全局配置（DAO 参数、治理状态）
- 托管账户 / Escrow

## Anchor 下的 PDA

自动生成和校验 PDA：
- `seeds`：构成 PDA 的数据
- `bump`：Anchor 自动计算
- PDA 地址由当前程序签名

调用需要程序签名时：
- 使用 `invoke_signed` 或 Anchor 的 `with_signer`

## 与普通账户的区别

普通账户：
- 由私钥签名控制
- 不可预测

PDA：
- 由程序签名控制
- 可预测（seeds + program_id）

## 好处

- 无需管理私钥
- 程序可控，防止绕过逻辑
- 可预测，方便跨合约交互

## 风险

- 种子设计不当可能泄露业务结构
- 程序逻辑漏洞会导致资产被程序签名转出

## 交互图

```
+------------------+       +-------------------+
|   User Wallet    |       |   Other Programs  |
| (has private key)|       |                   |
+------------------+       +-------------------+
           |  send tx
           v
+-----------------------------+
|   Your Program (on-chain)  |
|  program_id: XYZ...        |
+-----------------------------+
                | derive PDA from seeds + program_id
                v
       +-----------------------+
       | PDA Account (no key)  |
       | owner = Your Program  |
       +-----------------------+
                  | invoke_signed
                  v
         +----------------------+
         | SPL Token Program    |
         | (mint/transfer/etc.) |
         +----------------------+
```
