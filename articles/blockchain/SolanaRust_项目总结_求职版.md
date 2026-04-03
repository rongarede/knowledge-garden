---
title: Solana 全栈开发项目总结
status: active
tags:
  - resume
  - solana
  - blockchain
up: "[[_blockchain_moc]]"
created: 2026-03-09
maturity: evergreen
---

# Solana 全栈开发项目总结

> 2025.11 — 2026.02 | 33 个项目 · 6 大模块 | Rust / TypeScript / Python

## 一、核心项目：IPFlow 协议

IPFlow 是一个链上抽奖协议，用户支付 SOL 或 USDT 后触发链上可验证随机数（VRF），根据概率分布获得代币奖励。项目涵盖合约、SDK、前端全栈，历经 37 个 Task 迭代，已完成 27 个。

### 链上合约（Anchor / Rust）

设计并实现了状态机驱动的 Request → Mint → Claim 三阶段流程：

- **状态机设计**：MintRequest 经历 Pending → Revealed → Claimed 三阶段流转，支持 24 小时领取超时与超时退款，claim 后自动关闭 PDA 退还租金
- **可验证随机数**：集成 Switchboard On-Demand VRF，采用 Pull-based Commit-Reveal 模式，客户端 commit 与 request_mint 合并为原子交易，reveal 与 fulfill_mint 同样合并执行，消除时序间隙
- **双路由 Swap**：实现 Jupiter + Raydium 双路由 CPI Swap 架构（SwapRouter 枚举调度），支持 SOL/Token 灵活兑换，13 个 remaining_accounts 精确传递，3% 滑点保护
- **概率分布系统**：分层概率引擎（4 Tier），逆变换采样 + integer_sqrt，经 100,000 次蒙特卡洛验证，期望值 7.08 USDC（ROI = -29.2%）
- **奖品池管理**：独立 PDA + 硬删除架构，支持 add/remove/update 指令与链上索引，5 个 Mainnet 代币池（USELESS/EGO/AU79/FOMO/LION）
- **价格预言机**：Pyth Network SOL/USD 实时价格换算，bankrun 测试框架验证
- **管理员系统**：withdraw_sol/withdraw_token 资金提取、动态配置、权限隔离

合约部署至 Devnet，25 个单元测试全部通过，链上概率分布测试 8/10 轮成功。SDK 包含 17 个 proptest 属性测试 + 16 个 PDA 与类型单元测试。

### 前端 SDK 与端到端验证

- 封装 IpflowSDK 类（TypeScript），提供 getGlobalConfig / requestMint / claimToken / fulfillMint 完整接口，ESM（33.22 kB）/ CJS（19.25 kB）双模块输出
- 集成 Jupiter swap-instructions 与 Raydium V3 API 自动选池
- Switchboard 网关超时重试（fulfillMintWithRetry + 指数退避 + 4 备用网关回退）
- Chrome DevTools MCP 自动化验证：完整抽奖流程（支付 → VRF 揭示 → 中奖 → Token 领取）Devnet 端到端通过

**技术栈：** Anchor · Solana Program · PDA · CPI · Switchboard VRF · Jupiter · Raydium CPMM · Pyth Network · TypeScript SDK

## 二、交易与 DeFi 工具链

### Raydium / Jupiter 交易引擎

- Rust 实现 Raydium CPMM 实时交易（买入/卖出/滑点控制），支持全局配置与动态精度
- Python 并发版本支持多账号批量交易（随机延迟 + CSV 日志），增强版 batch trader 支持并发执行
- Jupiter CPI 跨程序调用封装（SOL 借用 → 兑换 → 归还模式）

### 代币批量操作

- **批量归集**：从多钱包并行归集 SPL Token（Rayon 并发 + 自动 ATA 创建）
- **批量分发**：从 Excel 读取地址列表，异步批量空投
- **批量转账**：支持 dry-run 预检、USD → SOL 自动换算

**技术栈：** Raydium CPMM API · Jupiter CPI · Rayon 并行 · Tokio 异步 · SPL Token

## 三、NFT 与链上数据

### NFT 工具

- cNFT 批量转移（Umi SDK + Merkle 证明 + 动态 Compute Unit），自动跳过已持有目标 collection 的接收者
- NFT 持有者全量查询与批量元数据检索

### 链上数据查询

- 多钱包余额并发聚合
- 交易历史批量拉取（多 RPC 容错：Helius / QuickNode / Alchemy）

**技术栈：** Metaplex Umi · Bubblegum · DAS API · solana-client · 并发查询

## 四、自动化运营系统

### Telegram 多账号自动化

- 多账号并发消息发送（Telethon + Session 复用），JSON 脚本驱动消息序列
- 定时任务部署（远程服务器 at 调度），批量账号信息管理
- 8 次 bug 修复迭代，建立 bugs.jsonl 复盘机制

### 增长工具

- 账号批量注册（并发 + 统计报告）
- Twitter LLM 自动回复机器人（LangChain 集成）

**技术栈：** Telethon · LangChain · asyncio · 远程部署

## 五、基础设施与密钥管理

- BIP39 助记词生成与密钥派生
- Base58 与 Hex 格式互转
- 多 RPC 端点管理（Helius / QuickNode / Alchemy），网关健康检查与自动回退

## 六、技术能力总结

| 领域 | 技术点 |
|------|--------|
| 链上开发 | Anchor · Solana Program · PDA · CPI · IDL · 状态机设计 |
| DeFi 集成 | Jupiter Swap · Raydium CPMM · Switchboard VRF · Pyth Oracle |
| NFT | Metaplex · Bubblegum · cNFT · Merkle Proof · DAS API |
| 后端工具 | Rust CLI · Rayon · Tokio · Python asyncio · 并发批处理 |
| 测试体系 | bankrun · proptest · Playwright E2E · Chrome DevTools MCP |
| 自动化 | Telegram Bot · Twitter Bot · 定时部署 · 批量脚本 |
| 全栈 | TypeScript SDK · React 前端 · Next.js · Devnet 端到端验证 |
