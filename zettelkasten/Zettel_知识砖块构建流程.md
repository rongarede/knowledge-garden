---
title: 知识砖块构建流程
date: 2026-01-15
tags:
  - atom
  - workflow
  - knowledge-management
  - Zettelkasten
up: "[[_zettel_index]]"
status: evergreen
uid: 20260115220104
related:
  - "[[Zettel_PARA方法]]"
  - "[[Zettelkasten_规范]]"
source: "[[Task_构建知识砖块方案]]"
maturity: evergreen
---

# 知识砖块构建流程

> [!abstract] 核心观点
> 知识砖块（Zettel）的构建遵循「捕获 → 拆解 → 原子化」三阶段流程，通过 QuickAdd + Templater 实现自动化。

## 笔记内容

### 三阶段流程

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│   捕获层    │ → │   转化层    │ → │   沉淀层    │
│ (000_Inbox) │    │ (拆解提炼)  │    │(Zettelkasten)│
└─────────────┘    └─────────────┘    └─────────────┘
```

### 阶段详解

1. **捕获层**（Inbox）
   - 保持极简，只存原始信息
   - 使用 `tpl_quick.md` 快速记录
   - 不做任何加工

2. **转化层**（拆解）
   - 识别核心概念
   - 一个概念 = 一个砖块
   - 用自己的话重述

3. **沉淀层**（Zettelkasten）
   - 填充 `tpl_zettel.md` 模板
   - 建立 `up` 和 `related` 链接
   - 设置状态：seed → developing → evergreen

### 自动化配置

- **QuickAdd**：快捷键触发模板
- **Templater**：自动生成 UID、日期
- **Dataview**：动态聚合砖块视图

### 防止孤岛

- 强制性 `up` 属性指向上层 MOC
- 可选 `related` 数组关联同级概念
- 每周 Review 检查孤立笔记

## 关联引用

- **向上索引**: [[_zettel_index]]
- **同级相关**: [[Zettelkasten_规范]], [[Zettel_PARA方法]]

## 参考资料

- Sönke Ahrens《How to Take Smart Notes》
