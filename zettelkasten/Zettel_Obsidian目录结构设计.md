---
title: Obsidian 目录结构设计
date: 2026-01-15
tags:
  - atom
  - config
  - knowledge-management
  - Obsidian
  - PARA
up: "[[_zettel_index]]"
status: evergreen
uid: 20260115220103
related:
  - "[[Zettel_PARA方法]]"
  - "[[Zettel_AMOC框架]]"
source: "[[Obsidian_笔记系统重构方案]]"
maturity: evergreen
---

# Obsidian 目录结构设计

> [!abstract] 核心观点
> 基于 PARA + AMOC 的 Obsidian 目录结构，使用数字前缀（000-500）实现物理分类与逻辑索引的统一。

## 笔记内容

### 目录结构

```
Vault/
├── 000_Inbox/                    # 快速捕获箱
│   └── _inbox_index.md           # Inbox MOC
│
├── 100_Projects/                 # 进行中的项目
│   ├── _projects_index.md        # Projects MOC
│   └── Project_XXX/
│
├── 200_Areas/                    # 长期领域
│   ├── _areas_index.md           # Areas MOC
│   └── Area_XXX/
│       └── _xxx_moc.md           # 领域 MOC
│
├── 300_Resources/                # 资源库
│   ├── _resources_index.md       # Resources MOC
│   ├── Zettelkasten/             # 原子化知识卡片
│   ├── Assets/                   # 附件资源
│   └── Templates/                # 模板
│
├── 400_Archives/                 # 存档
│   └── _archives_index.md        # Archives MOC
│
├── 500_Journal/                  # 日志
│   ├── Daily/
│   └── Weekly/
│
└── _Home.md                      # 全局入口
```

### 设计原则

1. **数字前缀**：确保目录在文件系统中有序排列
2. **下划线开头**：索引文件（`_xxx_index.md`）置顶显示
3. **一致命名**：`Project_`、`Area_`、`Res_` 前缀标识类型

### 索引层级

```
_Home.md (顶层)
    ↓
_xxx_index.md (分类索引)
    ↓
_xxx_moc.md (领域 MOC)
    ↓
具体笔记
```

## 关联引用

- **向上索引**: [[_zettel_index]]
- **同级相关**: [[Zettel_PARA方法]], [[Zettel_AMOC框架]]

## 参考资料

- [PARA Method in Obsidian](https://mattgiaro.com/para-obsidian/)
