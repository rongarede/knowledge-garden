---
up: "[[_resources_index]]"
tags:
  - tech/blockchain
  - tech/solana
  - tech/oracle
created: 2026-01-22
status: complete
maturity: evergreen
---

# Switchboard Devnet Gateway 配置指南

## 概述

Switchboard 是 Solana 生态主流的去中心化预言机网络。本文档记录如何在 devnet 环境下获取和配置 Switchboard Gateway。

## 核心发现

> [!important] 关键点
> Switchboard 在所有网络（devnet/mainnet）使用**统一的 Gateway（Crossbar）和 Program ID**，通过 cluster 参数或 Queue 选择区分网络。

## 配置参数速查

| 配置项 | 值 |
|--------|-----|
| **Crossbar Gateway** | `https://crossbar.switchboard.xyz` |
| **On-Demand Program ID** | `SBondMDrcV3K4kxZR1HNVT7osZxAHVHgYXL5Ze1oMUv` |
| **V2 Program ID** | `SW1TCH7qEPTdLsDHRgPuMQjbQxKdH2aBStViMFnt64f` |
| **Devnet RPC** | `https://api.devnet.solana.com` |
| **Queue 获取** | `getDefaultDevnetQueue(rpcUrl)` |

## SDK 选择

| SDK | 包名 | 架构 | 推荐度 |
|-----|------|------|--------|
| **On-Demand** | `@switchboard-xyz/on-demand` | Pull Oracle | ⭐⭐⭐ 推荐 |
| **V2** | `@switchboard-xyz/solana.js` | Push Oracle | 维护中 |

## 快速上手 (TypeScript)

### 1. 安装依赖

```bash
npm install @switchboard-xyz/on-demand @solana/web3.js
```

### 2. Devnet 连接示例

```typescript
import {
  CrossbarClient,
  PullFeed,
  getDefaultDevnetQueue,
  SB_ON_DEMAND_PID,
} from "@switchboard-xyz/on-demand";
import { Connection, PublicKey } from "@solana/web3.js";

// ==================== Devnet 配置 ====================
const DEVNET_RPC = "https://api.devnet.solana.com";
const connection = new Connection(DEVNET_RPC, "confirmed");

// Crossbar 客户端 - 自动连接官方网关
const crossbar = CrossbarClient.default();

async function main() {
  // 获取 Devnet 默认 Queue
  const queue = await getDefaultDevnetQueue(DEVNET_RPC);
  console.log("Devnet Queue:", queue.pubkey.toBase58());
  console.log("Program ID:", SB_ON_DEMAND_PID.toBase58());

  // 示例：读取 Feed 数据
  const feedPubkey = new PublicKey("YOUR_DEVNET_FEED_PUBKEY");
  const feed = new PullFeed(connection, feedPubkey);

  const data = await feed.loadData();
  console.log("Feed Value:", data.value.toString());
}

main();
```

### 3. 查询可用 Feeds

```typescript
// 通过 Crossbar 查询 devnet 可用 feeds
const feeds = await crossbar.getFeeds({ cluster: "devnet" });
console.log("Available Devnet Feeds:", feeds);
```

### 4. 模拟获取更新指令

```typescript
import { PullFeed } from "@switchboard-xyz/on-demand";

async function fetchUpdateInstruction(feedPubkey: PublicKey) {
  const [pullIx, responses, success] = await PullFeed.fetchUpdateIx(
    connection,
    {
      feeds: [feedPubkey],
      crossbarClient: CrossbarClient.default(),
    }
  );

  console.log("Update Instruction:", pullIx);
  console.log("Oracle Responses:", responses);
  return pullIx;
}
```

## 传统 SDK 示例 (V2)

```typescript
import {
  SwitchboardProgram,
  AggregatorAccount,
} from "@switchboard-xyz/solana.js";
import { Connection, PublicKey } from "@solana/web3.js";

const connection = new Connection("https://api.devnet.solana.com");
const program = await SwitchboardProgram.load("devnet", connection);

async function readAggregator(aggregatorPubkey: PublicKey) {
  const aggregator = new AggregatorAccount(program, aggregatorPubkey);
  const result = await aggregator.fetchLatestValue();
  console.log("Price:", result?.toString());
}
```

## CLI 配置

```bash
# 安装 Switchboard CLI
npm install -g @switchboard-xyz/cli

# 配置 Devnet RPC
sb config set solana devnet rpc https://api.devnet.solana.com

# 配置默认账户
sb config set solana devnet default-account "~/.config/solana/id.json"

# 查看当前配置
sb config print
```

## 常见问题

### Q: Devnet 和 Mainnet 的 Gateway 地址一样吗？
A: 是的，Switchboard 使用统一的 Crossbar Gateway (`https://crossbar.switchboard.xyz`)，通过 cluster 参数区分网络。

### Q: 如何获取 Devnet 上的 Feed 地址？
A:
1. 使用 `crossbar.getFeeds({ cluster: "devnet" })` 查询
2. 查看官方文档 Feed Registry
3. 自行部署 Feed（需要 SOL 作为 gas）

### Q: On-Demand 和 V2 SDK 有什么区别？
A:
- **On-Demand (Pull)**: 用户主动拉取数据，按需付费
- **V2 (Push)**: Oracle 定期推送数据，需要预付费

## 参考资源

- [Switchboard 官方文档](https://docs.switchboard.xyz/)
- [GitHub: switchboard-xyz/solana-sdk](https://github.com/switchboard-xyz/solana-sdk)
- [NPM: @switchboard-xyz/on-demand](https://www.npmjs.com/package/@switchboard-xyz/on-demand)
- [Switchboard Discord](https://discord.gg/switchboardxyz)

## 调研元数据

| 属性 | 值 |
|------|-----|
| 调研日期 | 2026-01-22 |
| 技术栈 | TypeScript |
| 成熟度要求 | 生产级 |
| 结论 | 使用 @switchboard-xyz/on-demand + 统一 Crossbar Gateway |
