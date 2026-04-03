---
title: AMOC 框架
date: 2026-01-15
tags:
  - atom
  - concept
  - knowledge-management
  - AMOC
  - Obsidian
up: "[[_zettel_index]]"
status: evergreen
uid: 20260115220102
related:
  - "[[Zettel_PARA方法]]"
  - "[[Zettel_Obsidian目录结构设计]]"
source: "[[Obsidian_笔记系统重构方案]]"
maturity: evergreen
---

# AMOC 框架

> [!abstract] 核心观点
> AMOC（Automatic MOC）是基于 Obsidian 双链 + Dataview 的自动索引框架，通过 `up::` 属性建立笔记层级关系，自动生成 MOC（内容地图）。

## 笔记内容

### 核心机制

1. **`up::` 属性**：每个笔记通过 YAML frontmatter 中的 `up` 字段指向其上层索引
2. **Dataview 查询**：MOC 页面通过 Dataview 自动聚合所有指向它的子笔记
3. **双向关联**：形成自动维护的树状结构

### 优势

- **不依赖文件夹路径**：移动文件不影响逻辑结构
- **专注笔记内容**：链接关系自动维护
- **充分发挥双链特性**：Obsidian 原生能力的最佳实践

### MOC 自动生成代码

```dataview
TABLE file.ctime AS "创建时间", status AS "状态"
FROM ""
WHERE contains(up, this.file.link)
SORT file.ctime DESC
```

### 与 PARA 的结合

```
PARA 文件夹 (物理结构) + AMOC 双链 (逻辑结构) + Tags (属性标记)
         ↓                      ↓                    ↓
     粗粒度分类              笔记间关联            细粒度筛选
```

## 关联引用

- **向上索引**: [[_zettel_index]]
- **同级相关**: [[Zettel_PARA方法]], [[Zettel_Obsidian目录结构设计]]

## 参考资料

- [Obsidian双链框架AMOC - 少数派](https://sspai.com/post/85945)
- [Obsidian双链框架AMOC - Obsidian 中文论坛](https://forum-zh.obsidian.md/t/topic/29384)
