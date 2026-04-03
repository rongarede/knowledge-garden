---
title: Gasless Claim（零 Gas 领取）
aliases: ["零 Gas 领取", "Gasless Claim", "Meta Transaction 领取"]
tags: ["区块链/Solidity"]
up: "[[_blockchain_moc]]"
status: active
maturity: budding
---

# Gasless Claim（零 Gas 领取）

Gasless Claim 通过 Meta-Transaction 让用户只签名、不直接付 gas，由 Relayer 代发交易并完成链上领取。

## What（它是什么）

- 用户无需自行支付 gas 即可领取 Token、NFT、积分或奖励。
- 常见模式：用户签名，Relayer 代为提交交易。

## Why（为什么需要）

- 降低新用户上手门槛，提升领取转化率。
- 适合移动端、教育场景、活动运营等 gas 敏感人群。

## When（使用场景）

- Airdrop 零 gas 领取。
- GameFi 每日任务奖励。
- DAO 投票权或凭证领取。
- 学习平台认证奖励分发。

## Where（系统中位置）

- 合约提供 `claimWithSig()` 一类签名领取接口。
- 后端 Relayer 服务接收签名后代发交易。
- 合约端验证签名后执行发放逻辑。

## How（如何实现）

- 使用 EIP-712 结构化签名。
- 合约通过 `ecrecover` 或相关库恢复签名者。
- 使用 nonce 防止重放。
- 可结合 OpenZeppelin 的 `ERC2771Context`。

注意：若 nonce、domain separator 或过期时间校验缺失，容易出现重放攻击或跨域签名滥用。

Gasless 只改变"谁付 gas"，不改变合约安全边界；签名验证和权限校验必须完整。
