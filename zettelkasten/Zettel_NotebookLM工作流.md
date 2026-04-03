---
title: NotebookLM 工作流
date: 2026-01-15
tags:
  - atom
  - workflow
  - NotebookLM
  - Obsidian
  - automation
up: "[[_zettel_index]]"
status: evergreen
uid: 20260115220106
related:
  - "[[Zettel_NotebookLM能力矩阵]]"
  - "[[Zettel_知识砖块构建流程]]"
source: "[[Task_NotebookLM与Obsidian结合调研]]"
maturity: evergreen
---

# NotebookLM 工作流

> [!abstract] 核心观点
> NotebookLM 作为深度分析引擎，通过管道导出将产出沉淀到 Obsidian，形成「分析 → 导出 → 沉淀」的完整工作流。

## 笔记内容

### 信息生命周期

```
┌─────────────────────────────────────────────────────────────┐
│                      信息生命周期                            │
├─────────────────────────────────────────────────────────────┤
│   【输入层】          【处理层】           【沉淀层】         │
│   YouTube ──┐                                               │
│   PDF ──────┼──→ NotebookLM ──→ 深度分析 ──→ Obsidian      │
│   Web URL ──┤       │              │         (Zettelkasten) │
│   Google ───┘       │              │              │         │
│   Drive             ▼              ▼              ▼         │
│                 Podcast        Markdown      知识砖块       │
│                 Quiz           摘要          双链网络       │
│                 Video          见解          长期积累       │
└─────────────────────────────────────────────────────────────┘
```

### 导出路径

| 导出类型 | 命令示例 | 输出格式 |
|----------|----------|----------|
| 问答文本 | `notebooklm ask "问题" > output.md` | Markdown |
| 信息图表 | `notebooklm download infographic` | PNG/SVG |
| 音频播客 | `notebooklm download audio` | MP3 |
| 视频 | `notebooklm download video` | MP4 |
| 报告 | `notebooklm download report` | PDF/MD |

### 实用管道

```bash
# 问答结果写入 Obsidian Inbox
notebooklm ask "总结核心观点" > ~/Obsidian/000_Inbox/capture.md

# 结合 Claude 转 Zettel 格式
notebooklm ask "分析要点" | claude "转为 Zettel 格式" > ~/Obsidian/Zettelkasten/xxx.md
```

### 元数据扩展

```yaml
source:
  type: notebooklm
  artifact_type: ask  # ask | infographic | podcast | quiz
  notebook_id: "..."
  query: "生成此笔记时的问题"
```

## 关联引用

- **向上索引**: [[_zettel_index]]
- **同级相关**: [[Zettel_NotebookLM能力矩阵]], [[Zettel_知识砖块构建流程]]

## 参考资料

- [notebooklm-py GitHub](https://github.com/teng-lin/notebooklm-py)
