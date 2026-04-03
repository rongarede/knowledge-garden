---
title: staticcall 模拟合约交互
aliases: ["staticCall 原理", "只读调用", "合约模拟执行"]
tags: ["区块链/Solidity"]
up: "[[_blockchain_moc]]"
status: active
maturity: budding
---

# staticcall 原理与使用

`staticcall` 是 EVM 只读调用机制：可以执行逻辑并返回结果，但禁止任何状态写入。

## What（是什么）

- `staticcall` 执行目标逻辑，但不能修改链上状态。
- 常见于 `ethers` 的 `callStatic` 或 `viem` 的 `simulateContract`。

## Why（为什么使用）

- 在真实发送交易前做预检查。
- 预判交易是否会 revert。
- 不消耗实际上链执行成本，也不触发状态变化。

## When（适用场景）

- 调用合约函数前进行 dry-run。
- 批量交易前筛选会失败的调用。
- Flashloan 或组合调用前做路径验证。

## Where（在哪些框架中）

- `ethers.js`：`contract.callStatic.fn(...)`
- `viem`：`simulateContract(...)`
- `Hardhat`：`contract.callStatic.fn(...)`
- `Foundry`：`cast call`

## How（如何使用）

典型写法（概念示意）：

```js
const result = await contract.callStatic.claim(user, amount);
```

注意：`staticcall` 通过不代表真实交易必然成功，真实交易仍会受 gas、状态竞争和权限变化影响。

排错建议：

- 捕获 revert reason 并记录输入参数。
- 对比模拟时区块状态与发送交易时状态差异。
- 检查目标函数是否依赖可变状态。
