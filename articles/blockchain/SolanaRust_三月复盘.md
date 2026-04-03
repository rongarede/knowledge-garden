---
title: SolanaRust 三月工作复盘（2025.11 - 2026.02）
status: active
tags:
  - retrospective
  - solana
  - blockchain
up: "[[_blockchain_moc]]"
created: 2026-03-09
maturity: evergreen
---

# SolanaRust 三月工作复盘

## 总览

| 指标 | 数值 |
|------|------|
| 时间跨度 | 2025-11-25 ~ 2026-02-07 |
| 项目总数 | 33 个 |
| 技术栈分布 | Rust 17 / Python 9 / TypeScript 5 / 混合 2 |
| Git 提交数 | 9 次（子目录提交频率 Top 3：raydium_py 30, buy_meme 25, IPFlow 15） |
| Bug 记录数 | 8 条（全部来自 Telegram_bot，JSON 格式错误占 87.5%） |

两个半月的时间里，围绕 Solana 生态完成了从智能合约开发、DeFi 集成、代币工具链到自动化运营的全栈实践。以下按五条产品线逐一复盘。

## 一、IPFlow 协议（核心产品）

**项目**：ipflow-v3, jupiter-cpi-swap-example, sol-swap-cpi, raydium-cpi, raydium-cpi-example, sb-on-demand-examples

### 做了什么

IPFlow 是一个链上概率奖励协议，用户支付 SOL/USDT 后触发 VRF 随机数，按线性递减概率分布获得 1-400 USD 奖励。整个开发经历了四个阶段，共规划 37 个 Task，完成 27 个：

- **阶段 0**（基础设施）：初始化 Anchor 合约结构，集成 Pyth Network 价格预言机、Raydium CPMM Swap CPI、Switchboard On-Demand VRF，实现计数器哈希法衍生随机数。5/5 全部完成。
- **阶段 1**（核心业务）：实现 `request_mint`（支付+请求）、奖励衍生算法（逆变换采样）、`fulfill_mint`（VRF 揭示+兑付）、USDT 支付路径、领取流程重构（Pending→Revealed→Claimed 三阶段状态机）、Jupiter+Raydium 双路由架构、前端 SDK 封装（IpflowSDK，ESM/CJS 双模块）、CALL_FLOW 目录化文档。完成 18/20 Task。
- **阶段 2**（鲁棒性）：完成幂等性保护和 VRF 网关超时修复，超时退款指令已实现并通过 Devnet 45 秒测试。规划了 Swap 失败退款、滑点保护、Pyth 价格新鲜度校验等 8 个安全 Task，尚有 7 个未开始。
- **阶段 3**（管理功能）：完成管理员提取/注入资金、动态奖品池管理（独立 PDA + 硬删除 + 链上索引）。紧急暂停、权限转移、配置更新仍在规划中。

### 技术亮点

- **Anchor 合约架构**：指令按 admin/user/oracle 分层，状态模型独立为 global_config / mint_request / prize_pool 三个 PDA
- **Switchboard VRF**：Pull-based Commit-Reveal 模式，防重放校验，4 个备用网关回退机制
- **Jupiter + Raydium 双路由 CPI**：`SwapRouter` 枚举统一调度，Raydium 的 13 个 `remaining_accounts` 透传，Jupiter CPI 的 `expected_token_output` 校验
- **前端 SDK**：TypeScript IpflowSDK 类，浏览器兼容 NPM 包（ESM 33.22 kB / CJS 19.25 kB）
- **分层概率分布**：四层 Tier 设计（ROI = -29.2%），蒙特卡洛 100,000 次验证通过
- **前端全链路验证**：通过 chrome-devtools MCP 完成抽奖→VRF 揭示→Token 领取端到端测试

### 踩坑与反思

- **Jupiter vs Raydium 路由切换反复**：Task 1.16 集成 Jupiter 替换 Raydium，Task 1.20 又改回双路由架构。根本原因是未提前做技术选型对比，直接在合约层面试错，导致返工
- **合约缺少单元测试**：前期开发快速推进时忽略了测试，直到 Task 1.21 才补充 proptest 属性测试和 SDK 单元测试
- **VRF 网关不稳定**：Switchboard Devnet 网关频繁 503，最终实现了 fulfillMintWithRetry + 指数退避 + 多网关回退，但这些本应在设计阶段就考虑到

