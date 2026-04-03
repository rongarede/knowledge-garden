---
title: Zettelkasten 规范
date: 2026-01-13
tags:
  - zettelkasten
  - standard
  - workflow
up: "[[_zettel_index]]"
status: active
maturity: budding
---

# Zettelkasten 规范

## 卡片类型

- **Fleeting**：临时想法、快速捕获（建议先进入 `000_Inbox/`）。
- **Literature**：阅读笔记与引用摘要（沉淀到 `300_Resources/Zettelkasten/`）。
- **Permanent**：永久知识卡片（沉淀到 `300_Resources/Zettelkasten/`）。

## 链接规范

- 每张卡片至少链接 1 个相关概念或来源笔记。
- 与 Area 领域绑定时，链接对应 Area MOC（如 `[[200_Areas/Area_区块链/_blockchain_moc]]`）。
- 主题标签使用 `#blockchain` / `#AI` / `#language` 等领域标签。

## 状态标准

- **未开始** → **进行中** → **已完成** → **待复审** → **已完成**
- `待复审` 代表需要在 Weekly Review 中重新核对与补充链接。

## Area → Zettel 引用模式

- Area MOC 通过链接或标签引用对应 Zettel。
- Zettel 需在正文或 `关联笔记` 中反向链接 Area MOC。

## Weekly Review 复审流程

- 每周集中检查 `status = "待复审"` 的卡片。
- 补充双链、来源与总结后将状态置为 `已完成`。
