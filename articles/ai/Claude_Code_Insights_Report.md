---
title: Claude Code Insights Report
aliases: [CC 使用报告, Claude Code 洞察]
up: "[[_ai_moc]]"
tags: [AI, Claude-Code, analytics, report]
cssclasses: [report]
status: active
source: "file:///Users/bit/.claude/usage-data/report.html"
date: 2026-03-06
period: 2026-02-18 ~ 2026-03-05
maturity: evergreen
---

# Claude Code Insights Report

> [!abstract]
> 1,438 条消息 · 119 个会话（390 total） · 14 天 · 102.7 msgs/day
> 统计周期：2026-02-18 ~ 2026-03-05

---

## At a Glance

> [!success] What's working
> 建立了高度纪律化的 gate-loop 工作流（audit → fix → compile → verify → commit），单次会话可批量处理 50+ 公式标点、45 处括号滥用。Obsidian 知识库同样以工程化方式管理（单次重组 100+ 文件）。

> [!warning] What's hindering
> - **Claude 侧**：误判工作流偏好（直接调试 vs 子代理分发）、跳过 gate-loop 步骤（如修复后未复审）
> - **用户侧**：简短/模糊请求导致误解循环；多步复杂会话常因 rate limit 中断

> [!tip] Quick wins
> 将 gate-loop 和委派偏好编码为 CLAUDE.md 规则或自定义 skill；尝试 headless mode 批量运行编译+审计验证。

> [!example] Ambitious workflows
> 全自主 audit→fix→compile→verify→commit 管线，并行子代理各自处理一章；自校正 DOCX QA agent 在每次构建后自动检测并修复问题。

---

## What You Work On

| 领域 | 会话数 | 描述 |
|------|--------|------|
| **Thesis LaTeX Writing & Refinement** | ~18 | 中文学位论文迭代编辑：改写摘要、移除口语化、修复括号滥用、添加浮动体过渡文本、重构章节、学术写作质量审计 |
| **Thesis DOCX Pipeline & Formatting** | ~12 | LaTeX→DOCX 管线：Pandoc 渲染问题修复（算法/公式/表格/图/页码/交叉引用）、模板切换、图片格式转换、多阶段 DOCX 质量门禁 |
| **Thesis Content Planning & Expansion** | ~7 | 第3/4章结构改进、§4.3.3 重构、Lemma 4.1 证明改写、每小节 5-7 页扩展规划 |
| **Obsidian Knowledge Base Organization** | ~5 | PARA 方法论重组、122+ Markdown 文件统一格式化、工作流笔记拆分填充、Areas 重构规划 |
| **Tooling, Skills & Project Setup** | ~6 | 目录结构与任务追踪、docx-diff skill 构建、marketplace skill 安装、学术写作指南改写 |
| **AI 笔记系统 (Area_AI)** | 16 notes | MOC 导航中枢、Claude Code 生态实践（工作流/上下文/LSP/Skill/Codemap）、NotebookLM/并发Agent/AI Fluency |

### 统计数据

| 指标 | 值 |
|------|-----|
| Messages | 1,438 |
| Lines changed | +19,372 / -1,466 |
| Files touched | 234 |
| Days active | 14 |
| Msgs/Day | 102.7 |

### What You Wanted (Top 6)

| 任务类型 | 次数 |
|----------|------|
| Document Writing And Editing | 8 |
| Bug Fix Via Subagent | 5 |
| Fix DOCX Formatting | 4 |
| Documentation Update | 4 |
| Text Editing Deletion | 4 |
| Code Editing Refactoring | 4 |

### Top Tools Used

| 工具 | 调用次数 |
|------|----------|
| Bash | 1,302 |
| Read | 831 |
| Edit | 534 |
| TaskUpdate | 492 |
| Grep | 346 |
| TaskCreate | 278 |

### Languages

| 语言 | 文件数 |
|------|--------|
| Markdown | 366 |
| Python | 130 |
| JSON | 19 |
| Shell | 8 |

### Session Types

| 类型 | 次数 |
|------|------|
| Multi Task | 22 |
| Iterative Refinement | 10 |
| Single Task | 7 |
| Exploration | 4 |
| Quick Question | 1 |

---

## How You Use Claude Code