### 成果

- PRP 文档 37 个 Task 规划完整，27 个已完成
- 合约部署至 Devnet（Program ID: `ALRWyaQkjVGznjAXsxhqXkyYDaETPUN2xj82W8uyji53`）
- 产出 api-sdk.md、CALL_FLOW 目录化文档（14 个文件）、5 份 codemap
- Devnet 全链路验证通过（SOL 支付、USDT 支付、SOL 领取、Token 领取四条路径）
- 前端 chrome-devtools 自动化测试通过，中奖金额验证正确（24.95 USD / 101.86 USD / 227.37 USD）

## 二、Meme 代币工具链

**项目**：buy_meme, meme-swap, meme-collection, meme-collector, meme-distribution, batch_trader, raydium_py, LAUNCHPAD

### 做了什么

构建了覆盖 Meme 代币生命周期全流程的工具链：批量购买、归集、分发、交易记录。核心逻辑围绕 Raydium CPMM 交易展开，同时提供 Rust 和 Python 双语言实现。

- `buy_meme`：全局配置、动态精度、并发购买，带 README 文档
- `batch_trader`：并发执行 + 随机延迟 + CSV 日志记录
- `raydium_py`：Python 版 Raydium 交易工具集
- `meme-collection` / `meme-collector`：代币归集（多钱包→单钱包）
- `meme-distribution`：代币分发（单钱包→多钱包）

### 技术亮点

- Rayon 并行处理多钱包并发交易
- ATA（Associated Token Account）自动创建，无需预先初始化
- 滑点控制与动态精度计算

### 踩坑与反思

- **重复实现严重**：`meme-collection`、`meme-collector`、`bulk_transfer` 三个项目功能高度重叠，Python 和 Rust 版本也存在功能重复。原因是每次都"从头写一个"而非复用已有代码
- 应先调研已有工具，再决定是否新建项目

### 成果

覆盖代币购买→归集→分发→交易全流程，Rust 和 Python 双语言可用

## 三、自动化运营

**项目**：Telegram_bot, TG, twitter-reply-bot, webfind, post-request-repeater

### 做了什么

- Telegram 多账号自动发送消息，支持定时部署和批量注册
- Twitter LLM 自动回复（LangChain 集成）
- HTTP 请求重放工具

### 技术亮点

- Telethon Session 复用，避免重复登录
- `at` 命令定时调度，实现无人值守
- LangChain 集成 LLM 生成上下文相关回复

### 踩坑与反思

这是 bug 最密集的产品线。8 条 bug 记录全部来自 `Telegram_bot/`，其中 7 条是 JSON 格式错误（占 87.5%）。具体分布：

| 时间 | Bug ID | 问题 |
|------|--------|------|
| 2025-12-31 | FIX-001 | Python 缺少 import + 键名错误 |
| 2025-12-31 | fix-json-format | scrip0101/0102/0103.json 多余花括号、缺少逗号 |
| 2026-01-04 | bug_001 | scrip0104.json 多余花括号 |
| 2026-01-06 | fix-json-scrip0106 | 缺少逗号、未闭合对象 |
| 2026-01-08 | fix-json-scrip0108 | 缺少逗号、字段不完整 |
| 2026-01-09 | fix-json-scrip0109 | 圆括号误用、引号嵌套错误 |
| 2026-01-10 | FIX_JSON_SYNTAX_0111 | 多余开花括号 |
| 2026-01-24 | BUG-001 | scrip0124/0125.json 缺少逗号 |

根本原因清晰：手动编辑 JSON 脚本文件极易出错，且没有任何格式校验环节。这种同类 bug 反复出现长达一个月，说明缺乏从 bug 中学习和改进流程的意识。

### 成果

实现 20+ 天连续运营，多平台自动化覆盖

## 四、Solana 基础设施工具

