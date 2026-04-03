---
title: "Solana 账户模型"
aliases: ["Solana 账户模型", "Solana账户模型", "Solana 账户模型笔记"]
tags: ["区块链/Solana"]
up: "[[_blockchain_moc]]"
status: active
maturity: budding
---

# Solana 账户模型

## 定义

在 Solana 中，账户是链上所有状态的唯一载体，既存储 SOL 余额，也可存储任意数据（包括程序代码与合约状态）。

## 核心特性

- 数据即账户：状态必须存在某个账户的数据区
- 需预分配空间，不能随便动态扩展（除非 `realloc`）
- 存储需支付租金，可通过 Rent Exempt 机制免租
- `owner` 决定哪个程序可修改账户数据
- 交易执行需声明账户访问权限（只读/可写）

## 账户类型

- 系统账户（System Account）
- 数据账户（Data Account）
- 程序账户（Program Account）
- [[PDA]]（Program Derived Address）
- Token 账户（SPL Token 标准）

## 数据结构

- lamports：账户余额
- owner：拥有者程序公钥
- data：二进制数据
- executable：是否为可执行账户
- rent_epoch：租金检查点

## 访问规则

- 交易中必须显式声明访问的账户及权限
- 可写账户在同一时刻只能被一个交易访问
- 只读账户可被多个交易同时访问
- PDA 无私钥，由程序 `invoke_signed` 访问

## Anchor 框架映射

- 使用 `#[account]` 声明结构体，自动校验 owner、反序列化数据
- 支持 PDA seeds、bump 自动管理

## 对比 EVM 账户模型

- Solana：独立账户存储数据，需预分配空间，可并行处理
- EVM：合约存储在存储槽，可动态增长，顺序执行

## 编程注意事项

- 创建账户时准确设置 `space`
- 长期数据需 rent-exempt
- PDA 设计需安全、唯一
- 账户顺序需与程序声明一致
- 并行优化：减少可写账户数量

![image.png](../assets/image_1754618204327_0.png)
