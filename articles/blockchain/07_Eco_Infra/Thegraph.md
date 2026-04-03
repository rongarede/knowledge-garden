---
title: "Thegraph"
aliases: ["Thegraph", "Thegraph笔记"]
tags: ["区块链/基础设施"]
up: "[[_blockchain_moc]]"
status: active
maturity: budding
---

# Thegraph

## The Graph 基础原理

参考：[[The Graph 基础原理]]

### The Graph 解决的问题

- 传统 Web3 dApp 查询链上数据存在的问题：复杂逻辑无法高效索引、缺乏结构化接口、难以聚合或排序
- The Graph 提供 GraphQL 查询接口，从链上事件中提取结构化实体，解决可读性与性能问题

### 核心架构组件

- Subgraph：用户定义的数据索引逻辑（schema + mapping + manifest）
- Graph Node：监听链上区块与事件，执行 mapping 脚本
- GraphQL API：前端可访问的查询接口
- 去中心化网络角色：
  - Indexer：运行 Graph Node 提供服务
  - Curator：选择优质 Subgraph 并质押 GRT
  - Delegator：委托 GRT 获得奖励
  - Query User：支付 GRT 查询数据

### 去中心化的必要性

- 提高抗审查性、可用性、经济激励可持续性
- GRT 是经济激励核心，但需搭配可验证机制保障结果可信

## Firehose 原理

参考：[[Firehose 原理]]

- Firehose 是结构化区块流服务，从链上节点解析出高度压缩且完整的 Protobuf 格式数据
- 支持并发解析、全链历史重建，适配多链结构（Ethereum、Solana、Cosmos）
- 输出包含：transactions、logs、traces、stateChanges 等
- 解决传统 Graph Node 性能瓶颈和链适配困难的问题

## Substreams 原理

参考：[[Substreams 原理]]

- Substreams 是基于 Rust 的模块化索引系统，解耦逻辑、支持组合
- 模块类型：
  - `map`：处理区块数据并输出结构化数据
  - `store`：维护状态（如余额、累积数据）
  - `sink`：输出到外部系统
- 可组合性强：模块之间可复用，便于跨链合并处理
- 性能高：基于 WASM 和并发执行

## 跨链聚合能力

参考：[[Firehose + Substreams 的跨链聚合能力]]

- 可以将多个链（如 Ethereum 与 Solana）的 Firehose 数据作为输入
- 编写模块将这些链的数据结构对齐，形成统一的状态进度（如 NFT 跨链桥进度条）
- 适用于链上 + 链下任务监控、DeFi 跨链行为追踪、状态一致性验证

## 案例：Uniswap V3 Substreams

参考：[[真实案例分析：Uniswap V3 Substreams]]

项目地址：https://github.com/streamingfast/substreams-uniswap-v3

拆分模块处理：
- `map_pool_creations`：新池识别
- `map_swaps`：Swap 事件提取
- `map_mints` / `map_burns`：流动性变化追踪
- `store_liquidity`：维护每个池的实时状态

使用 Firehose 替代传统事件抓取，效率高、扩展强。支持输出 CSV、数据库、GraphQL、BigQuery 等多种渠道。

## 小结

- Firehose 提供统一高性能数据源
- Substreams 提供灵活、可组合的数据处理逻辑
- 两者结合是多链索引、实时状态追踪与分析的强力组合
- 去中心化网络 + 可验证查询 是 The Graph 的终极形态
