---
title: "ETH CLI钱包项目 - 4View 架构简版"
aliases: ["ETH CLI钱包项目 - 4View 架构简版", "ETH CLI钱包", "cliWallet 架构笔记"]
tags: [区块链/项目]
up: "[[_blockchain_moc]]"
status: active
maturity: budding
---

# ETH CLI钱包项目 - 4View 架构简版

## 项目概述

- ETH CLI钱包是一个基于 Viem.js 和 TypeScript 构建的以太坊命令行钱包应用
- 专为 Base 网络优化，支持钱包管理、余额查询和 ERC20 代币转账功能
- 采用模块化设计，提供命令行和交互式两种使用模式

## 1. 逻辑视图（Logical View）

### 核心模块

- `wallet.ts`：钱包管理——生成、导入、存储
- `balance.ts`：余额查询——ETH、ERC20、网络信息
- `transfer.ts`：转账功能——EIP-1559 转账、Gas 估算
- `cli.ts`：命令行界面——菜单、输入校验、错误处理

### 模块关系

- cli.ts 调用 wallet / balance / transfer
- balance.ts 与 transfer.ts 通过 Viem.js 与区块链交互

## 2. 开发视图（Development View）

### 技术栈

- TypeScript + Viem.js
- Commander.js / Inquirer.js

### 项目结构

- src/cli.ts（入口）
- src/wallet.ts（钱包）
- src/balance.ts（余额）
- src/transfer.ts（转账）

### 运行

npm install → npm run build → npm run cli

## 3. 进程视图（Process View）

### 钱包创建流程

生成私钥 → 显示地址 → 选择是否保存

### 余额查询流程

选择地址 → 查询 ETH 或 ERC20 → 显示结果

### 转账流程

加载钱包 → 输入参数 → 估算 Gas → 签名发送

## 4. 物理视图（Physical View）

### 本地部署

Node.js 环境 + 本地 wallet.json

### 网络连接

直连 Base 网络 RPC 节点（HTTPS/WSS）

### 安全设计

私钥仅本地存储，交易本地签名

## 项目特性

- 钱包管理
- 余额查询
- 智能转账

## 扩展路线

短期：
- 支持更多网络
- 批量转账
- 历史查询

长期：
- 多签钱包
- DeFi
- NFT
- 硬件钱包
