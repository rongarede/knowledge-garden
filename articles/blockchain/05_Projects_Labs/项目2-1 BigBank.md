---
title: "Solidity Bank 项目（4+1 架构视图模型）"
aliases: ["Solidity Bank 项目（4+1 架构视图模型）", "Solidity Bank 项目（4+1 架构视图模型）笔记", "Solidity Bank 项目（4+1 架构视图模型）总结"]
tags: [区块链/项目]
up: "[[_blockchain_moc]]"
status: active
maturity: budding
---

# Solidity Bank 项目（4+1 架构视图模型）

## 1. 逻辑视图（Logical View）

### 模块与职责

- `Bank`：主合约，处理存款、提款、余额记录、排行榜维护。
- `BigBank`：继承自 Bank，添加存款下限和 owner 转移能力。
- `IBank`：接口，规范外部合约对 `withdraw()` 的调用方式。
- `Admin`：拥有独立 owner，可调用 Bank/BigBank 的 `withdraw` 接口进行集中资金管理。

### 模块依赖结构

- `Admin` → 调用 `IBank`
- `BigBank` ← 继承自 `Bank`
- 所有合约通过 `Ownable` 控制访问权限

## 2. 开发视图（Development View）

### 项目目录结构

```
modoule2/
└── Bank/
    ├── src/
    │   ├── Bank.sol
    │   ├── BigBank.sol
    │   ├── Admin.sol
    │   └── IBank.sol
    ├── test/
    │   └── BigBankSystem.t.sol
    └── foundry.toml
```

### 依赖与工具

- 使用 Foundry 作为开发与测试框架（`forge`）
- 引入 OpenZeppelin 的 `Ownable` 模块进行权限控制

## 3. 进程视图（Process View）

### 用户存款流程

- 用户调用 `deposit()` 或直接转账触发 `receive()`
- 更新 `balances[msg.sender]`
- 更新排行榜 `topDepositors`（最多 4 次 SSTORE）

### Admin 提取流程

- Admin.owner 调用 `adminWithdraw(IBank bank)`
- Admin 检查自己是否为 Bank 的 owner
- 调用 `bank.withdraw()` 将资金转入 Admin 合约

### 错误流程

- 存款不足 BigBank 限额 → revert
- 非 adminOwner 调用 `adminWithdraw()` → revert
- Admin 非 bank.owner → revert

## 4. 物理视图（Deployment View）

### 部署关系

- Step 1：部署 BigBank
- Step 2：部署 Admin
- Step 3：BigBank.transferOwnership(Admin)

### 权限关系

- `Bank`/`BigBank` 由 Admin 管理
- `Admin` 拥有独立 `owner`，负责调用多个 Bank 的 withdraw 权限

### 调用结构

```
Admin.owner
    ↓
[Admin]
    ↓ 调用
[BigBank (owner = Admin)]
```

## 5. 场景视图（Use Case View）

### 功能用例

- 用户 A 成功存款 → 余额更新、可能进入排行榜
- 用户 A 存款不足 → BigBank revert
- Admin.owner 调用 adminWithdraw → 提取成功
- 非 Admin.owner 调用 → revert
- Admin 调用非托管合约 → revert

### 测试覆盖（Foundry）

- `testMinDepositRequirement()`：存款下限校验
- `testAdminWithdraw()`：提现成功验证
- `testOnlyAdminOwnerCanWithdraw()`：权限验证
- `testAdminMustBeBankOwner()`：托管验证

## 总结

本项目实现了一个模块化的 Bank 系统，具备余额记录、排行榜功能、最低存款限制和集中提款权限。使用 OpenZeppelin Ownable 管理权限，通过 IBank 接口与 Admin 合约实现权限抽象，支持权限委托、升级扩展和结构清晰的安全边界。

GitHub link: https://github.com/rongarede/denglian/tree/main/modoule2/BigBank
