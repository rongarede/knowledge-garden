---
title: ABI（Application Binary Interface）
aliases: [ABI, 合约接口, 应用二进制接口]
tags: ["区块链/Solidity"]
up: "[[_blockchain_moc]]"
status: active
maturity: budding
---

# ABI（Application Binary Interface）

## What（是什么）

- ABI 是描述合约中函数、事件、参数结构的标准格式（通常为 JSON）。
- 它定义了外部与智能合约交互的协议：函数签名、参数类型、返回类型、事件格式等。
- 作用类似 Web API 的 Swagger 文档，是调用方与合约之间的桥梁。

## Why（为什么需要 ABI）

- 前端、脚本、后端服务需要 ABI 才能正确编码调用数据。
- 合约之间交互也依赖 ABI 来理解目标合约接口。
- Web3.js、Ethers.js、Hardhat、Foundry 等工具都依赖 ABI 创建合约实例。
- ABI 是链下与链上通信的基础标准，确保数据可被正确解析。

ABI 不参与业务逻辑执行，但没有 ABI，外部系统基本无法可靠调用目标合约。

## When（何时用到 ABI）

- DApp 前端按钮触发合约函数调用时。
- 脚本部署与自动化交互时。
- 合约调用另一个合约时。
- 调试、测试、事件日志解码时。
- 编译后导出产物供外部系统消费时。

## Where（在哪里体现 ABI）

- 编译后产物 `out/合约名.json` 中。
- 区块浏览器（如 Etherscan）页面。
- 前端工程的 `abi.json` 或构建产物中。
- Solidity 编译器基于 interface/contract 自动生成。

## How（如何使用 ABI）

生成 ABI：

```bash
forge build
solc --abi
```

前端加载 ABI：

```js
const contract = new ethers.Contract(address, abi, providerOrSigner);
```

- 也可用于解码交易输入、解析事件日志。
- 可配合 `interface` 或 `abi.encodeWithSelector` 实现合约间调用。

## How much（重要性/成本）

- ABI 本身不直接消耗 gas，但通过 ABI 触发的链上执行会消耗 gas。
- 它是 Web3 前端、链下服务、脚本交互的必备组件。
- 缺失 ABI 会显著降低合约可交互性与可维护性。
