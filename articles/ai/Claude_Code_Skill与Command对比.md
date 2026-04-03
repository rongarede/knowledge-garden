---
title: Claude Code Skill 与 Command 对比
aliases: [Skill vs Command, 扩展机制对比, Claude 扩展方式]
date: 2026-01-23
tags: [AI/Claude, AI/Skill, AI/命令]
up: "[[_ai_moc]]"
status: active
maturity: budding
---

# Skill vs Command：Claude Code 扩展机制对比

## 概述

> [!abstract]
> ==Skills== 与 ==Commands== 是 Claude Code 的两种扩展路径：前者定义能力与流程，后者定义触发与提效。

^skill-command-overview

---

## 核心定位

> [!example]- 定位对照
> | 维度 | **Skills (技能)** | **Commands (命令)** |     |
> | --- | ---------------------- | --------------------- | --- |
> | **存储路径** | `~/.claude/skills/` | `~/.claude/commands/` |     |
> | **核心定义** | 工作流定义 (How to do) | 快捷指令 (What to do) |     |
> | **复杂度** | 高：跨步骤任务、工具调用链 | 低：Prompt 模板、一键操作 |     |
> | **执行方式** | Claude 自动触发或 `/skill-name` | 用户 `/command` 手动触发 |     |
> | **设计意图** | 赋予 AI 新能力 | 提升用户效率 |     |

^skill-command-core

---

## 技术隐喻

> [!example]-
> ```
> Skills   ≈  库函数/类定义 (Libraries)
>              定义「如何处理 V2X 协议」「如何解析 Solana 交易"
> 
> Commands ≈  别名/脚本 (Aliases)
>              alias gcp='git cherry-pick'
>              不增加能力，但让执行变快
> ```

---

## 深度解析

### Skills：AI 的「新能力」

Skills 是给 AI 安装的**插件**，定义完整的处理流程。

**示例**：`自动化代码重构` Skill
- 搜索文件 → 分析依赖 → 应用宏 → 运行测试
- 安装后 Claude 知道「我学会了如何重构代码」

**特性**：**定义导向**，在对话中灵活运用。

### Commands：你的「快捷键」

Commands 是为**效率**设计的固化 Prompt。

**示例**：`/doc` 命令
- 内容：「为选中代码编写 Rustdoc 标准注释」
- 把繁琐 Prompt 固化成一个短单词

**特性**：**触发导向**，减少重复输入。

^skill-command-depth

---

## 为什么分离存储？

1. **独立迁移**
   - Commands（如 `/explain`）可跨项目复用
   - Skills（如 Jupiter 测试方案）仅在特定工程生效

2. **分层管理**
   - 简单 Prompt → Commands（保持简单）
   - 复杂逻辑 → Skills（保持模块化）

---

## 选择指南

> [!important]
> 先判断是不是“新增能力”。是能力扩展用 Skill；是高频触发用 Command。

> [!example]-
> ```
> 需要扩展 Claude 能力？
>     │
>     ├─ 是：复杂流程、多步骤、工具链
>     │      → 创建 Skill
>     └─ 否：固定 Prompt、一键触发
>            → 创建 Command
> ```

^skill-command-choice

---

## 文件结构示例

> [!example]- 目录结构
> ```
> ~/.claude/
> ├── skills/
> │   └── code-review/
> │       └── skill.md          # 定义审查流程
> └── commands/
>     └── doc.md                # /doc 快捷命令
> ```

---

## 相关链接

- [[Claude_Code_核心工作流]]
- [[Claude_Code_Skill迭代复盘指南]]
