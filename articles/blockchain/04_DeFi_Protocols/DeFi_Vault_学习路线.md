---
title: DeFi Vault 学习路线
date: 2026-04-03
tags:
  - defi
  - vault
  - solidity
  - learning
up: "[[_inbox_index]]"
status: in-progress
priority: high
maturity: seed
---

# DeFi Vault 学习路线

> [!abstract] 目标
> 从简到难，建立 DeFi Vault 的完整心智模型：存取机制 → 单策略生命周期 → 安全设计模式 → 多策略架构 → 测试工程

## Phase 1: vault-fun — 最小心智模型（30 min）

- [x] 阅读 vault-fun 仓库 README
- [x] 理解 ERC-4626 基本接口：`deposit / withdraw / totalAssets / convertToShares`
- [x] 记录核心公式：`shares = deposit * totalSupply / totalAssets`
- [x] 笔记：share 定价机制为什么能防止稀释攻击？

**关键问题**：
1. Vault 的 share 和 underlying asset 之间的汇率怎么变化？
2. 第一个存款人的 share 怎么定价？（首次存款问题）

---

## Phase 2: Beefy BeefyVaultV7.sol — 单策略 Vault 完整生命周期（1 hr）

- [ ] 阅读 `BeefyVaultV7.sol` 完整代码
- [ ] 梳理 deposit → strategy.deposit → harvest → withdraw 流程
- [ ] 理解 `earn()` 函数：资金从 Vault 转入 Strategy 的时机
- [ ] 理解 `balance()` = Vault 闲置 + Strategy 部署的总额
- [ ] 记录手续费模型（performance fee, management fee）

**关键问题**：
1. 用户 withdraw 时如果 Strategy 里的钱不够怎么办？
2. harvest 的触发者是谁？激励机制是什么？
3. Vault 和 Strategy 的信任边界在哪里？

---

## Phase 3: MetaMorpho MetaMorpho.sol — 安全设计模式（2-3 hrs）

- [ ] 精读权限系统：Owner / Curator / Allocator / Guardian 四种角色
- [ ] 理解 Cap 机制：每个市场的存款上限如何保护用户
- [ ] 理解 Timelock + Queue：配置变更的延迟执行机制
- [ ] 理解 `supplyQueue` / `withdrawQueue`：资金分配优先级
- [ ] 记录 `reallocate()` 的约束条件
- [ ] 对比 Beefy 的简单模型，总结 MetaMorpho 多了哪些安全层

**关键问题**：
1. Guardian 的紧急操作权限有哪些？能做什么不能做什么？
2. Timelock 如何防止恶意 Owner 跑路？
3. Cap 和 Queue 如何协同工作？
4. 为什么需要 Curator 这个中间角色？

---

## Phase 4: Yearn V3 TECH_SPEC.md + Vault.vy — 多策略架构（3-4 hrs）

- [ ] 精读 TECH_SPEC.md 整体架构
- [ ] 理解 Vault ↔ Strategy 的接口约定（`report()`, `totalAssets()`）
- [ ] 理解利润解锁机制（Profit Locking / Unlocking）
- [ ] 理解 `debt` 分配：Vault 如何在多个 Strategy 间分配资金
- [ ] 理解 `maxDebt` / `maxLoss` 参数的保护作用
- [ ] 对比 MetaMorpho 的 queue 模型 vs Yearn 的 debt 模型
- [ ] 记录模块化设计：Vault / Strategy / Accountant / Factory 的职责划分

**关键问题**：
1. Strategy report 时如果报告亏损，Vault 怎么处理？
2. 利润为什么要 "解锁" 而不是立即分配？（防三明治攻击）
3. Yearn V3 vs V2 的核心架构变化是什么？
4. Vyper 的 `@nonreentrant` vs Solidity 的 ReentrancyGuard 有什么区别？

---

## Phase 5: tokenized-strategy-foundry-mix — 测试结构参考（1 hr）

- [ ] 浏览项目结构：`test/` 目录组织方式
- [ ] 理解 Foundry 测试模式：`setUp()` / `test_` / `testFuzz_`
- [ ] 记录 mock 策略的写法：如何模拟收益和亏损
- [ ] 记录 fork 测试模式：如何用 mainnet fork 测试真实协议交互
- [ ] 提取可复用的测试模板

**关键问题**：
1. 如何测试 Vault 在极端情况下的行为？（全部提款、策略归零）
2. Fuzz testing 的边界值怎么设？
3. 集成测试 vs 单元测试在 DeFi 中的侧重点？

---

## 学习产出

完成后应能回答：
- [ ] ERC-4626 的核心接口和 share 定价机制
- [ ] 单策略 vs 多策略 Vault 的架构差异
- [ ] Vault 安全设计的 3 个关键模式（权限分层、时间锁、Cap 限制）
- [ ] 利润解锁机制的设计动机
- [ ] 如何用 Foundry 写 Vault 的单元/Fuzz/集成测试

## 关联笔记

- [[_inbox_index]]

## 参考资料

- [ERC-4626 标准](https://eips.ethereum.org/EIPS/eip-4626)
- vault-fun 仓库
- Beefy Finance BeefyVaultV7
- Morpho MetaMorpho
- Yearn V3 Vault
- tokenized-strategy-foundry-mix
