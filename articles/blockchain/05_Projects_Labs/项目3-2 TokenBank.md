---
title: "TokenBank 项目架构分析（4+1 View Model）"
aliases: ["TokenBank 项目架构分析（4+1 View Model）", "TokenBank 项目架构分析（4+1 View Model）笔记", "TokenBank 项目架构分析（4+1 View Model）总结"]
tags: [区块链/项目]
up: "[[_blockchain_moc]]"
status: active
maturity: budding
---

# TokenBank 项目架构分析（4+1 View Model）

## 1. 逻辑视图（Logical View）

### 合约组件与职责

- `BaseERC20`：基础 [[ERC-20 同质化代币标准]] 代币，支持转账、授权、余额查询等标准功能
- `TokenBank`：用户可将 ERC20 存入并提取，负责代币的存取逻辑
- `IERC20`：标准接口，供 TokenBank 与 ERC20 合约交互

### 核心功能

- `deposit(amount)`：通过 `transferFrom` 将 token 转入银行，记录余额
- `withdraw(amount)`：从银行取出 token，通过 `transfer` 转账回用户
- `balances(address)`：查看用户在银行的存款数量

## 2. 开发视图（Development View）

### 推荐项目结构（Foundry）

```
TokenBank/
├── src/
│   ├── BaseERC20.sol
│   └── TokenBank.sol
├── test/
│   └── TokenBank.t.sol
├── foundry.toml
└── README.md
```

### 工具链与依赖

- Solidity ^0.8.0
- Foundry（forge, cast, anvil）
- [[OpenZeppelin库]]（用于引入 `IERC20` 接口）
- Git + GitHub（版本管理）

## 3. 进程视图（Process View）

### 用户存款流程

- 用户先调用 `approve(TokenBank, amount)`
- 再调用 `deposit(amount)` → TokenBank 调用 `transferFrom()`
- 成功转账后，更新 `balances[msg.sender] += amount`

### 用户取款流程

- 用户调用 `withdraw(amount)`
- TokenBank 校验余额后调用 `transfer()` → 将 token 发回用户
- 更新 `balances[msg.sender] -= amount`

### 失败路径处理

- 未授权或授权不足 → `transferFrom` 失败
- 余额不足 → `withdraw` 调用失败（require）

## 4. 物理视图（Deployment View）

### 合约部署关系

- Step 1：部署 `BaseERC20` 合约（或引用已有 Token 地址）
- Step 2：部署 `TokenBank` 合约，构造函数传入 token 地址

### 状态变量映射

- `token: IERC20` → 存储目标 ERC20 合约地址
- `balances: mapping(address => uint256)` → 每位用户的存款余额

## 5. 场景视图（Use Case View）

### 核心使用场景

- 用户存入代币 → 调用 `deposit()` 存入 100 token
- 用户提取代币 → 调用 `withdraw()` 提取 50 token
- 超额提取 → 触发 `require`，余额不足
- 未授权转账 → `transferFrom` 调用失败

### 建议测试用例

- `test_deposit_successful()`
- `test_withdraw_successful()`
- `test_withdraw_insufficient_balance()`
- `test_deposit_without_approval()`
