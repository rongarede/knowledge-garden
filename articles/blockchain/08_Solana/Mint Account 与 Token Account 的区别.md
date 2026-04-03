---
title: "Solana 账户类型对比"
aliases: ["Solana 账户类型对比", "Mint Account 与 Token Account 的区别", "MintAccount与TokenAccount的区别"]
tags: ["区块链/Solana"]
up: "[[_blockchain_moc]]"
status: active
maturity: budding
---

# Solana 账户类型对比

## Mint Account

- 定义：记录某种代币的全局元数据（精度、总供应量、铸币权限等）
- 唯一性：每个代币只有一个对应的 Mint Account
- 存储字段：
  - mint_authority：铸币权限
  - supply：当前总供应量
  - decimals：代币精度
  - is_initialized：是否初始化
  - freeze_authority（可选）：冻结权限
- 生命周期：
  - 代币创建时生成
  - 通常永久存在，不轻易销毁
- 权限：只有 mint_authority / freeze_authority 可修改
- 作用：
  - 代币的唯一身份标识
  - 所有 Token Account 必须引用它

## Token Account

- 定义：记录某个持有人在特定代币下的余额与状态
- 唯一性：每个（持有人 + 代币）组合一个 Token Account
- 存储字段：
  - mint：所属 Mint Account 地址
  - owner：账户持有人
  - amount：余额（最小单位）
  - delegate（可选）：代理转账权限
  - state：账户状态（正常 / 冻结）
- 生命周期：
  - 用户需要时创建
  - 可在用完后关闭并回收 rent
- 权限：只有 owner 或 delegate 可操作余额
- 作用：
  - 存储实际余额
  - 允许转账、授权、销毁

## 流程关系

Mint To（铸币）：
- 检查 Mint Account → 确认代币类型和铸币权限
- 增加 Mint Account supply
- 增加 Token Account amount

Transfer（转账）：
- 确认双方 Token Account mint 相同
- 扣减源 Token Account amount
- 增加目标 Token Account amount

## 类比

- Mint Account = 银行的货币发行登记簿
- Token Account = 银行的个人账户余额记录
