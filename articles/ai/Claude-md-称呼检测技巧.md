---
title: CLAUDE.md 称呼检测技巧
aliases: [称呼金丝雀, CLAUDE 指令检测, canary 检测]
date: 2026-01-24
tags: [AI/Claude, AI/提示词, AI/技巧]
up: "[[_ai_moc]]"
status: active
maturity: seed
---

# CLAUDE.md 称呼检测技巧

## 概述

> [!abstract]
> 这个方法把一个稳定、可观测的称呼作为 ==金丝雀信号==，用来检测 Claude 是否仍在遵循 `CLAUDE.md` 中的关键指令。

^claude-md-overview

---

## 核心思路

在 `CLAUDE.md` 里加一条指令：

> [!example]- 指令示例
> ```
> 每次回复时都叫我【名称】
> ```

^claude-md-core

---

## 检测方法

> [!warning]
> 如果 Claude 突然不叫你这个称呼，说明它开始忽略 `CLAUDE.md` 了。
>
> 这时需要**重置上下文**。

^claude-md-detect

---

## 类比

很像范海伦乐队在合同里要求「不能有棕色 M&M 豆」一样。

看似无关细节，恰恰能检验有没有 Follow 指令。

> [!tip] 金丝雀检测
> 这本质是一个「金丝雀」机制，用一个简单、可观测的行为来检测系统状态。

^claude-md-analogy
