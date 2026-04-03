---
title: Codemap 代码地图概念
aliases: [代码地图, Codemap 方法, AI 架构文档]
date: 2026-01-22
tags: [AI/Claude, AI/文档, AI/架构]
up: "[[_ai_moc]]"
status: active
maturity: budding
---

# Codemap 代码地图

> [!abstract]
> ==Codemap== 是一种**为 AI 优化的代码架构文档**，用 token 高效的方式描述代码库结构，使 LLM 能快速理解项目全貌。

^codemap-overview

---

## 核心理念

> [!example]- 传统文档与 AI 文档的差异
> ```
> 传统文档 → 给人读 → 叙述性、详细、冗余
> Codemap  → 给 AI 读 → 结构化、精简、高信息密度
> ```

### 为什么需要 Codemap？

> [!example]- 场景对照
> | 问题 | 传统方案 | Codemap 方案 |
> |------|----------|--------------|
> | AI 理解代码库 | 读全部源码 (token 爆炸) | 读 codemap (< 500 行) |
> | 找入口点 | grep / 人工指引 | 明确列出 Entry Points |
> | 理解依赖 | 分析 import | 依赖表格 + 架构图 |
> | 上下文恢复 | 重复解释 | 直接引用 codemap |

^codemap-reason

---

## Codemap 结构

### 标准文件组织

> [!example]- 文件组织
> ```
> docs/codemaps/
> ├── INDEX.md          # 项目总览、架构图、核心流程
> ├── backend.md        # 后端/API 结构
> ├── frontend.md       # 前端结构
> ├── database.md       # 数据模型
> └── integrations.md   # 外部服务集成
> ```

### 单文件模板

> [!example]- 单文件模板
> ```markdown
> # [Area] Codemap
> 
> **Last Updated:** YYYY-MM-DD
> **Entry Points:** 主要入口文件
> 
> ## Architecture
> 
> [ASCII 架构图]
> 
> ## Key Modules
> 
> | Module | Purpose | Exports | Dependencies |
> |--------|---------|---------|--------------|
> | ... | ... | ... | ... |
> 
> ## Data Flow
> 
> [数据流描述]
> 
> ## External Dependencies
> 
> - package-name - Purpose, Version
> ```

^codemap-template

---

## 核心特征

### 1. Token 高效

> [!example]- 优化目标
> ```
> 目标：< 500 行 / codemap
> 手段：
>   - 表格替代长文
>   - ASCII 图替代详述
>   - 只记架构，不记实现
> ```

### 2. 机器可读

> [!example]- 不宜做法
> ```
> ✅ 结构化表格
> ✅ 统一格式
> ✅ 明确的文件路径
> ✅ 可验证的入口点
> 
> ❌ 散文式描述
> ❌ 模糊的指代
> ❌ 过期的信息
> ```

### 3. 自动生成

> [!example]- 自动链路
> ```
> 源代码
>    │
>    ▼
> 分析工具 (ts-morph, madge, AST)
>    │
>    ▼
> 生成 Codemap
>    │
>    ▼
> 人工审核 (可选)
> ```

---

## 生成工具链

> [!example]- 工具对照
> | 工具 | 用途 | 语言 |
> |------|------|------|
> | ts-morph | AST 分析 | TypeScript |
> | madge | 依赖图 | JS/TS |
> | rust-analyzer | 结构分析 | Rust |
> | jsdoc-to-markdown | 文档提取 | JS/TS |

---

## 使用场景

### 1. AI 辅助开发

> [!example]- 查询路径
> ```
> 用户: 帮我在 ipflow 项目添加新功能
> AI:   [读取 codemaps/INDEX.md]
>       → 理解架构
>       → 定位修改点
>       → 生成代码
> ```

### 2. 项目交接

> [!example]- 交接路径
> ```
> 新人/AI 加入项目
>       │
>       ▼
> 读取 codemaps (10 分钟)
>       │
>       ▼
> 理解架构、入口、依赖
>       │
>       ▼
> 开始贡献代码
> ```

### 3. 代码审查

> [!example]- 审查路径
> ```
> PR 提交
>    │
>    ▼
> AI 读取 codemap + diff
>    │
>    ▼
> 理解变更对架构的影响
>    │
>    ▼
> 生成审查意见
> ```

---

## 更新策略

### 触发条件

> [!example]- 更新建议
> | 变更类型 | 是否更新 |
> |----------|----------|
> | 新增模块/文件 | ✅ 必须 |
> | API 变更 | ✅ 必须 |
> | 依赖增删 | ✅ 必须 |
> | 重构 (接口不变) | ⚪ 可选 |
> | Bug 修复 | ❌ 不需要 |

### 差异检测

> [!example]- 阈值规则
> ```
> 变更 ≤ 30%  → 自动更新
> 变更 > 30%  → 人工确认
> ```

---

## 与其他概念的关系

> [!example]- 文档层次关系
> ```
> ┌─────────────────────────────────────────────────┐
> │                  文档体系                        │
> ├─────────────────────────────────────────────────┤
> │                                                 │
> │  README.md          → 给用户，如何使用           │
> │  CONTRIBUTING.md    → 给贡献者，如何参与          │
> │  Codemap            → 给 AI，代码结构            │
> │  API Docs           → 给开发者，接口定义          │
> │  AGENTS.md          → 给 AI Agent，行为指引      │
> │                                                 │
> └─────────────────────────────────────────────────┘
> ```

---

## 最佳实践

> [!important]- 五个原则
> 1. **Single Source of Truth** - 从代码生成，不手动编写
> 2. **时间戳** - 必须包含 Last Updated 日期
> 3. **可验证** - 列出的文件路径必须真实存在
> 4. **精简** - 每个 codemap < 500 行
> 5. **版本控制** - 纳入 git 管理

^codemap-best-practice

---

## 相关链接

- [[Claude_Code_核心工作流]] - 使用 codemap 的开发流程
- [[Claude_Code_Skill迭代复盘指南]] - Skill 开发中的文档管理

---

## 参考实现

- `ipflow-v3/docs/codemaps/` - Solana 项目示例
- Claude Code 的 `doc-updater` agent - 自动生成工具
