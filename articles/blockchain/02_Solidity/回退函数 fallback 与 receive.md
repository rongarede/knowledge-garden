---
title: 回退函数 fallback 与 receive
aliases: ["receive 与 fallback", "Solidity 收款函数", "fallback receive 对比"]
tags: ["区块链/Solidity"]
up: "[[_blockchain_moc]]"
status: active
maturity: budding
---

# receive() vs fallback()

`receive()` 处理"空 calldata 的纯转账"；`fallback()` 处理函数不匹配或带 calldata 的兜底场景。

## What（是什么）

| 函数 | 定义 |
|---|---|
| `receive()` | 仅处理纯 ETH 转账且 `calldata` 为空；必须 `payable` |
| `fallback()` | 兜底函数：函数签名不匹配或 `msg.data.length > 0`；可选 `payable` |

## When（何时触发）

### receive()

- 条件：`msg.data.length == 0`
- 常见触发：`transfer` / `send` / `call{value:x}("")`

### fallback()

- 函数选择器无匹配。
- 或 `msg.data.length > 0` 且 `receive()` 不存在。

## Why（为什么存在）

### receive()

- 提供简单、低复杂度的收款入口。

### fallback()

- 防止未知调用直接失败且难定位。
- 代理合约常用其转发任意 `calldata`。
- 可自定义回退处理逻辑。

## How（怎么用）

### receive() 注意点

- 保持逻辑极简（记账、事件）。
- 复杂逻辑应通过普通函数和 `call{value:x}` 触发。

### fallback() 注意点

- 需要收 ETH 时必须标注 `payable`。
- 代理场景常配合 `delegatecall`。
- 结尾应明确 `return` 或 `revert`，避免静默吞错。

注意：把复杂业务放进 `receive()` / `fallback()` 容易引发不可预期失败与调试困难。
