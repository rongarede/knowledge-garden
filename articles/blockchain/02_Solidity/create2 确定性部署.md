---
title: CREATE2 确定性部署
aliases: ["CREATE2 部署", "EIP-1014", "合约地址预计算"]
tags: ["区块链/Solidity"]
up: "[[_blockchain_moc]]"
status: active
maturity: budding
---

# CREATE2 确定性部署

CREATE2 允许在部署前预测合约地址，适用于工厂模式、账户抽象与模块化系统。

## What（是什么）

- `CREATE2` 是 EVM 部署指令，由 [[EIP-1014 CREATE2 合约确定性部署标准]] 引入。
- 地址由部署者、`salt` 与 `init_code` 共同决定，可提前计算。

## Why（为什么需要）

`CREATE` 地址依赖 nonce，难以稳定预估；`CREATE2` 可支持：

- 钱包地址预计算（AA 钱包工厂）。
- 合约销毁后在同地址重建（配合条件约束）。
- 跨环境统一模块地址。
- 链下先规划地址、链上后部署。

## When（何时使用）

- 账户抽象钱包部署（EIP-4337 生态）。
- DAO 工厂等多模块可预测部署。
- clone proxy + create2 工厂模式。

## Where（地址如何生成）

地址计算公式：

```text
address = keccak256(0xFF ++ deployer ++ salt ++ keccak256(init_code))[12:]
```

| 参数 | 说明 |
|---|---|
| `0xFF` | 常量前缀 |
| `deployer` | 部署者地址（通常是工厂合约） |
| `salt` | 32 字节值，用于控制地址 |
| `init_code` | 合约创建代码 |

## How（怎么实现）

基础部署：

```solidity
function deploy(bytes32 salt) public returns (address addr) {
    bytes memory bytecode = type(MyContract).creationCode;
    assembly {
        addr := create2(0, add(bytecode, 0x20), mload(bytecode), salt)
    }
}
```

地址预计算：

```solidity
function computeAddress(bytes32 salt) public view returns (address) {
    bytes32 hash = keccak256(type(MyContract).creationCode);
    return address(uint160(uint(keccak256(abi.encodePacked(
        bytes1(0xff), address(this), salt, hash
    )))));
}
```

注意：`salt` 与 `init_code` 任一变化都会导致地址变化；依赖固定地址的系统需统一版本与参数策略。

## 参考资料

- [EIP-1014](https://eips.ethereum.org/EIPS/eip-1014)
- [OpenZeppelin cloneDeterministic](https://docs.openzeppelin.com/contracts/4.x/api/proxy#Clones)
