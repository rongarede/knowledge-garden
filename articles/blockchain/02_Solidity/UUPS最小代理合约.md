---
title: UUPS 代理模式
aliases: ["UUPS代理模式", "UUPS 最小代理", "ERC1967Proxy UUPS"]
tags: ["区块链/Solidity"]
up: "[[_blockchain_moc]]"
status: active
maturity: budding
---

# UUPS 代理模式

UUPS（EIP-1822）将升级逻辑放在实现合约中，代理保持轻量，适合批量部署和成本敏感场景。

## What（是什么）

- UUPS（Universal Upgradeable Proxy Standard）遵循 [[EIP-1822]]。
- 通过代理 `delegatecall` 转发，状态存储在代理中。
- 常见组合：`ERC1967Proxy + UUPSUpgradeable`。

## Why（为什么使用）

- 节省部署成本。
- 升级逻辑可模块化内聚。
- 与 Minimal Proxy / clone 架构兼容性好。
- OpenZeppelin 生态支持成熟。

## When（什么时候使用）

- 需要可升级且成本受控。
- 多实例共用逻辑模板。
- 升级权限需要灵活定制。
- 工厂化批量部署平台（Meme、NFT、策略池等）。

## Where（应用场景）

- OpenZeppelin 可升级组件库。
- NFT 工厂平台。
- DAO 投票/提案模块。
- DeFi Vault 与策略合约。
- 跨链桥与 Layer2 组件。

## How（如何实现）

- 部署逻辑合约：继承 `UUPSUpgradeable`，实现 `initialize()`。
- 部署代理：使用 `ERC1967Proxy` 传入实现地址和初始化参数。
- 日常调用：由代理转发到逻辑合约。
- 升级流程：新实现支持 `proxiableUUID()`，旧实现通过 `upgradeTo(newImpl)` 触发升级。

升级函数必须叠加 `onlyProxy` + 权限控制（如 `onlyOwner` / 角色管理）。

## 参考链接

- [EIP-1822: UUPS](https://eips.ethereum.org/EIPS/eip-1822)
- [EIP-1967: Proxy storage layout](https://eips.ethereum.org/EIPS/eip-1967)
- [OpenZeppelin - UUPS proxies](https://docs.openzeppelin.com/contracts/4.x/upgradeable#uups-proxies)
