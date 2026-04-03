---
title: Array 与 Mapping 对比
aliases: ["数组与映射", "Array Mapping 对比", "Solidity 数据结构对比"]
tags: ["区块链/Solidity"]
up: "[[_blockchain_moc]]"
status: active
maturity: budding
---

# Array 与 Mapping 对比

Array 适合有序且可遍历的数据，Mapping 适合按 key 快速读写。两者常组合使用：mapping 存值，array 记录顺序。

## 对比表

| 对比维度 | Array（数组） | Mapping（映射） |
|---|---|---|
| 定义 | 有序线性表，按索引存储 | 键值对哈希表，按 key 定位 |
| 访问方式 | `array[index]`，索引从 0 开始 | `mapping[key]`，key 可为 `address`、`uint` 等 |
| 可遍历性 | 支持 `for` 循环遍历 | 不支持直接遍历，需额外维护 key 列表 |
| 存储特性 | 连续槽位语义 | 哈希寻址到独立存储槽 |
| Gas 成本 | 遍历随长度线性增长 | 单次读写通常更稳定 |
| 优点 | 维护顺序、便于按序处理 | 查找快、按键访问简单 |
| 缺点 | 按值查找慢，增删成本高 | 无法直接遍历全部键 |
| 典型用途 | 排行榜、固定列表 | 用户余额、白名单、状态标记 |

## 结论

需要"顺序 + 遍历"选 Array；需要"按键快速访问"选 Mapping。

- 业务经常同时要求检索效率与可遍历性时，可组合建模。
- 相关笔记：[[代理合约]]、[[gas 优化方案]]。