> [!quote] Key pattern
> 你的工作模式是**急躁的架构师-编排者**：分发结构化多阶段计划，在 Claude 偏离预期执行路径时积极中断纠偏。

**Power user**：119 个会话、150 小时、两周内几乎全部聚焦于 LaTeX→DOCX 论文管线和学术中文写作打磨。

**交互风格 — 急躁编排**：给出高层指令（"移除所有章节的括号滥用"、"审计 Lemma 4.1 并改写证明"），期望自主多文件执行，但在 Claude 采取错误路径时**积极中断**。12 次被拒操作和 11 次被误解请求表明：你不仅关心**做什么**，更关心**怎么做**。

**重度迭代 + gate-loop**：反复运行 audit-fix-compile-commit 循环。278 次 TaskCreate + 492 次 TaskUpdate 确认了结构化子任务编排模式。偏好 brainstorm → design → plan → execute 分阶段方法。

**高频 checkpoint**：44 个分析会话中 177 次 commit（~4 commits/session），每次修复视为原子交付物。

**满意度高**：109/119 会话标记为"likely satisfied"。不满集中在 Claude 无法匹配节奏的场景。

### Response Time Distribution

| 区间 | 次数 |
|------|------|
| 2-10s | 83 |
| 10-30s | 142 |
| 30s-1m | 169 |
| 1-2m | 181 |
| 2-5m | 120 |
| 5-15m | 88 |
| >15m | 46 |

Median: 64.7s · Average: 212.3s

### Multi-Clauding (Parallel Sessions)

| 指标 | 值 |
|------|-----|
| Overlap Events | 36 |
| Sessions Involved | 56 |
| Of Messages | 16% |

---

## Impressive Things You Did

### 1. Systematic Gate-Loop Thesis Editing

开发了严格的迭代工作流：审计论文特定问题（公式标点、括号滥用、口语化）→ 跨多章批量修复 → 编译+审计门禁验证 → 提交。单次会话可系统清理 50+ 公式标点和 45 处括号问题。

### 2. Multi-Tool DOCX Pipeline Engineering

构建并维护了复杂的 LaTeX→DOCX 转换管线：参考模板切换、图片格式转换、格式质量门禁。编排子代理并行修复算法/表格/交叉引用/页码问题，并构建了 docx-diff 自定义 skill。

### 3. Obsidian Knowledge Base Orchestration

将 Claude Code 用作完整的知识管理引擎：PARA 方法论重组 Obsidian vault（单次 117 文件）、统一格式化 122 个 Markdown 文件、维护结构化日记和任务追踪。

### What Helped Most

| Claude 能力 | 次数 |
|-------------|------|
| Multi-file Changes | 20 |
| Fast/Accurate Search | 4 |
| Correct Code Edits | 4 |
| Good Explanations | 3 |
| Good Debugging | 3 |
| Proactive Help | 3 |

### Outcomes

| 结果 | 次数 |
|------|------|
| Fully Achieved | 19 |
| Mostly Achieved | 10 |
| Partially Achieved | 8 |
| Not Achieved | 6 |
| Unclear | 1 |

---

## Where Things Go Wrong

### 1. Misaligned Workflow Expectations

Claude 反复未遵循委派和执行偏好，迫使中断重定向。

- Claude 在主会话直接调试 DOCX 问题而非分发子代理，导致"不需要你去定位"
- Claude 提供多余选项并跳过修复后的学术写作复审

### 2. Ambiguous or Incomplete Requests

请求过于简短或缺乏上下文，导致误解或澄清循环。

- Claude 不理解"第二版"指哪个 git commit
- "策划师"和 LaTeX 论文中的"Solidity"让 Claude 无法行动

### 3. Rate Limits and Session Interruptions

复杂多步任务频繁因 API rate limit 或过早结束而中断。

- DOCX 质量门禁架构会话在完成前触及用量限制
- 三个连续的第3/4章扩展 brainstorming 会话均未产出实质内容

### Friction Types

| 类型 | 次数 |
|------|------|
| User Rejected Action | 12 |
| Misunderstood Request | 11 |
| Wrong Approach | 11 |
| Buggy Code | 7 |
| Excessive Changes | 2 |
| API Error | 1 |

### Satisfaction

