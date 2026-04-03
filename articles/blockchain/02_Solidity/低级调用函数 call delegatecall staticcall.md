---
title: 低级调用函数 call delegatecall staticcall
aliases: ["Solidity 低级调用", "call 与 delegatecall", "staticcall 用法"]
tags: ["区块链/Solidity"]
up: "[[_blockchain_moc]]"
status: active
maturity: budding
---

# Solidity 低级调用函数

`call`、`delegatecall`、`staticcall` 是 Solidity 低级交互基础：分别面向普通外部调用、代理上下文调用和只读调用。

## call

### What（是什么）

- 与外部合约交互的低级调用。
- 代码在目标合约执行，状态作用于目标合约。

### When（何时使用）

- 跨合约调用。
- 向合约发送 ETH。

### Why（为什么使用）

- 灵活，支持动态构造参数。
- 可在 ABI 不完全明确时调用。

### How（如何使用）

```solidity
(bool success, bytes memory data) = target.call{value: 1 ether}(
    abi.encodeWithSignature("foo(uint256)", 123)
);
```

- 必须检查 `success`。
- `msg.sender` / `msg.value` 保留原始调用上下文。

## delegatecall

### What（是什么）

- 与 `call` 类似，但状态读写发生在当前合约（调用者）的 storage。

### When（何时使用）

- [[代理合约]]（UUPS、Transparent Proxy）。
- 逻辑复用与升级架构。

### Why（为什么使用）

- 实现逻辑与数据分离，便于升级与复用。

### How（如何使用）

```solidity
(bool success, bytes memory data) = logic.delegatecall(
    abi.encodeWithSignature("setX(uint256)", 123)
);
```

- `address(this)` 指向调用者合约。
- 被调逻辑需严格对齐存储布局。

注意：`delegatecall` 风险最高，存储冲突与权限错误会造成系统级故障。

## staticcall

### What（是什么）

- 只读低级调用，禁止状态修改。

### When（何时使用）

- 查询外部 `view/pure` 函数，如预言机读取。

### Why（为什么使用）

- 强制只读语义，避免"伪 view"修改状态。

### How（如何使用）

```solidity
(bool success, bytes memory data) = oracle.staticcall(
    abi.encodeWithSignature("getPrice()")
);
```

- 常与 `abi.decode()` 搭配。
- 任意写状态行为会 revert。

生产代码中应明确区分三者语义，避免把只读查询写成可变调用。
