---
title: Transparent Proxy 模式
aliases: ["透明代理模式", "Transparent Upgradeable Proxy", "OZ 透明代理"]
tags: ["区块链/Solidity"]
up: "[[_blockchain_moc]]"
status: active
maturity: budding
---

# Transparent Proxy 模式

Transparent Proxy 是 OpenZeppelin 主推的可升级架构之一，升级权限集中在代理管理员，业务逻辑留在实现合约。

## What（是什么）

- 遵循 [[EIP-1967]] 存储槽标准。
- 代理合约负责转发调用与维护实现地址。
- 升级由管理员地址执行，逻辑合约本身不直接持有升级入口。
- 与 UUPS 相比，升级管理更"外置"。

## Why（为什么使用）

- 升级权限与业务逻辑分离，审计边界清晰。
- 逻辑合约更专注业务，不掺杂升级细节。
- 生态成熟，工具链支持完善。
- 适合对权限隔离要求高的场景。

## When（什么时候使用）

- 对安全与治理要求高的核心系统。
- 团队希望由专门角色/多签管理升级。
- 不希望逻辑合约直接暴露升级能力。
- 合约生命周期长、需要持续维护迭代。

## Where（应用场景）

- DAO 提案系统、治理模块。
- DeFi 主协议核心逻辑。
- 使用 `@openzeppelin/hardhat-upgrades` 的可升级项目。
- 长生命周期业务合约（质押、奖励、权限系统等）。

## How（如何实现）

- 部署 Implementation（业务逻辑 + `initialize()`）。
- 部署 `TransparentUpgradeableProxy`（实现地址、管理员地址、初始化参数）。
- 代理通过 `fallback + delegatecall` 转发用户调用。
- 仅管理员可执行升级函数更换实现地址。

注意：管理员地址不能像普通用户一样调用逻辑函数，这是 Transparent Proxy 的安全隔离机制，需在运维流程中明确区分 admin 与 user 调用路径。

## 参考链接

- [OpenZeppelin - Transparent Proxy Docs](https://docs.openzeppelin.com/upgrades-plugins/1.x/proxies#transparent-proxies)
- [EIP-1967: Proxy storage slots](https://eips.ethereum.org/EIPS/eip-1967)
- [Transparent vs UUPS Proxy - Forum](https://forum.openzeppelin.com/t/transparent-vs-uups-proxies/11556)