**项目**：batch-balance-query, batch-nft-query, nft-holder-query, solana-balance-aggregator, solana-batch-transfer, bulk_transfer, key-converter, key-derivation, mnemonic-generator, nft-transfer, solana-query, transaction-history-query

### 做了什么

构建了 12 个独立的 Solana 链上工具，覆盖四大类场景：

- **查询类**：批量余额查询、NFT 持有者查询、交易历史查询、余额聚合
- **转账类**：批量 SOL/Token 转账、批量 NFT 转移
- **密钥类**：密钥格式转换、HD 派生、助记词生成
- **NFT 类**：cNFT 转移（跳过已持有地址）

### 技术亮点

- Umi SDK + Merkle 证明实现 cNFT 转移
- 多 RPC 端点容错，自动切换
- 并发聚合查询提升批量操作效率

### 踩坑与反思

工具间功能边界模糊。例如 `solana-batch-transfer` 和 `bulk_transfer` 功能重叠，`batch-balance-query` 和 `solana-balance-aggregator` 也有重复。缺乏统一的工具索引和功能矩阵。

### 成果

12 个独立工具覆盖查询/转账/密钥/NFT 四大场景，均可命令行直接使用

## 五、学习与探索

**项目**：metaplex-program-library, blueshift_anchor_vault, swarm-game, 集训营

### 做了什么

- 研读 Metaplex 合约库源码，理解 NFT 标准实现
- 学习 Switchboard Oracle 机制，完成 blueshift_anchor_vault 示例
- 探索多智能体游戏（swarm-game）
- 参与 Solana 集训营课程

### 成果

这些探索为 IPFlow 的技术选型提供了直接支撑——Switchboard VRF 集成、NFT 标准理解、Anchor 合约模式都源于此阶段的积累。

## 反思总结

### 做得好的

- **项目数量多且覆盖面广**：33 个项目横跨合约开发、DeFi 集成、工具链、自动化运营、前端 SDK，形成了较完整的 Solana 全栈能力图谱
- **IPFlow 全流程闭环**：从 PRP 设计文档到 Anchor 合约、前端 SDK、Devnet 部署、chrome-devtools 端到端测试，完成了从 0 到 1 的产品级开发
- **工具链完整度高**：Meme 代币全生命周期、Solana 基础设施 12 个工具，覆盖了日常开发和运营的大部分需求
- **文档产出丰富**：CALL_FLOW 14 个流程文档、5 份 codemap、PRP 三阶段规划，形成了可追溯的技术决策记录

### 需改进的

- **重复实现浪费精力**：meme-collection / meme-collector / bulk_transfer 三个项目功能重叠，Python / Rust 双语言版本也有冗余。根因是"先写再说"的习惯，应改为先调研已有工具再决策
- **JSON bug 反复出现**：一个月内 7 次相同类型的 JSON 格式错误，暴露了缺少格式校验的系统性问题。手动编辑 JSON 本身就是 anti-pattern
- **合约测试覆盖不足**：IPFlow 的 proptest 和 SDK 单元测试到后期才补充，前期快速开发阶段几乎裸奔
- **技术决策犹豫导致返工**：Jupiter/Raydium 路由选择经历了"用 Raydium→换 Jupiter→改回双路由"的过程，说明技术选型阶段调研不够充分

### 下一步计划

- **合并重复工具**：meme-collection / meme-collector / bulk_transfer 三选一，统一为单一代币操作工具
- **引入 JSON schema 验证**：为 Telegram_bot 的脚本文件添加 JSON Schema 校验，杜绝手动编辑错误
- **补充 IPFlow 合约单元测试**：完成阶段 2 剩余的 7 个安全 Task，提升测试覆盖率
- **IPFlow 主网部署准备**：完成 Mainnet Fork 验证（Task 1.19）、紧急暂停机制（Task 3.4）、配置更新指令（Task 3.6）

## Dataview 索引

```dataview
TABLE file.ctime AS "创建时间", status AS "状态"
FROM "100_Projects"
WHERE contains(tags, "solana") OR contains(tags, "blockchain")
SORT file.ctime DESC
```
