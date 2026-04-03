---
title: "BaseERC20 项目架构分析（4+1 View Model）"
aliases: ["BaseERC20 项目架构分析（4+1 View Model）", "BaseERC20 项目架构分析（4+1 View Model）笔记", "BaseERC20 项目架构分析（4+1 View Model）总结"]
tags: [区块链/项目]
up: "[[_blockchain_moc]]"
status: active
maturity: budding
---

# BaseERC20 项目架构分析（4+1 View Model）

## 1. 逻辑视图（Logical View）

### 模块组成与职责

- `BaseERC20`: 继承自 OpenZeppelin 的 ERC20，设置名称、符号、初始总量
- `ERC20`: 提供 transfer、approve、transferFrom、balanceOf、allowance 等核心接口
- `Context`: OpenZeppelin 工具类，用于安全地封装 msg.sender 和 msg.data

### 功能概览

- 设置 token 名称：BaseERC20
- 设置 token 符号：BERC20
- 总量：100,000,000 * 10^18
- 自动抛出 OpenZeppelin 标准异常
- 支持授权转账、余额查询、事件通知等

## 2. 开发视图（Development View）

### 项目目录结构（Foundry）

```
BaseERC20/
├── src/
│   └── BaseERC20.sol
├── lib/
│   └── openzeppelin-contracts/
├── test/
│   └── BaseERC20.t.sol
├── foundry.toml
```

### 开发工具链

- Solidity ^0.8.0
- Foundry 工具集（forge）
- 安装依赖：`forge install OpenZeppelin/openzeppelin-contracts`
- 编译命令：`forge build`
- 测试命令：`forge test`

## 3. 进程视图（Process View）

### 用户交互流程

- 部署合约：mint 总量到部署者地址
- 用户调用 transfer：检查余额、修改映射、发出事件
- 用户调用 approve：授权 spender
- spender 调用 transferFrom：检查余额与 allowance，更新状态

### 异常处理逻辑

- 余额不足：抛出 `"ERC20: transfer amount exceeds balance"`
- 授权不足：抛出 `"ERC20: transfer amount exceeds allowance"`

## 4. 物理视图（Deployment View）

### 部署方式

- 使用 Remix、Foundry、Hardhat 部署至本地链或测试网
- 可部署至：Goerli、Sepolia、Mainnet、本地 Anvil 节点

### EVM 状态映射结构

- `balances: mapping(address => uint256)`
- `allowances: mapping(address => mapping(address => uint256))`

## 5. 场景视图（Use Case View）

### 常见用例

- 部署合约，msg.sender 获得初始发行总量
- A 转账给 B，成功或余额不足抛错
- A 授权 B 使用代币 → B 调用 transferFrom
- B 转账超出授权额度 → 抛错

### 测试建议（配合 Foundry）

- `test_initial_supply_is_correct`
- `test_transfer_reverts_if_insufficient_balance`
- `test_transferFrom_reverts_if_insufficient_allowance`
- `test_approve_and_allowance`
- `test_successful_transfer_and_event_emission`
