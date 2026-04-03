---
title: "Compound v2四大核心部件"
aliases: ["Compound v2四大核心部件", "Compoundv2四大核心部件", "Compound v2四大核心部件 笔记"]
tags: [区块链/DeFi]
up: "[[_blockchain_moc]]"
status: active
maturity: budding
---

## 总览（控制面 / 数据面）

```
  ┌──────────────────────────┐
  │    控制面 Control Plane   │
  │ (规则/参数/风控/激励管理) │
  └───────────┬──────────────┘
          │ *Allowed/*Verify/参数
  ┌───────────▼───────────┐
  │     Comptroller        │
  │  - 价格：PriceOracle    │
  │  - 健康度：Liquidity    │
  │  - 开关/上限/激励（COMP）│
  └───────────┬───────────┘
          │ 许可结果
  ────────────┼────────────────────────
          │
  ┌───────────▼───────────┐
  │     数据面 Data Plane  │
  │        cToken          │
  │  - 账本与资金流         │
  │  - accrueInterest()    │
  └───────────┬───────────┘
          │ 调用利率
    ┌─────▼─────┐
    │ IR Model  │
    │ getRates  │
    └───────────┘
```

## 四大模块

### cToken（CErc20 / CEther）

- 职责：账本 & 资金执行层；ERC-20 包装；存/借/还/赎/清算入口；按区块计息。
- 核心状态变量：
  - `comptroller`｜风控入口
  - `interestRateModel`｜利率模型地址
  - `accrualBlockNumber`｜上次计息区块
  - `borrowIndex`｜全局借款指数
  - `totalBorrows / totalReserves / totalSupply`｜全局量
  - `accountTokens[addr]`｜cToken 余额
  - `accountBorrows[addr]={principal, interestIndex}`｜借款快照
- 重要对外函数：
  - `mint/redeem/redeemUnderlying`
  - `borrow/repayBorrow/repayBorrowBehalf`
  - `liquidateBorrow`（与 `seize` 配合）
  - `exchangeRateCurrent`、`accrueInterest`、`getAccountSnapshot`
- 关键事件：`Mint` `Redeem` `Borrow` `RepayBorrow` `LiquidateBorrow` `AccrueInterest`
- 风险要点：所有操作前置 `accrueInterest`；精度 Mantissa；风控依赖 Comptroller。

### Comptroller

- 职责：全局风控大脑（控制面）；市场注册；抵押因子/关闭因子/清算激励；暂停/上限；COMP 分发；价格取数。
- 核心状态变量：
  - `oracle`｜PriceOracle
  - `closeFactorMantissa`｜单次清算最大还款比例
  - `liquidationIncentiveMantissa`｜清算折扣/激励
  - `markets[CToken]={isListed, collateralFactor, isComped}`
  - `accountAssets[addr]`｜已进入的抵押市场集
  - `pauseGuardian` 与各类 `*Paused`
  - （激励）`compSpeeds/compAccrued`、账户/市场指数
- 重要对外函数：
  - 账户/市场：`enterMarkets` `exitMarket` `_supportMarket`
  - 风控钩子：`mintAllowed/redeemAllowed/borrowAllowed/repay.../liquidate.../seize.../transfer...`+ `*Verify`
  - 健康度：`getAccountLiquidity` / `getHypotheticalAccountLiquidity`
  - 管理：`_set{Oracle,CF,CloseFactor,LI,Pause,...}`、（激励）`claimComp`、`_setCompSpeeds`
- 事件：`MarketListed` `MarketEntered` `MarketExited` `NewPriceOracle` `NewCollateralFactor` `ActionPaused` …
- 风险要点：价格为 0/过期即拒绝；`Liquidity ≥ 0` 约束赎回/转账；合理设置 Caps 与 Pause。

### InterestRateModel（JumpRate/WhitePaper）

- 职责：独立策略合约；按利用率 U 计算 `borrowRate` 与 `supplyRate`（每区块）；cToken 计息时查询。
- 核心状态变量（以 JumpRate 为例）：
  - `baseRatePerBlock` `multiplierPerBlock` `jumpMultiplierPerBlock` `kink` `blocksPerYear`
- 重要对外函数：`getBorrowRate(cash,borrows,reserves)`；`getSupplyRate(cash,borrows,reserves,reserveFactor)`
- 公式：
  - 利用率：`U = borrows / (cash + borrows - reserves)`
  - 借款利率：`U ≤ kink: base + multiplier*U`；`U > kink: base + multiplier*kink + jumpMultiplier*(U-kink)`
  - 存款利率：`supplyRate = borrowRate * (1 - reserveFactor) * U`
- 风险要点：参数影响稳定性；U→1 利率飙升；`blocksPerYear` 假设与实际出块差异。

### PriceOracle

- 职责：向 Comptroller 提供资产 USD 价格（1e18 精度）；风控与清算基准；可替换实现（Simple / Open Price Feed / Chainlink）。
- 核心状态变量（视实现）：`prices[underlying]`、`reporters/admins`、`maxStalePeriod`
- 重要对外函数：`getUnderlyingPrice(cToken)`（必备）；（实现可选）`setUnderlyingPrice/postPrices/...`
- 风险要点：价格过期/为 0 → 拒绝操作；AMM 喂价需防操纵（TWAP/容差/心跳）。

## 借款时序（关键路径）

```
  User → cToken.borrow(amount)
  ├─ accrueInterest() → IRModel.getBorrowRate() → 更新 borrowIndex/borrows/reserves
  ├─ Comptroller.borrowAllowed() → Oracle 取价 → 算 Liquidity/Shortfall → 检查 Caps/Pause
  └─ （允许）账本写入 & 资金转出 → Borrow(...)
```

## 速查公式

- 利用率 U：`U = borrows / (cash + borrows - reserves)`

借款利率（JumpRate）：

- `U ≤ kink`：`borrowRate = base + multiplier*U`
- `U > kink`：`borrowRate = base + multiplier*kink + jumpMultiplier*(U - kink)`

- 存款利率：`supplyRate = borrowRate * (1 - reserveFactor) * U`

## 复习要点

- **顺序**：先 `accrueInterest` → 再 `*Allowed` → 执行资金流 → `*Verify`
- **关键约束**：`redeem/transfer` 后需 `Liquidity ≥ 0`
- **控制面 vs 数据面**：Comptroller 管规则；cToken 动资金
- **激励**：COMP 指数法，懒更新，按市场速率 `compSpeeds` 分发

## 练习题

- Q：给定 `cash=1000, borrows=500, reserves=0`，U=?
- Q：为何价格为 0 时应拒绝 borrow/redeem？
- Q：`closeFactor` 与 `liquidationIncentive` 对清算各起什么作用？
