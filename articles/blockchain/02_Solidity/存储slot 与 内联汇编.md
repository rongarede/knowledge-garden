---
title: 存储 slot 与内联汇编
aliases: ["Storage Slot", "Solidity Assembly", "sload sstore"]
tags: ["区块链/Solidity"]
up: "[[_blockchain_moc]]"
status: active
maturity: budding
---

# 存储 slot 与内联汇编

slot 是状态变量在 EVM storage 的定位单元；内联 `assembly` 可直接通过 `sload/sstore` 读写底层存储。

## What（是什么）

- slot 表示状态变量在存储中的固定位置。
- `assembly` 允许直接使用 EVM 指令操作 slot。

## Why（为什么使用）

- 在特定场景绕过高层语法，获得更精细控制。
- 代理/可升级合约中可手动约束关键存储位置。
- 便于底层调试与特殊优化。

## When（什么时候用）

- 需要自定义存储布局。
- 需要极致 gas 优化。
- 做底层开发、安全审计或兼容性修复。

## Where（用在哪里）

- 合约内部 `assembly {}` 代码块。
- DeFi 协议、可升级合约库、底层基础组件。

## How（如何使用）

读取 slot 示例：

```solidity
function readOwner() external view returns (address ownerAddr) {
    assembly {
        ownerAddr := sload(2)
    }
}
```

写入 slot 示例：

```solidity
function writeOwner(address newOwner) external {
    assembly {
        sstore(2, newOwner)
    }
}
```

注意：直接操作 slot 极易引发存储覆盖与权限绕过，必须配合存储布局文档和审计流程。

排错重点：

- 确认 slot 编号与变量布局一致。
- 检查继承顺序与升级前后布局变化。
- 用测试验证读写值与预期一致。
