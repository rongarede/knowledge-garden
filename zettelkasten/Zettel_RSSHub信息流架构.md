---
title: RSSHub 信息流架构
date: 2026-01-15
tags:
  - atom
  - architecture
  - RSS
  - RSSHub
  - Claude
  - automation
up: "[[_zettel_index]]"
status: evergreen
uid: 20260115220107
related:
  - "[[Zettel_NotebookLM工作流]]"
source: "[[Task_使用ClaudeCode对RSS每日信息源进行分析]]"
maturity: evergreen
---

# RSSHub 信息流架构

> [!abstract] 核心观点
> 通过私有 RSSHub 服务将 Twitter/YouTube 等平台转换为 RSS，结合 Claude Code 实现每日信息的自动抓取与分析。

## 笔记内容

### 架构概览

```
┌─────────────┐    ┌──────────────┐    ┌─────────────────┐
│   Reeder    │───▶│  OPML 文件   │───▶│   Claude Code   │
│   (订阅)    │    │ (订阅源列表) │    │   (分析/抓取)   │
└─────────────┘    └──────────────┘    └─────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────┐
│                    私有 RSSHub 服务                      │
│              http://107.173.89.210:1200                 │
│  ┌─────────┐  ┌─────────┐  ┌─────────┐  ┌─────────┐    │
│  │ Twitter │  │ YouTube │  │ Medium  │  │  其他   │    │
│  │   RSS   │  │   RSS   │  │   RSS   │  │  来源   │    │
│  └─────────┘  └─────────┘  └─────────┘  └─────────┘    │
└─────────────────────────────────────────────────────────┘
```

### 关键配置

| 类型 | 路径/地址 |
|------|-----------|
| OPML 订阅源 | `/Users/bit/Obsidian/Reeder/Reeder.opml` |
| RSSHub 服务 | `http://107.173.89.210:1200` |

### 订阅源统计

| 分类               | 数量     | 示例                            |
| ---------------- | ------ | ----------------------------- |
| YouTube 频道       | 10     | AI超元域、Anthropic、登链社区          |
| Twitter (RSSHub) | 19     | Elon Musk、余弦、0xWizard         |
| Articles         | 6      | CoinDesk、SlowMist、OpenAI News |
| **总计**           | **37** | -                             |
|                  |        |                               |

### 使用方法

```bash
# 每日信息抓取
claude "读取 ~/Obsidian/Reeder/Reeder.opml，抓取所有订阅源的最新文章"

# 特定源抓取
curl -s "http://107.173.89.210:1200/twitter/user/elonmusk"
```

### 核心优势

- **RSSHub**：将非 RSS 平台转换为标准 RSS
- **Claude Code**：并发抓取 + 智能分析
- **Reeder**：统一管理订阅，导出 OPML

## 关联引用

- **向上索引**: [[_zettel_index]]
- **同级相关**: [[Zettel_NotebookLM工作流]]

## 参考资料

- [RSSHub 文档](https://docs.rsshub.app/)
