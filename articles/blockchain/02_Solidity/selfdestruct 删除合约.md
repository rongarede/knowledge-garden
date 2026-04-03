---
title: selfdestruct 删除合约
aliases: ["SELFDESTRUCT", "合约销毁", "Solidity 自毁"]
tags: ["区块链/Solidity"]
up: "[[_blockchain_moc]]"
status: active
maturity: budding
---

# Solidity 特性：selfdestruct

`selfdestruct` 可销毁合约并将余额转至指定地址，适用于可控退场流程，但属于高风险操作，必须严格权限控制。

## What（它是什么）

- `selfdestruct(address payable recipient)` 用于销毁合约代码并转移剩余 ETH。
- 对应 EVM 操作码 `SELFDESTRUCT`（`0xff`）。

## Why（为什么需要）

- 提供主动终止合约生命周期的机制。
- 常见用途：
  - 合约下线与资金回收。
  - 临时逻辑容器清理。
  - 与 `CREATE2` 相关的地址管理策略（按场景评估）。

## How（如何使用）

基本语法：

```solidity
selfdestruct(payable(address));
```

示例代码：

```solidity
contract Vault {
    address public owner;
    constructor() payable {
        owner = msg.sender;
    }

    function destroy(address payable to) public {
        require(msg.sender == owner, "not owner");
        selfdestruct(to);
    }
}
```

- 建议加 `onlyOwner` 或角色控制。
- 建议使用两步销毁流程（提案 + 确认）。

## How much（影响与代价）

- 能快速终止合约并处理残余资金。
- 销毁操作不可逆，恢复成本极高。
- 历史交易与历史状态不会被"抹除"。

## Security Considerations

注意：未加权限控制会导致任意用户销毁合约。

常见问题：

- 销毁入口缺少权限判断。
- 销毁流程与资金回收流程割裂，导致资产管理混乱。
- 误以为销毁可清除链上历史记录。

销毁后地址仍可能接收 ETH；运维与监控应把该地址视为"无代码地址"持续观察。

## 参考资料

- [Solidity 官方文档：selfdestruct](https://docs.soliditylang.org/en/latest/control-structures.html#selfdestruct)
- [Ethereum Yellow Paper](https://ethereum.github.io/yellowpaper/paper.pdf)
- [EIP-1014: CREATE2](https://eips.ethereum.org/EIPS/eip-1014)
- [Solidity Patterns — Self-destructable Contracts](https://fravoll.github.io/solidity-patterns/self-destructable-contracts/)
