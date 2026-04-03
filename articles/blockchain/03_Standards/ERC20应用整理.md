---
title: ERC20应用整理
aliases: [ERC20应用整理, ERC-20 同质化代币标准 创新性应用整理（多维分层模型）, ERC-20]
tags: [区块链/标准]
up: "[[_blockchain_moc]]"
status: active
maturity: budding
---

# [[ERC-20 同质化代币标准]] 创新性应用整理（多维分层模型）

## 应用维度（Application Layer）

### DeFi 金融类

- cToken / aToken：代表存款利息凭证（Compound、AAVE）
- LP Token：代表 AMM 流动性份额（Uniswap、Balancer）
- Staking Derivatives：流动性质押权益凭证（Lido 的 stETH、rETH）
- 指数型资产：如 DPI（DeFi Pulse Index）

### DAO 治理类

- 治理权 Token：如 UNI、MKR、COMP，参与链上投票
- 可回购治理机制：OlympusDAO、Bonding Curve
- 社区声望积分代币：SourceCred、Coordinape

### GameFi / SocialFi

- 游戏币/能量：SLP、AXS
- 创作者代币：Rally、Friend.tech
- 任务激励积分：Galxe、Quest3

### ReFi / 公共产品

- 碳信用 Token：Toucan Protocol、KlimaDAO
- 公共资助权：Gitcoin GTC
- 自动捐赠代币：Giveth、GoodDollar

## 技术机制（Mechanism Layer）

- Rebasing Token：自动调整余额（Ampleforth）
- Fee-on-Transfer：转账时收税（SafeMoon）
- Gasless Approval（EIP-2612）：permit 授权免 Gas
- Streaming Token：持续流支付（Superfluid）
- 时间锁代币：TokenVesting，按月线性释放
- 可增值资产：铸造时自动生成收益凭证

## 衍生标准（Derived ERC 扩展）

- ERC-2612：gasless `permit()` 授权（USDC、DAI）
- ERC-4626：收益型 Vault 标准（Yearn、Beefy）
- ERC-777：支持钩子的 ERC20 升级版
- ERC-1363：transferAndCall / approveAndCall
- Superfluid：流式资产标准（实时更新余额）

## 实际项目案例（Case Examples）

- Compound：cDAI/cETH
- Lido：stETH
- OlympusDAO：OHM + Bonding
- AAVE：aUSDT、aWETH
- Gitcoin：GTC 治理 + 公共资助
- KlimaDAO：碳信用资产 + DAO
- Ampleforth：Rebase 机制
- Galxe：任务积分 + 链上身份
