---
up: "[[Switchboard_Devnet_Gateway配置指南]]"
tags:
  - tech/blockchain
  - tech/solana
  - tech/oracle
  - diagram
created: 2026-01-22
maturity: budding
---

# Switchboard Devnet 使用流程图

## 1. 整体架构

```mermaid
graph TB
    subgraph "你的应用"
        APP[DApp / 后端服务]
    end

    subgraph "Switchboard SDK"
        SDK["@switchboard-xyz/on-demand"]
        CB[CrossbarClient]
    end

    subgraph "Switchboard 基础设施"
        GW["Crossbar Gateway<br/>crossbar.switchboard.xyz"]
        subgraph "Devnet Queue"
            O1[Oracle 1]
            O2[Oracle 2]
            O3[Oracle 3]
        end
    end

    subgraph "Solana Devnet"
        RPC["RPC Endpoint<br/>api.devnet.solana.com"]
        PROG["On-Demand Program<br/>SBondMDrcV3K..."]
        FEED[Feed Account]
    end

    APP --> SDK
    SDK --> CB
    CB --> GW
    GW --> O1 & O2 & O3
    O1 & O2 & O3 --> FEED
    SDK --> RPC
    RPC --> PROG
    PROG --> FEED
```

## 2. 初始化流程

```mermaid
flowchart TD
    START([开始]) --> INSTALL[安装 SDK<br/>npm install @switchboard-xyz/on-demand]
    INSTALL --> CONN[创建 Solana Connection<br/>RPC: api.devnet.solana.com]
    CONN --> CROSSBAR[初始化 CrossbarClient<br/>CrossbarClient.default]
    CROSSBAR --> QUEUE[获取 Devnet Queue<br/>getDefaultDevnetQueue]
    QUEUE --> READY([初始化完成])

    style START fill:#e1f5fe
    style READY fill:#c8e6c9
    style QUEUE fill:#fff3e0
```

## 3. 读取 Feed 数据流程

```mermaid
flowchart TD
    START([需要价格数据]) --> FEED[创建 PullFeed 实例<br/>new PullFeed connection, feedPubkey]
    FEED --> LOAD[加载 Feed 数据<br/>feed.loadData]
    LOAD --> CHECK{数据是否过期?}
    CHECK -->|否| USE[使用当前值<br/>data.value]
    CHECK -->|是| FETCH[获取更新指令<br/>PullFeed.fetchUpdateIx]
    FETCH --> SEND[发送交易更新]
    SEND --> LOAD
    USE --> END([返回价格])

    style START fill:#e1f5fe
    style END fill:#c8e6c9
    style FETCH fill:#ffecb3
```

## 4. 创建自定义 Feed 流程

```mermaid
flowchart TD
    START([创建 Feed]) --> DEFINE[定义 OracleJob<br/>数据源 + 解析逻辑]
    DEFINE --> SIMULATE[模拟执行<br/>crossbar.simulateFeeds]
    SIMULATE --> VALID{结果有效?}
    VALID -->|否| DEFINE
    VALID -->|是| INIT[初始化 Feed 交易<br/>PullFeed.initTx]
    INIT --> SIGN[签名交易]
    SIGN --> SEND[发送到 Devnet]
    SEND --> CONFIRM[确认交易]
    CONFIRM --> END([Feed 创建完成])

    style START fill:#e1f5fe
    style END fill:#c8e6c9
    style SIMULATE fill:#e8f5e9
```

## 5. 数据更新流程 (Pull Oracle)

```mermaid
sequenceDiagram
    participant App as 你的应用
    participant SDK as Switchboard SDK
    participant GW as Crossbar Gateway
    participant Oracle as Oracle 节点
    participant Chain as Solana Devnet

    App->>SDK: 请求最新价格
    SDK->>GW: fetchUpdateIx(feedPubkey)
    GW->>Oracle: 请求签名数据
    Oracle->>Oracle: 从数据源获取价格
    Oracle->>Oracle: 签名数据
    Oracle-->>GW: 返回签名响应
    GW-->>SDK: 返回更新指令 + 响应
    SDK->>Chain: 发送交易
    Chain->>Chain: 验证签名
    Chain->>Chain: 更新 Feed Account
    Chain-->>SDK: 交易确认
    SDK-->>App: 返回最新价格
```

## 6. 关键组件关系

```mermaid
graph LR
    subgraph "配置层"
        RPC[RPC URL]
        PID[Program ID]
    end

    subgraph "客户端层"
        CONN[Connection]
        CB[CrossbarClient]
    end

    subgraph "核心对象"
        Q[Queue]
        F[PullFeed]
    end

    subgraph "操作"
        READ[读取数据]
        UPDATE[更新数据]
        CREATE[创建 Feed]
    end

    RPC --> CONN
    PID --> F
    CONN --> Q
    CB --> UPDATE
    Q --> F
    F --> READ
    F --> UPDATE
    Q --> CREATE
```

## 7. 代码与流程对照

| 流程步骤 | 代码 | 说明 |
|---------|------|------|
| 建立连接 | `new Connection(RPC_URL)` | 连接 Solana Devnet |
| 初始化网关 | `CrossbarClient.default()` | 连接 Crossbar |
| 获取队列 | `getDefaultDevnetQueue(rpcUrl)` | 获取 Devnet Oracle 队列 |
| 创建 Feed | `new PullFeed(conn, pubkey)` | 实例化 Feed 对象 |
| 读取数据 | `feed.loadData()` | 从链上读取 |
| 更新数据 | `PullFeed.fetchUpdateIx()` | 获取更新指令 |

## 8. 错误处理流程

```mermaid
flowchart TD
    OP[执行操作] --> ERR{发生错误?}
    ERR -->|否| SUCCESS([成功])
    ERR -->|是| TYPE{错误类型}

    TYPE -->|RPC 错误| RETRY[重试 3 次]
    TYPE -->|数据过期| REFRESH[刷新数据]
    TYPE -->|签名无效| CHECK[检查 Oracle 状态]
    TYPE -->|余额不足| FUND[充值 SOL]

    RETRY --> OP
    REFRESH --> OP
    CHECK --> REPORT[报告问题]
    FUND --> OP

    style SUCCESS fill:#c8e6c9
    style REPORT fill:#ffcdd2
```
