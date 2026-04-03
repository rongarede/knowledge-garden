---
title: "RPC vs API（REST）对比"
aliases: ["RPC vs API（REST）对比", "RPC vs API", "RPCvsAPI"]
tags: ["区块链/基础设施"]
up: "[[_blockchain_moc]]"
status: active
maturity: budding
---

# RPC vs API（REST）对比

## 核心结论

- RPC 是"过程调用"范式；REST API 是"资源操作"范式
- 追求低延迟/强类型/跨语言高性能 → 选 RPC（gRPC/Thrift/JSON-RPC）
- 面向开放网络/第三方集成/浏览器友好 → 选 REST API

## 对比表

| 维度 | RPC（Remote Procedure Call） | API（REST / HTTP API） |
|------|------------------------------|------------------------|
| 调用抽象 | 方法调用（procedure + params） | 资源操作（URL + HTTP 动词） |
| 协议依赖 | TCP / HTTP/2 / QUIC / WebSocket / 自定义二进制 | HTTP/HTTPS |
| 序列化 | Protobuf / MessagePack / JSON / 自定义二进制 | JSON / XML（主流 JSON） |
| 性能 | 高（长连接、二进制、更少开销） | 中（文本协议、无状态开销更大） |
| 工程体验 | Stub/Proxy 掩蔽网络细节，强类型生成 | 手写/SDK 拼 HTTP 请求，更显式 |
| 版本治理 | 以接口/IDL 为中心（兼容性通过 schema） | 以资源/URL 为中心（路径与字段演进） |
| 典型场景 | 微服务内网、区块链节点直连、实时服务 | 公网开放平台、第三方集成、前后端 |
| 学习/接入成本 | 需工具链（IDL、代码生成、连接管理） | 低（浏览器/终端即可调） |

## 心智模型

- RPC：像本地函数 → `call(method, params) → result`
- REST：像资源文档 → `HTTP VERB /resource/:id → representation`

## 区块链中的体现

### JSON-RPC 调用

```json
{"jsonrpc":"2.0","method":"eth_getBlockByNumber","params":["latest", false],"id":1}
```

过程化方法 `eth_getBlockByNumber` + 参数数组。

### 第三方 REST API（示例风格）

```
GET /api?module=account&action=balance&address=0x...
```

资源 URL + 查询参数，适合对外聚合服务。

## 选型建议

### 选 RPC（gRPC / JSON-RPC）

- 内网微服务高 QPS / 低延迟 / 双向流（HTTP/2）
- 强类型契约（IDL）/ 需要代码生成与向后兼容
- 直连区块链节点（钱包/DApp ↔ 节点）

### 选 REST API

- 公网开放、易调试、浏览器直接调用
- 第三方生态/文档优先/缓存与网关（CDN/Proxy）友好
- 慢变更领域、需要超广兼容性

## 工程差异

### RPC

Stub/Proxy 生成 → 序列化（Proto/MsgPack/JSON）→ 长连接传输（HTTP/2/TCP）→ 反序列化 → 方法分发

### REST

路由/控制器 → 解析 HTTP 请求（URL/Headers/Body）→ 资源层逻辑 → 返回 JSON 表述

## 优缺点速记

- RPC 优点：低延迟、强类型、流式、带宽占用小
- RPC 缺点：工具链重、浏览器直调不便、跨域/网关集成麻烦
- REST 优点：简单通用、生态成熟、浏览器友好、缓存/网关易用
- REST 缺点：文本开销大、强类型弱、实时/长连能力一般

## 常见误区

- "RPC 一定不是 HTTP"：错。gRPC 基于 HTTP/2；JSON-RPC 也常走 HTTP
- "REST 比 RPC 更安全/更不安全"：不准确。安全取决于鉴权/传输层/网关策略，而非范式本身
- "JSON-RPC 就是 REST"：错。JSON-RPC 是过程调用，REST 是资源表述

## 速查代码片段

### gRPC（概念性 .proto）

```proto
service BlockSvc {
  rpc GetBlockByNumber (BlockReq) returns (BlockResp);
}
```

### REST（概念性路由）

```
GET /blocks/:number
```

## TL;DR

- 内部服务/链上直连 → RPC
- 对外开放/前端直调 → REST
- 两者能并存：内部 RPC，外部暴露 REST 网关（BFF / API Gateway）
