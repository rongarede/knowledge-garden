---
title: "Merkle Airdrop（基于 Merkle Tree 的空投机制）【4W1H】"
aliases: ["Merkle Airdrop（基于 Merkle Tree 的空投机制）【4W1H】", "Merkle Airdrop（基于 Merkle Tree 的空投机制）【4W1H】笔记", "Merkle Airdrop（基于 Merkle Tree 的空投机制）【4W1H】总结"]
tags: [区块链/项目]
up: "[[_blockchain_moc]]"
status: active
maturity: budding
---

# Merkle Airdrop（基于 Merkle Tree 的空投机制）【4W1H】

## What（它是什么）

- Merkle Airdrop 是一种基于 Merkle Tree 数据结构实现的链上代币空投机制。
- 它将大批量用户数据（地址 + 空投数量）离线构建成 Merkle Tree，在链上只存储一个 `merkleRoot`。
- 用户领取代币时只需提交包含自己地址与数量的 Merkle Proof，合约即可验证其有效性并发放代币。
- 特点：高效、低成本、防止重复领取、支持大规模分发。

## Why（为什么需要）

- 传统的批量 `transfer` 空投需要项目方为每个地址发起交易，gas 成本极高。
- Merkle Airdrop 允许项目方只提交一次 Merkle Root，用户自行调用合约领取。

具有以下优势：
- 节省 gas（链上不存储每个地址，仅验证）
- 防止重复领取（合约记录状态）
- 数据加密结构安全透明
- 用户无需信任，可自行验证 Proof 正确性

## When（什么时候使用）

适用于以下场景：
- 大型代币 Airdrop（如 Uniswap、Optimism、ENS）
- 社区奖励发放（活跃用户、GitHub PR 贡献者）
- DAO 成员激励、治理投票权下发
- 测试网活动发币与激励任务分发

当空投名单超过几十人时，Merkle Tree 会比批量转账更节能、更灵活。

## Where（在哪些系统/项目中使用）

- Uniswap：UNI 代币首发空投
- Optimism：OP 第一季、第二季空投
- ENS：ENS 代币 Airdrop
- Arbitrum：ARB 空投与声誉积分发放
- Gitcoin：贡献者奖励与 CLR 公共激励发放

Merkle Airdrop 已成为大多数主流项目标准 Airdrop 方式。

## How（如何实现）

链下操作：
- 准备地址 + 空投金额列表
- 使用 `merkletreejs` 或 Python 构建 Merkle Tree
- 获取每个地址的 `leaf` 与对应 `proof`
- 生成 `merkleRoot` 并部署到链上合约中

合约结构：
- 存储常量 `bytes32 public merkleRoot`
- 映射 `mapping(address => bool) claimed` 记录已领取地址
- 核心函数 `claim(address, amount, proof[])`
  - 校验 `!claimed[caller]`
  - 使用 `MerkleProof.verify()` 验证合法性
  - 发放代币 + 标记已领取

Solidity 关键模块：
- 使用 OpenZeppelin 的 `MerkleProof` 库
- 使用 CEI 模式保证安全
- 可选加入 `Ownable` 控制权限

示例片段：

```solidity
function claim(address to, uint256 amount, bytes32[] calldata proof) external {
    require(!claimed[to], "Already claimed");
    bytes32 leaf = keccak256(abi.encodePacked(to, amount));
    require(MerkleProof.verify(proof, merkleRoot, leaf), "Invalid proof");
    claimed[to] = true;
    token.transfer(to, amount);
}
```
