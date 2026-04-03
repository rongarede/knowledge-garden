---
title: Gas 优化方案
aliases: ["Solidity Gas 优化", "合约 Gas 优化清单", "低成本 Solidity"]
tags: ["区块链/Solidity"]
up: "[[_blockchain_moc]]"
status: active
maturity: budding
---

# Solidity Gas 优化方案

Gas 优化核心是减少 `storage` 写入、降低不必要计算、选择更合适的数据结构与可见性。

## 优化清单

1. 减少链上数据：优先 `event` 或离线存储，显著降低写入成本。
2. 使用 `mapping` 替代频繁遍历的 `array`：查找更稳定。
3. 使用 `constant` / `immutable`：不占用常规存储槽。
4. 清理未使用变量与冗余计算。
5. 对可回收场景使用 `delete` 触发退款机制。
6. 在明确场景使用固定长度数组。
7. 非打包场景优先 `uint256`。
8. 合理做变量打包（packing）。
9. 参数较多且外部调用频繁时优先 `external`。
10. 打开编译器优化参数。
11. 必要时使用内联 assembly 做局部性能优化。

相关笔记：[[Array 与 Mapping]]。

## 经验规则

优先优化"高频路径 + storage 写入"，再优化语法细节，收益更稳定。

注意：过度优化会降低可读性和可审计性；安全与可维护性通常优先于极限 gas 节省。
