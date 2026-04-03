---
title: Claude Code 上下文管理机制
aliases: [上下文管理, Claude 会话记忆, Context 策略]
date: 2026-01-22
tags: [AI/Claude, AI/上下文, AI/记忆]
up: "[[_ai_moc]]"
status: active
maturity: evergreen
---

# Claude Code 上下文管理机制

> [!abstract]
> 从 [everything-claude-code](https://github.com/affaan-m/everything-claude-code) 提炼的==上下文与记忆管理==方案，目标是在长会话中保持连续性与可追溯性。

^context-overview

---

## 核心设计理念

> [!example]- 设计原则
> | 原则 | 说明 |
> |------|------|
> | **非侵入性** | Hook 在会话边界或阶段转换时运行，不打断工作流 |
> | **可追溯性** | 时间戳标记会话文件和压缩事件，便于回溯 |
> | **渐进积累** | Skill 随时间累积，新会话自动加载已学习内容 |
> | **策略性压缩** | 在逻辑边界触发压缩，而非固定间隔机械执行 |

^context-principles

---

## 架构总览

> [!example]-
> ```
> ┌─────────────────────────────────────────────────────────────┐
> │                     会话生命周期                              │
> ├─────────────────────────────────────────────────────────────┤
> │  SessionStart                                               │
> │      ↓                                                      │
> │  [加载 ~/.claude/sessions/ + ~/.claude/skills/learned/]     │
> │      ↓                                                      │
> │  Active Work (追踪工具调用次数)                               │
> │      ↓                                                      │
> │  [50+ 调用时建议压缩]                                        │
> │      ↓                                                      │
> │  PreCompact → 保存状态到 compaction-log.txt                  │
> │      ↓                                                      │
> │  Stop → 保存会话 + 提取可复用模式                             │
> └─────────────────────────────────────────────────────────────┘
> ```

^context-arch

---

## 三大核心机制

### 1. 会话持久化

通过 Hook 系统管理会话记忆，文件存储于 `~/.claude/sessions/`：

> [!example]- 会话钩子
> | 脚本 | Hook 触发点 | 功能 |
> |------|-------------|------|
> | `session-start.sh` | SessionStart | 加载最近 7 天的会话文件和已学习的 Skills |
> | `session-end.sh` | Stop | 保存会话状态到 `{DATE}-session.tmp` |
> | `pre-compact.sh` | PreCompact | 在上下文压缩前保存状态，记录到 `compaction-log.txt` |

**会话文件模板结构**：

- Current State（当前状态）
- Completed（已完成任务）
- In Progress（进行中任务）
- Notes for Next Session（下次会话备注）
- Context to Load（需加载的上下文）

### 2. 策略性压缩

> [!important]
> **核心原则：手动压缩 > 自动压缩**

> [!example]- 压缩模式对比
> | 对比项 | 自动压缩 | 策略性压缩 |
> |--------|----------|------------|
> | 触发时机 | 任意点 | 逻辑阶段边界 |
> | 上下文保留 | 可能丢失关键信息 | 保留阶段完整性 |
> | 用户体验 | 打断任务流 | 无感知过渡 |

**触发机制**：

- 通过 `PreToolUse` Hook 追踪工具调用次数
- 超过 50 次调用后建议压缩（`COMPACT_THRESHOLD` 可配置）
- 之后每 25 次调用提醒一次

**建议压缩的时机**：

1. 完成探索阶段后
2. 架构方案定稿后
3. 从研究转向实现时
4. 逻辑里程碑完成时

### 3. 持续学习

自动从会话中提取可复用模式，保存到 `~/.claude/skills/learned/`：

**提取配置**：

> [!example]- 抽取阈值
> | 配置项 | 值 | 说明 |
> |--------|-----|------|
> | `min_session_length` | 10 | 跳过太短的会话 |
> | `extraction_threshold` | medium | 提取阈值 |

**检测的模式类型**：

> [!example]- 模式类型
> | 模式 | 说明 |
> |------|------|
> | `error_resolution` | 错误解决方案（原因 → 修复 → 可复用性） |
> | `user_corrections` | 用户纠正的操作 |
> | `workarounds` | 库或 API 的变通方法 |
> | `debugging_techniques` | 非显而易见的调试技术 |
> | `project_specific` | 项目特定的约定和架构 |

**忽略的模式**：

- `simple_typos` - 简单拼写错误
- `one_time_fixes` - 一次性修复
- `external_api_issues` - 外部 API 问题

---

## 角色上下文

三种工作模式，各有不同的工具偏好和工作流：

> [!example]- 角色行为
> | 模式 | 文件 | 核心原则 | 偏好工具 |
> |------|------|----------|----------|
> | **开发** | `dev.md` | 先让它跑 → 改对 → 改干净 | Edit, Write, Bash |
> | **研究** | `research.md` | 理解 → 探索 → 假设 → 验证 | Read, Grep, WebSearch |
> | **审查** | `review.md` | 质量/安全/可维护性优先 | Read, Grep, Glob |

---

## 上下文窗口管理

### 避免最后 20% 区域执行的任务

> [!warning]
> - 大规模重构
> - 跨多文件的功能实现
> - 复杂交互调试

### 适合低上下文敏感度的任务

> [!tip]
> - 单文件编辑
> - 独立工具函数创建
> - 文档更新
> - 简单 Bug 修复

### 模型选择策略

> [!example]- 模型策略
> | 模型 | 适用场景 | 特点 |
> |------|----------|------|
> | **Haiku 4.5** | 轻量 Agent、高频调用 | 90% Sonnet 能力，3x 成本节省 |
> | **Sonnet 4.5** | 主开发、多 Agent 编排 | 最佳编码模型 |
> | **Opus 4.5** | 复杂架构决策、深度研究 | 最强推理能力 |

---

## 目录结构

> [!example]- 目录示意
> ```
> ~/.claude/
> ├── sessions/                      # 会话文件
> │   ├── {DATE}-session.tmp         # 会话状态
> │   └── compaction-log.txt         # 压缩事件日志
> │
> ├── skills/
> │   └── learned/                   # 自动提取的可复用模式
> │       └── [pattern-name].md
> │
> └── settings.json                  # Hook 配置
> 
> everything-claude-code/
> ├── contexts/                      # 角色上下文
> │   ├── dev.md
> │   ├── research.md
> │   └── review.md
> │
> ├── hooks/
> │   ├── hooks.json                 # Hook 配置
> │   ├── memory-persistence/        # 会话持久化脚本
> │   └── strategic-compact/         # 压缩建议脚本
> │
> ├── skills/
> │   └── continuous-learning/       # 持续学习配置
> │
> ├── commands/
> │   └── learn.md                   # /learn 命令
> │
> └── rules/
>     └── performance.md             # 上下文窗口管理规则
> ```

---

## 快速参考

### Hook 事件类型

> [!example]- Hook 流转
> | Hook | 触发时机 | 用途 |
> |------|----------|------|
> | `SessionStart` | 新会话开始 | 加载历史上下文 |
> | `PreToolUse` | 工具调用前 | 追踪调用次数、建议压缩 |
> | `PreCompact` | 上下文压缩前 | 保存当前状态 |
> | `Stop` | 会话结束 | 保存会话、提取模式 |

### 关键命令

> [!important]- 命令能力
> | 命令 | 作用 |
> |------|------|
> | `/learn` | 手动触发模式提取 |

^context-quick-reference

---

## 相关资源

- [[Claude_Code_核心工作流]]
- [[Claude_Code_Skill迭代复盘指南]]
- [everything-claude-code GitHub](https://github.com/affaan-m/everything-claude-code)
