---
title: "Mempool（内存池）"
aliases: ["Mempool（内存池）", "mempool", "Mempool（内存池）笔记"]
tags: ["区块链/基础设施"]
up: "[[_blockchain_moc]]"
status: active
maturity: budding
---

# Mempool（内存池）

## What — 定义

Mempool，全称 Memory Pool（内存池），是指在交易尚未被区块链网络打包进区块前，被临时存储在节点本地内存中的**待确认交易集合**。

节点收到新交易后，会进行基本验证（如签名、余额），验证通过后便将其放入本地 Mempool 中，等待打包进区块。每个全节点都有自己的 mempool，可能彼此略有差异。

## Why — 必要性

- **缓冲机制**：避免所有交易都即时广播到链上，降低网络负载
- **排序策略**：矿工可根据 Gas Fee 对交易排序，优先打包高收益交易（如 [[EIP-1559 以太坊Gas机制]] 的 `maxPriorityFeePerGas`）
- **透明预览**：DApp、MEV Bot 等可实时监听 mempool，观察即将被打包的交易
- **安全分析**：攻击者有时会利用 mempool 的可见性发起前置交易（Front-running）

## When — 交易进入时机

- 用户提交交易后 → 交易被节点验证通过 → 未被打包入区块前
- 节点同步过程中收到网络中广播的交易
- 合约调用或代币转账的离线构建交易提交后

## Where — 系统位置

- 所有运行 Ethereum 节点（如 Geth、Nethermind、Erigon）都实现了 mempool
- 区块打包逻辑从 mempool 中获取交易
- 工具与服务：
  - `eth_sendRawTransaction`：将交易广播进 mempool
  - `blocknative`、`flashbots`、`mempool.space` 等监控工具
  - Viem/Ethers 等库可用于查询 mempool 状态（非标准 RPC）

## How — 运作流程

1. 用户发起交易
2. 本地节点验证交易合法性（签名、nonce、gas）
3. 将交易存入 mempool（按 gas 排序）
4. 矿工或出块者从 mempool 中选择交易打包进新区块
5. 被打包成功后，该交易会从所有节点的 mempool 中删除

## 补充术语

- **Pending transaction**：表示已进入 mempool，尚未被确认的交易
- **Nonce 管理**：确保同一地址交易顺序一致
- **EIP-1559 与 Mempool**：EIP-1559 引入 base fee 与 tip，影响交易优先级排序方式

## 参考链接

- [Ethereum Docs - Transaction Lifecycle](https://ethereum.org/en/developers/docs/transactions/)
- [Mempool.space](https://mempool.space/)
- [Flashbots - MEV and Mempool Access](https://docs.flashbots.net/)
