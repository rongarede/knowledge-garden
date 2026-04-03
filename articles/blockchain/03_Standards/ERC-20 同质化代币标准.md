---
title: ERC-20 同质化代币标准
aliases: [ERC-20 同质化代币标准, ERC-20 标准（4W1H）, EIP-20]
tags: [区块链/标准]
up: "[[_blockchain_moc]]"
status: active
maturity: budding
---

# ERC-20 标准（4W1H）

## What（它是什么）

- ERC-20 是以太坊上最早也是最广泛使用的代币标准之一，定义了"同质化代币"的通用接口。
- 由 Fabian Vogelsteller 和 Vitalik Buterin 于 2015 年提出，编号为 EIP-20。
- ERC 表示 Ethereum Request for Comments。
- 它规定了智能合约中必须实现的函数和事件，使得代币可以被统一识别和交互。

### 核心接口包括

- `totalSupply()`：查询代币总供应量
- `balanceOf(address)`：查询地址余额
- `transfer(to, amount)`：发送代币
- `approve(spender, amount)`：授权他人支配代币
- `transferFrom(from, to, amount)`：代他人转账
- `allowance(owner, spender)`：查看授权额度
- 事件：`Transfer`, `Approval`

## Why（为什么需要）

- 在 ERC-20 发布前，每个代币的接口和实现都不一致，无法互操作。
- ERC-20 提供了统一的代币标准，使钱包、交易所、DApp 可以自动识别并支持新代币。
- 它降低了开发成本，并推动了 DeFi、ICO、NFT、DAO 等应用生态的迅速发展。
- 解决了"如何让不同合约、平台处理代币资产时具有通用接口"的问题。

## When（什么时候出现）

- 起草时间：2015 年 11 月
- 提案编号：EIP-20
- 广泛应用：2017 年 ICO 热潮之后，成为以太坊最常用的标准之一。
- 迄今为止，成千上万个 Token 合约都采用 ERC-20 规范。

## Where（在哪些场景使用）

- 所有基于以太坊和兼容链（如 BSC、Polygon、Arbitrum）的标准代币发行
- DeFi 协议中的资产（USDT, DAI, UNI, AAVE 等）
- GameFi / SocialFi 平台的积分和游戏资产
- DAO 治理代币（MKR, COMP, ENS 等）
- 交易所上的充值/提现代币格式
- 钱包识别 ERC-20 Token 并展示余额

## How（如何使用）

- 开发者可使用 Solidity 语言实现 ERC-20 接口
- 推荐使用 OpenZeppelin 提供的安全、标准化合约模板：

```solidity
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    constructor() ERC20("MyToken", "MTK") {
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }
}
```

### ERC-20 实现中应确保

- 使用 `require()` 检查余额和授权额度
- 事件 `Transfer` 与 `Approval` 必须在状态变更后触发
- 返回 `bool` 值以便上层合约处理成功与否
