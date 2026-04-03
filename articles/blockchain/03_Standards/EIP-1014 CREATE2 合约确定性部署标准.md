---
title: EIP-1014 CREATE2 合约确定性部署标准
aliases: [EIP-1014 CREATE2 合约确定性部署标准, EIP-1014: CREATE2 合约确定性部署标准（4W1H）, EIP-1014]
tags: [区块链/标准]
up: "[[_blockchain_moc]]"
status: active
maturity: budding
---

# EIP-1014: CREATE2 合约确定性部署标准（4W1H）

## What（它是什么）

- EIP-1014 提议在 EVM 中新增 `CREATE2` 指令，实现合约的可预测地址部署。
- 与传统 `CREATE`（依赖部署者地址与 nonce）不同，`CREATE2` 使用部署者地址 + salt + init code 生成固定地址。

### 特点

- 地址部署前可预知
- 多次部署相同字节码可生成相同地址
- 避免 nonce 依赖，增强链下可组合性

- 引入于 Constantinople 升级，作者为 Vitalik Buterin。

## Why（为什么需要）

- 传统 `CREATE` 的合约地址部署后才知道，导致多模块部署、状态恢复、钱包工厂设计受限。

### CREATE2 带来的好处包括

- 预测钱包地址：部署前用户可知道地址（如 AA 钱包）
- 合约恢复：合约 selfdestruct 后，可再次部署回相同地址
- 模块统一部署：salt + bytecode 控制地址一致性
- 状态通用性：地址为身份标识，不依赖合约顺序

## When（何时使用）

### 引入于 Constantinople 硬分叉（区块高度 7280000，2019年）

### 使用场景包括

- 钱包工厂、账户抽象（EIP-4337）
- 插件化模块系统、DAO 子模块部署
- 合约恢复系统（如状态频道、再上线）
- 多签钱包地址预测部署

## Where（部署地址如何生成）

### 地址公式如下

```text
address = keccak256(0xFF ++ sender ++ salt ++ keccak256(init_code))[12:]
```

### 参数说明

- `0xFF`：固定前缀
- `sender`：执行 CREATE2 的合约地址（通常是工厂）
- `salt`：开发者自定义的 32 字节值
- `init_code`：合约初始化字节码
- 最终取 keccak256 结果的最后 20 字节作为地址

地址唯一且可重复部署（若先前合约已销毁）。

## How（如何使用）

### 示例：Solidity 工厂合约部署逻辑

```solidity
function deploy(bytes32 salt) public returns (address) {
    bytes memory bytecode = type(MyContract).creationCode;
    address addr;
    assembly {
        addr := create2(0, add(bytecode, 0x20), mload(bytecode), salt)
        if iszero(extcodesize(addr)) { revert(0, 0) }
    }
    return addr;
}
```

### 示例：预计算地址函数

```solidity
function computeAddress(bytes32 salt) public view returns (address) {
    bytes memory bytecode = type(MyContract).creationCode;
    return address(uint160(uint(keccak256(abi.encodePacked(
        bytes1(0xff),
        address(this),
        salt,
        keccak256(bytecode)
    )))));
}
```

### 实践建议

- 使用 OpenZeppelin 的 Clones 工具（`cloneDeterministic`）
- 确保 bytecode 不变，否则地址不同
- 建议在部署前使用 `extcodesize` 检查目标地址是否已存在

## 参考资料

- [EIP-1014 原文](https://eips.ethereum.org/EIPS/eip-1014)
- [Solidity CREATE2 官方文档](https://docs.soliditylang.org/en/latest/control-structures.html#salted-contract-creations-create2)
- [Create2 地址计算工具](https://create2.eth.tools/)
- [OpenZeppelin cloneDeterministic 文档](https://docs.openzeppelin.com/contracts/4.x/api/proxy#Clones-cloneDeterministic-address-bytes32-)
- [Solidity Patterns: CREATE2 实战教程](https://fravoll.github.io/solidity-patterns/create2/)
