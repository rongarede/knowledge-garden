---
title: "学习任务清单：Solana 简单 Mint / Transfer Token 程序（概念驱动版）"
aliases: ["学习任务清单：Solana 简单 Mint / Transfer Token 程序（概念驱动版）", "Mint___Transfer Token 程序", "Mint Transfer Token 程序"]
tags: ["区块链/Solana"]
up: "[[_blockchain_moc]]"
status: active
maturity: sprout
---

# 学习任务清单：Solana 简单 Mint / Transfer Token 程序（概念驱动版）

## 阶段 1：Solana 基础概念

- DONE 了解 Solana 的账户模型
  - 什么是账户（Account）
  - [[Mint Account 与 Token Account 的区别]]
  - `owner` 与 `authority` 的区别
  - Rent 与 Rent Exempt
- DONE 理解 PDA（Program Derived Address）
  - 为什么 PDA 没有私钥
  - PDA 的 seeds、bump 概念
  - PDA 的应用场景（资金池、托管账户、配置账户）
  - [[区块生态位对照]]
- DONE 理解 SOL 与 SPL Token 的关系
  - SOL 是原生代币
  - [[SPL Token]] 是标准化代币协议

## 阶段 2：Anchor 框架核心概念

- DONE Anchor 项目结构（programs/、tests/、Cargo.toml、Anchor.toml）
- DONE `#[program]` 宏如何定义程序入口
- DONE `#[account]` 宏如何声明账户数据结构
- DONE `#[derive(Accounts)]` 如何声明和校验账户上下文
- DONE CpiContext 和 CPI（跨程序调用）的作用[[流程图]]

## 阶段 3：SPL Token 程序相关概念

- DONE SPL Token Program 的职责
- DONE `mint_to` 的作用与账户要求
- DONE `transfer` 的作用与账户要求
- DONE CPI 调用时的账户顺序与权限验证

## 阶段 4：扩展与概念迁移

- TODO 将 Mint Authority 改为 PDA 管理（理解 invoke_signed）
- TODO 添加 Burn 功能（理解销毁代币的流程）
- TODO 添加事件（emit!）并理解链上事件日志
- TODO 思考如何把 Token Account 概念迁移到 AMM、借贷、质押等协议
