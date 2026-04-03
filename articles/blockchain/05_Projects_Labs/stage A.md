---
title: "Stage A · Week 1（W1）"
aliases: ["Stage A · Week 1（W1）", "Stage A W1", "Stage A 周计划"]
tags: [区块链/项目]
up: "[[_blockchain_moc]]"
status: active
maturity: sprout
---

# [[Stage A · Week 1（W1）]] #DeFi #Lending #Compound #Foundry #Security

## 目标（本周产出）

- 最小清算复现脚本 1 个（USDC，锁定区块）
- 不变式 ≥6 条落地（ACC-001/002/003，IDX-001，U-001，LQ-001）
- 小 PR #1（测试/文档/输入上界，<300 行）

## Day1｜基线与结构

- DONE 初始化实验仓并接入 Comet 依赖；`forge build/test` 通过；生成 `gas-snapshot`
  - DOD: `reports/W1D1-setup.md` 记录命令与版本；`gas-snapshot` 提交
- DONE 创建 `test/Invariant.t.sol`、`test/handlers/Handler.sol`、`src/lib/LibRead.sol` 骨架
  - DOD: `forge test` 仍绿；文件入库
- DONE 生成调用图 v1（计息/借还/清算/预言机主干）
  - DOD: `tools/graphviz/callgraph.svg` 提交

## Day2｜Slither & 易合点

- DONE 跑 Slither（过滤 `lib|node_modules|test|mocks`），输出问题清单并去噪
  - DOD: `tools/slither-report.json`；`reports/W1D2-slither.md`（高/中/低 + 误报说明）
- DONE 从报告中挑 2–3 个小改题目（文档/事件参数/输入校验）
  - DOD: 在看板/issue 登记"目标 PR + 备胎"各 1

[[Compound 利息结算机制案例 多用户 + 复利分段分析]]

[[Compound 白皮书]]

## Day3｜Fork 冒烟→最小清算（latest 起步）

- DONE 写 `scripts/fork_read.s.sol`（读取 `cash/borrows/reserves`），验证 RPC 连通
  - DOD: 控制台打印三会计量；日志入 `reports/W1D3-fork.md`

[[三会计量 4w1h]]

- DONE 写 `scripts/fork_liquidation_min.s.sol`（自铸小仓位，`absorb+buyCollateral` 一次）
  - DOD: 断言 3 项：债务减少≈扣抵押×价×(1-折价)±ε；清算人净收益≥0；事件一致
- DONE 将 fork 从 `latest` 固化为固定区块号
  - DOD: `fork.json` 写入 `blockNumber`；脚本复跑成功

[[Coumpound v2 v3 协议对比]]

## Day4｜不变式（首批 3 条）

- TODO 实现 ACC-001 会计守恒（比较内部账与链上余额，含 ε）
  - DOD: 断言通过；ε 依据写入注释
- TODO 实现 IDX-001 指数单调（`supplyIndex/borrowIndex` 只增不减）
  - DOD: 有时间推进（`warp/roll`）且稳定不抖
- TODO 实现 U-001 利用率边界（`0≤U≤1`）
  - DOD: 用 `LibRead.utilization()`，定点 1e18

## Day5｜不变式（再 3 条）+ fuzz 入门

- TODO 实现 ACC-002 非负性（池/账户级≥0）与 ACC-003 总量一致（∑明细≈总账）
  - DOD: Handler 维护工作集；误差在 ε 内
- TODO 实现 LQ-001 清算对账一致（债务减少≈扣抵押×价×(1-折价)±ε）
  - DOD: 在最小清算脚本的前后快照上读取对账
- TODO fuzz 2 条：`borrowWithinLimit`、`borrowBeyondLimitReverts`（`bound/assume` 收敛）
  - DOD: `forge test -vv` 稳定绿

## Day6｜小 PR #1 + 收尾

- TODO 提交小 PR #1（从 Day2 选题：测试/文档/输入上界）
  - DOD: 行数 <300、影响文件 <5；附 `gas-snapshot` & fork 证据链接
- TODO 周报与复盘：整理 D1–D5 的命令/图/日志，登记下周目标 PR/备胎
  - DOD: `reports/W1-weekly.md` 提交

## 休息：周日全休

## GATE（W1 结束必须满足）

最小清算脚本在固定区块下一键复现；6 条不变式稳定绿；PR #1 已投

---

# [[Stage A · Week 2（W2）]] #DeFi #Lending #Compound #Foundry #Security

## 目标（本周产出）

- 不变式补齐到 ≥10 条（新增：RBAC-001、ORC-001、RSV-001、LQ-002）
- 小 PR #2（护栏/测试类）；如有需要再切 PR #1 更小片
- 极值一次（利用率 0%/100% 或 TWAP vs spot）并形成 Δ-不变式 ≥1

## Day1｜不变式扩展（权限/价格/储备）

- TODO 实现 RBAC-001 权限闭包 + 事件一致（越权必 `revert`，事件数值=状态）
  - DOD: `expectRevert/expectEmit` 覆盖；文档化角色来源
- TODO 实现 ORC-001 价格新鲜度（`now - updatedAt ≤ staleness` 或走 TWAP）
  - DOD: 价格来源与参数记入 `LibRead`
- TODO 实现 RSV-001 储备非负 + 提取受控（不得超过可用，发事件）
  - DOD: 前后对比 `reserves` 与底层余额

## Day2｜操作后健康度 + Δ-不变式

- TODO 实现 LQ-002 操作后 HF≥1（非清算路径）
  - DOD: 在 Handler 每步后读取 HF，违反即红
- TODO 新增 Δ-不变式：指数单步变化率上限（与 `Δt`/利率上界一致）
  - DOD: 有公式与参数注释；跑深度≥100 仍稳

## Day3｜极值压测（择一）

- TODO 在 fork 上做一次极值：利用率 0%/100% 或 TWAP vs spot 对账
  - DOD: `reports/W2D3-stress.md` 含日志与图；如发现边界问题→开 issue

## Day4｜小 PR #2（护栏/回归）

- TODO 选择"会计护栏/事件一致/边界修正"类改动提交 PR
  - DOD: 附回归测试；CI 绿；必要时将 PR #1 拆更小片并跟评

## Day5｜稳定性与覆盖

- TODO 消除 invariant 抖动：统一 ε（随 `decimals` 缩放）、固定 `warp/roll`
  - DOD: `foundry.toml` 与 `LibEps` 更新；`forge test` 稳
- TODO 覆盖矩阵初稿：类型×范围×时序 打勾 ≥10 条属性
  - DOD: `reports/W2-coverage.md` 入库

## Day6｜Stage A 收官资产

- TODO 整理 `README` 跑法：fork 脚本/不变式/基准 一键命令
  - DOD: 新人可按 README 复现实验
- TODO Stage A 报告 v1：列出合并/待合 PR、失败反例与修复、覆盖矩阵、后续计划
  - DOD: `reports/stageA-v1.md` 提交

## 休息：周日全休

## GATE（W2 结束必须满足）

不变式总数 ≥10 且稳绿；极值压测完成并有 Δ-不变式 ≥1；小 PR #2 已投；Stage A 报告 v1 入库
