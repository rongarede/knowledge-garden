---
title: "关于 ETH 的命令行钱包"
aliases: ["关于 ETH 的命令行钱包", "关于 ETH 的命令行钱包笔记", "关于 ETH 的命令行钱包总结"]
tags: [区块链/项目]
up: "[[_blockchain_moc]]"
status: active
maturity: budding
---

# 关于 ETH 的命令行钱包

## 4W1H 介绍

### What（是什么）

- ETH 的命令行钱包是一类通过终端（Terminal）或命令行界面（CLI）来管理以太坊账户与资金的工具
- 不依赖图形界面，直接用指令实现创建账户、查询余额、发送交易、签名数据、部署合约等操作

### Why（为什么用）

- 轻量化：无需安装图形界面，资源占用少
- 可自动化：方便写脚本、批量操作，适合开发与运维
- 高控制权：直接与节点交互，方便调试、测试、个性化使用
- 安全性：可结合硬件钱包、离线签名，减少暴露私钥的风险

### When（何时用）

- 部署智能合约或测试 DApp 时，用 CLI 快速执行交易
- 在服务器环境或无 GUI 的系统中管理账户
- 进行批量转账、批量签名等自动化流程时
- 需要更细粒度控制交易参数（gas、nonce 等）时

### Where（在哪里用）

- 本地开发环境：在个人电脑、Linux 服务器、Docker 容器中
- 生产环境：作为后台钱包服务的一部分，与区块链节点结合使用
- 集成到 CI/CD 流程或链上自动化脚本

### How（怎么用）

安装工具（例如 Geth）：

```bash
sudo apt install geth
```

初始化账户：

```bash
geth account new
```

启动节点并进入 console：

```bash
geth --goerli --datadir ./data console
```

在 console 中查询余额：

```javascript
eth.getBalance(eth.accounts[0])
```

在 console 中发送交易：

```javascript
eth.sendTransaction({from: eth.accounts[0], to: "0x...", value: web3.toWei(0.1, "ether")})
```