| 评级 | 次数 |
|------|------|
| Likely Satisfied | 109 |
| Dissatisfied | 9 |
| Satisfied | 3 |
| Frustrated | 1 |

---

## Features to Try

### CLAUDE.md 建议添加

1. **Thesis Workflow**: 修复论文问题时始终用子代理，不在主会话直接修复
2. **LaTeX Editing Rules**: 编辑后必须编译验证+运行审计门禁
3. **General Rules**: 不过度工程化，保持表格等格式一致
4. **Interaction Style**: 用户选方案后立即执行，不追问
5. **Thesis Workflow**: 完成后记录日记，遵循 edit→compile→audit→commit→journal
6. **Git & Version Control**: 歧义引用立即澄清，不猜测

### Hooks

自动在每次 Edit 后触发 LaTeX 编译和质量门禁审计，消除手动步骤。

```json
// .claude/settings.json
{
  "hooks": {
    "postToolUse": [
      {
        "matcher": "Edit",
        "command": "cd /path/to/thesis && make docx 2>&1 | tail -5"
      }
    ]
  }
}
```

### Custom Skills

编码整个 gate-loop 管线为 `/thesis-edit` skill，避免遗忘步骤。

### Headless Mode

脚本化批量操作（标点审计、表格转换、Obsidian 格式化），无需交互式监督。

```bash
claude -p "Audit all .tex files in chapters/ for equation-ending punctuation. Remove any commas or periods after \end{equation}. Compile and verify." --allowedTools "Edit,Read,Bash,Grep"
```

---

## New Ways to Use Claude Code

### 1. Encode gate-loop workflow to prevent skipped steps

最成功的会话遵循严格的 edit→compile→audit→fix→re-audit→commit→journal 管线。编码为 CLAUDE.md 指令或自定义 skill，消除 Claude 跳步风险。

> [!tip] Prompt template
> After making any LaTeX edits: 1) compile to DOCX, 2) run the academic-writing audit skill, 3) fix any issues found, 4) re-run the audit to confirm zero issues, 5) compile again, 6) commit, 7) log to daily journal. Never skip step 4.

### 2. Front-load context to reduce friction

11 个会话存在请求被误解。在首条消息中多用一句话提供明确上下文，可节省多轮纠正。

> [!tip] Prompt template
> I want to fix [specific issue] in [exact filename]. Use a subagent to diagnose and fix it. The relevant git branch is [branch name]. After fixing, compile and run the full gate loop.

### 3. Batch similar edits into single sessions

最高产的会话将同类操作集中处理（45 括号修复、50 标点修复、122 文件格式化）。明确批量范围。

> [!tip] Prompt template
> Grep all .tex files in chapters/ for [pattern]. List every instance with file and line number. Then fix all instances systematically, compiling after each file. Commit when all files pass.

---

## On the Horizon

### 1. Autonomous Thesis Gate-Loop Editing Pipeline

整个 audit→fix→compile→verify→commit 循环可全自主运行：一个 agent 审计学术写作规则，另一个执行 LaTeX 编辑，第三个编译检查门禁，编排者仅在所有门禁通过或需要决策时才浮现结果。

### 2. Parallel Multi-Chapter Formatting Standardization Agent

并行子代理同时处理所有章节，各自独立编译验证。从顺序处理（逐文件 babysit）升级为并发自修复。

### 3. Self-Correcting DOCX Quality Assurance Agent

最大痛点（陈旧缓存 PNG、丢失 XML namespace、abstractNumId 不匹配、错误图片）均可程序化检测。自主 QA agent 在每次构建后自动 diff 输出与参考模板、检查图片新鲜度、验证 XML 结构、确认交叉引用。

---

## Fun Ending

> [!bug] 人眼仍能捕捉自动化遗漏
> 修复论文第2-5章图片渲染时，Claude 转换 PDF→PNG 但遗漏了一张 dag 图的 PNG 早于源 PDF——静默嵌入了旧版图表。在 150 小时、177 次 commit 的论文马拉松中，人眼依然是最后一道防线。

---

## Related Notes

- [[Claude_Code_核心工作流|核心工作流]]
- [[Claude_Code_上下文管理机制|上下文管理]]
- [[Claude_Code_Skill迭代复盘指南|Skill 迭代复盘]]
- [[Task_探索ClaudeCode并发Agent使用|并发 Agent]]
