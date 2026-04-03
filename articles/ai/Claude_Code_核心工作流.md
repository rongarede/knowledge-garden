---
title: Claude Code 核心工作流
aliases: [Claude 工作流, Feature Pipeline, Quality Gate]
date: 2026-01-22
tags: [AI/Claude, AI/工作流, AI/TDD]
up: "[[_ai_moc]]"
status: active
maturity: evergreen
---

# Claude Code 核心工作流

> [!abstract]
> 从 [everything-claude-code](https://github.com/affaan-m/everything-claude-code) 提炼的==核心工作流==，分别覆盖功能开发与质量门禁。

^core-workflow-overview

## 概览

> [!example]- 两套流程总览
> | 工作流 | 适用场景 | 核心理念 |
> |--------|----------|----------|
> | **功能开发流水线** | 新功能、重构、架构变更 | Plan → TDD → Review → Commit |
> | **质量门禁** | 代码合并前、发布前 | 三审查员并行，零容忍安全 |

^core-workflow-summary

---

## 工作流一：功能开发流水线 (Feature Pipeline)

### 流程图

> [!example]-
> ```
> ┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐
> │  PLAN    │───▶│   TDD    │───▶│  REVIEW  │───▶│  COMMIT  │
> │ (planner)│    │(tdd-guide)│   │(reviewer)│    │          │
> └──────────┘    └──────────┘    └──────────┘    └──────────┘
>      │               │               │               │
>      ▼               ▼               ▼               ▼
>  用户确认后       RED→GREEN       CRITICAL=0     Conventional
>  才继续          →REFACTOR        HIGH=0         Commits
>                 覆盖率≥80%
> ```

### 四阶段详解

> [!example]- 角色与门禁
> | 阶段 | 命令 | Agent | 输入 | 输出 | 门禁条件 |
> |------|------|-------|------|------|----------|
> | **1. PLAN** | `/plan` | planner | 需求描述 | 分阶段实现计划 | 用户 CONFIRM |
> | **2. TDD** | `/tdd` | tdd-guide | 计划 + 接口定义 | 测试 + 实现代码 | 覆盖率 ≥ 80% |
> | **3. REVIEW** | `/code-review` | code-reviewer | git diff | 分级问题清单 | CRITICAL=0, HIGH=0 |
> | **4. COMMIT** | 手动 | - | 通过审查的代码 | git commit | 测试全绿 |

^core-workflow-pipeline-stages

### 阶段一：PLAN

**触发**：复杂功能需求、架构变更、重构任务

**输出模板**：

> [!example]- PLAN 输出模板
> ```markdown
> # Implementation Plan: [Feature Name]
> 
> ## Overview
> [2-3 句话概述]
> 
> ## Requirements
> - [ ] 需求 1
> - [ ] 需求 2
> 
> ## Architecture Changes
> - [Change 1: file path and description]
> 
> ## Implementation Steps
> 
> ### Phase 1: [阶段名]
> 1. **[步骤名]** (File: path/to/file.ts)
>    - Action: 具体动作
>    - Why: 原因
>    - Dependencies: None / Requires step X
>    - Risk: Low/Medium/High
> 
> ## Testing Strategy
> - Unit tests: [待测函数]
> - Integration tests: [待测流程]
> - E2E tests: [待测用户旅程]
> 
> ## Risks & Mitigations
> - **Risk**: [描述]
>   - Mitigation: [应对措施]
> 
> ## Success Criteria
> - [ ] 验收条件 1
> - [ ] 验收条件 2
> ```

> [!important]
> **关键原则**：
> - 计划必须用户 CONFIRM 才继续
> - 具体到文件路径、函数名
> - 考虑 edge cases 和错误场景
> - 最小化变更，优先扩展而非重写

^core-workflow-plan

### 阶段二：TDD

**TDD 内循环**：

> [!example]-
> ```
>      ┌─────────────────────────────────┐
>      │         TDD INNER LOOP          │
>      │                                  │
>      │   RED ──▶ GREEN ──▶ REFACTOR    │
>      │    │                    │        │
>      │    └────────────────────┘        │
>      │         (每个功能点重复)          │
>      └─────────────────────────────────┘
> ```

> [!example]- 步骤矩阵
> | 步骤 | 阶段 | 操作 | 验证 |
> |------|------|------|------|
> | 1 | RED | 先写测试 | - |
> | 2 | RED | 运行测试 | **必须失败** |
> | 3 | GREEN | 写最小实现 | - |
> | 4 | GREEN | 运行测试 | **必须通过** |
> | 5 | REFACTOR | 重构代码 | 测试仍通过 |
> | 6 | VERIFY | 检查覆盖率 | ≥ 80% |

**三类必写测试**：

1. **Unit Tests** - 函数级别：happy path + 边界 + 异常
2. **Integration Tests** - API/数据库/组件集成
3. **E2E Tests** - 关键用户流程（Playwright）

> [!example]- 边界情况覆盖
> | 类型 | 示例 |
> |------|------|
> | Null/Undefined | 输入为 null 时的行为 |
> | Empty | 空数组、空字符串 |
> | Invalid Types | 错误类型参数 |
> | Boundaries | 最小值、最大值 |
> | Network Errors | 网络失败、超时 |
> | Race Conditions | 并发操作 |
> | Large Data | 10k+ 条数据 |
> | Special Characters | Unicode、emoji、SQL 字符 |

> [!example]- 覆盖率要求
> | 代码类型 | 最低覆盖率 |
> |----------|-----------|
> | 普通业务代码 | 80% |
> | 金融计算 | 100% |
> | 认证逻辑 | 100% |
> | 安全关键代码 | 100% |
> | 核心业务逻辑 | 100% |

^core-workflow-tdd

### 阶段三：REVIEW

**Code Reviewer 检查清单**：

> [!danger]
> 任何 CRITICAL 安全项命中都应立即阻断合并。

**安全检查 (CRITICAL)**：
- [ ] 无硬编码凭证（API keys, passwords, tokens）
- [ ] 无 SQL 注入风险（查询字符串拼接）
- [ ] 无 XSS 漏洞（未转义用户输入）
- [ ] 输入验证完整
- [ ] 依赖无已知漏洞
- [ ] 无路径遍历风险
- [ ] CSRF 防护
- [ ] 认证绕过检查

**代码质量 (HIGH)**：
- [ ] 函数不超过 50 行
- [ ] 文件不超过 800 行
- [ ] 嵌套不超过 4 层
- [ ] 错误处理完整（try/catch）
- [ ] 无 console.log
- [ ] 使用不可变模式
- [ ] 新代码有测试

**性能 (MEDIUM)**：
- [ ] 算法复杂度合理
- [ ] React 无不必要重渲染
- [ ] 适当使用 memoization
- [ ] Bundle 大小优化
- [ ] 无 N+1 查询

> [!example]- 示例输出
> ```
> [CRITICAL] Hardcoded API key
> File: src/api/client.ts:42
> Issue: API key exposed in source code
> Fix: Move to environment variable
> 
> const apiKey = "sk-abc123";           // ❌ Bad
> const apiKey = process.env.API_KEY;   // ✓ Good
> ```

**审批标准**：
- ✅ Approve: 无 CRITICAL 或 HIGH 问题
- ⚠️ Warning: 仅 MEDIUM 问题（谨慎合并）
- ❌ Block: 存在 CRITICAL 或 HIGH 问题

^core-workflow-review

### 阶段四：COMMIT

**Conventional Commits 格式**：

> [!example]-
> ```
> <type>: <description>
> 
> <optional body>
> ```

**Type 类型**：

> [!example]- Commit 类型
> | Type | 用途 |
> |------|------|
> | feat | 新功能 |
> | fix | Bug 修复 |
> | refactor | 重构 |
> | docs | 文档 |
> | test | 测试 |
> | chore | 杂项 |
> | perf | 性能优化 |
> | ci | CI/CD |

---

## 工作流二：质量门禁 (Quality Gate)

### 流程图

> [!example]-
> ```
>                     ┌──────────────────┐
>                     │   Trigger:       │
>                     │   代码变更完成    │
>                     └────────┬─────────┘
>                              │
>             ┌────────────────┼────────────────┐
>             │                │                │
>             ▼                ▼                ▼
>      ┌────────────┐   ┌────────────┐   ┌────────────┐
>      │   CODE     │   │  SECURITY  │   │    TEST    │  ← 并行执行
>      │  REVIEWER  │   │  REVIEWER  │   │  COVERAGE  │
>      └─────┬──────┘   └─────┬──────┘   └─────┬──────┘
>            │                │                │
>            ▼                ▼                ▼
>      CRITICAL: 0      Secrets: 0       Coverage: ≥80%
>      HIGH: 0          OWASP: PASS      Tests: ALL PASS
> 
>             └────────────────┼────────────────┘
>                              │
>                              ▼
>                     ┌──────────────────┐
>                     │   ALL PASS?      │
>                     └────────┬─────────┘
>                       YES    │    NO
>                         ▼         ▼
>                     ┌──────┐  ┌──────┐
>                     │MERGE │  │BLOCK │
>                     └──────┘  └──────┘
> ```

### 三审查员并行执行

> [!example]- 并行审查矩阵
> | 审查员 | Agent | 检查项 | 阻断条件 |
> |--------|-------|--------|----------|
> | **Code Reviewer** | code-reviewer | 代码质量、可读性、复杂度、性能 | CRITICAL 或 HIGH > 0 |
> | **Security Reviewer** | security-reviewer | 硬编码密钥、注入风险、OWASP Top 10 | 任何安全漏洞 |
> | **Test Coverage** | tdd-guide | 覆盖率、测试类型完整性 | 覆盖率 < 80% |

### 问题分级矩阵

> [!important]- 审查分级
> | 级别 | 处理方式 | 示例 |
> |------|----------|------|
> | **CRITICAL** | 立即停止，必须修复 | 硬编码 API Key、SQL 注入 |
> | **HIGH** | 阻断合并，优先修复 | 缺少输入验证、XSS 风险 |
> | **MEDIUM** | 警告，建议修复 | 函数过长、深层嵌套 |
> | **LOW** | 记录，择机处理 | 变量命名、代码风格 |

### Security Reviewer OWASP Top 10 检查

> [!example]- OWASP 检查清单
> | 漏洞类型 | 检查点 |
> |----------|--------|
> | A01:2021 Broken Access Control | 权限验证、越权访问 |
> | A02:2021 Cryptographic Failures | 弱加密、明文存储 |
> | A03:2021 Injection | SQL/NoSQL/OS 注入 |
> | A04:2021 Insecure Design | 业务逻辑缺陷 |
> | A05:2021 Security Misconfiguration | 默认配置、错误信息泄露 |
> | A06:2021 Vulnerable Components | 已知漏洞依赖 |
> | A07:2021 Auth Failures | 认证绕过、会话固定 |
> | A08:2021 Data Integrity Failures | 反序列化、CI/CD 攻击 |
> | A09:2021 Logging Failures | 日志缺失、敏感信息记录 |
> | A10:2021 SSRF | 服务器端请求伪造 |

^core-workflow-quality

---

## 两套工作流的关系

> [!example]-
> ```
> ┌─────────────────────────────────────────────────────────────────────────┐
> │                      COMPLETE DEVELOPMENT CYCLE                          │
> ├─────────────────────────────────────────────────────────────────────────┤
> │                                                                          │
> │   ┌─────────────────────────────────────────────────────────────────┐   │
> │   │                    WORKFLOW 1: FEATURE PIPELINE                  │   │
> │   │                                                                  │   │
> │   │     PLAN ──▶ TDD ──▶ REVIEW ──▶ COMMIT                          │   │
> │   │                         │                                        │   │
> │   └─────────────────────────┼────────────────────────────────────────┘   │
> │                             │                                            │
> │                             │ 触发                                       │
> │                             ▼                                            │
> │   ┌─────────────────────────────────────────────────────────────────┐   │
> │   │                    WORKFLOW 2: QUALITY GATE                      │   │
> │   │                                                                  │   │
> │   │     ┌─────────────┬─────────────┬─────────────┐                 │   │
> │   │     │ Code Review │  Security   │   Testing   │  ← 并行         │   │
> │   │     └──────┬──────┴──────┬──────┴──────┬──────┘                 │   │
> │   │            └─────────────┼─────────────┘                         │   │
> │   │                          ▼                                       │   │
> │   │                    MERGE / BLOCK                                 │   │
> │   └─────────────────────────────────────────────────────────────────┘   │
> │                                                                          │
> └─────────────────────────────────────────────────────────────────────────┘
> ```

---

## 快速参考

### 触发条件

> [!example]- 条件总览
> | 工作流 | 触发场景 |
> |--------|----------|
> | **Feature Pipeline** | 新功能需求、复杂重构、架构变更 |
> | **Quality Gate** | 代码变更完成后（自动）、合并请求前、发布前 |

### 关键原则

> [!important]
> 1. **Plan 需确认**：计划必须用户 CONFIRM 才继续
> 2. **测试先行**：TDD 中禁止先写实现
> 3. **并行审查**：3 个 Agent 同时执行，不阻塞彼此
> 4. **零容忍安全**：安全问题立即 STOP

^core-workflow-principles

### 命令速查

> [!example]-
> | 命令 | 作用 | Agent |
> |------|------|------|
> | `/plan` | 创建实现计划 | planner |
> | `/tdd` | TDD 开发 | tdd-guide |
> | `/code-review` | 代码审查 | code-reviewer |
> | `/e2e` | E2E 测试 | e2e-runner |
> | `/build-fix` | 修复构建错误 | build-error-resolver |

### 模型选择策略

> [!example]- 模型策略
> | 模型 | 适用场景 | 特点 |
> |------|----------|------|
> | **Haiku 4.5** | 轻量 Agent、高频调用 | 90% Sonnet 能力，3x 成本节省 |
> | **Sonnet 4.5** | 主开发工作、编码任务 | 最佳编码模型 |
> | **Opus 4.5** | 复杂架构决策、深度研究 | 最强推理能力 |

---

## 相关资源

- [[Claude_Code_Skill迭代复盘指南]]
- [[如何用 Claude Skill 做一套会自己干活的知识库？]]
- [everything-claude-code GitHub](https://github.com/affaan-m/everything-claude-code)
