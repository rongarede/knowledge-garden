---
title: "Safe Wallet（原 Gnosis Safe）介绍"
aliases: ["Safe Wallet（原 Gnosis Safe）介绍", "Safe Wallet 以太坊多签钱包", "SafeWallet以太坊多签钱包"]
tags: ["区块链/基础设施"]
up: "[[_blockchain_moc]]"
status: active
maturity: budding
---

# Safe Wallet（原 Gnosis Safe）介绍

## 项目简介

Safe 是一个基于以太坊的多签智能合约钱包系统，原名 Gnosis Safe，现更名为 Safe，官网：https://safe.global/wallet

被广泛用于 DAO 金库、DeFi 项目托管、跨链资产管理等场景。

## 项目目标

- 提供安全、灵活、可扩展的资产管理方式
- 支持多方共管、模块化治理、合约升级等功能

## 核心功能

- 多签机制：设定 N 个 owner，指定 M-of-N 的签名阈值
- 模块化架构：支持权限控制模块、限额模块、Timelock 等插件
- 支持托管所有 ERC20/ERC721 资产
- 可升级架构（基于代理合约 Proxy 实现）
- EIP-1271 合约签名支持（合约账户可验证签名）

## 技术实现

- 使用 CREATE2 部署，地址可预测
- 所有钱包通过 Proxy 共享逻辑合约，节省 gas
- 采用 OpenZeppelin 安全库与权限控制逻辑
- 提供前端控制面板和 Safe SDK，适用于集成开发

## 使用场景

- DAO 社区治理与资金释放（如 Snapshot + Safe 模块联动）
- NFT 项目托管稀有资产与操作白名单
- 跨链资金托管与资产桥接
- 融资资金锁仓与逐步释放

## 前端功能（https://safe.global/wallet）

- 创建 Safe 钱包：配置 owner 和阈值
- 提交交易提案（转账、合约调用）
- 多方签名后执行交易
- 管理资产、查看历史交易、安装模块

## 相关资源

- 官方文档：https://docs.safe.global
- GitHub 源码：https://github.com/safe-global
- 模块市场：https://safe.global/apps
- Safe SDK 开发工具：https://docs.safe.global/safe-core

## 总结

Safe 是 Web3 生态中最广泛采用的智能合约多签钱包标准，兼具安全性、可拓展性和模块化，是 DAO 与 DeFi 项目的首选金库系统。
