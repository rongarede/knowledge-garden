---
title: "我的 AI 工具日常使用与工作流是怎样的？"
source: "https://wangshuyi.substack.com/p/ai-ba0"
author:
  - "[[Wang Shuyi]]"
published: 2026-01-15
created: 2026-01-19
description: "借星友的提问，梳理一下我的AI工具与工作流，分享给你"
tags:
  - "clippings"
maturity: budding
---
### 借星友的提问，梳理一下我的AI工具与工作流，分享给你

![](https://substackcdn.com/image/fetch/$s_!NbtN!,w_424,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F17b1a98d-99da-4b2c-939b-f9c35b78c1b7_2752x1536.jpeg)

知识星球上，星友张文茹问：

> 王老师好，一堆问题：
> 
> 1. **您日常工作经常会用到哪些 AI 工具？这些工具分别负责承担哪些具体任务？**
> 1. **您是如何像管理公司员工分配业务一样，给这些 AI 工具划分 “工作职责”，让它们高效协同配合的？**
> 1. **您整体的工作流程中，AI 工具的介入带来了哪些效率提升？具体体现在哪些环节？**
> 1. **对于知识资产的管理与储存，您有什么好方法？AI 工具在这方面是否能提供助力，具体是如何发挥作用的？**

我觉得这是几个很好的问题。可以让我有机会梳理一下最近几年使用 AI 的一些系统化心得。所以我想把答案一并分享给你。

咱们先以我之前的分享进行梳理。但是你知道的，AI 领域进展非常快速。所以我会在梳理之后，补充目前新的变化。

下面咱们就开始吧。

---

## 问题一：日常工作经常会用到哪些 AI 工具？这些工具分别负责承担哪些具体任务？

我的 AI 工具箱挺庞杂的，但核心逻辑很简单： **不找全能选手，让每个工具在自己最擅长的地方发挥作用** 。这套思路叫「 **[重器轻用](https://open.substack.com/pub/wangshuyi/p/ai-chatgpt-pro?r=3fbs5&utm_campaign=post&utm_medium=web&showWelcomeOnShare=true)** 」，是「善用佳软」张玉新老师提出的。

先说 **深度调研** 这块。

我曾经介绍过，ChatGPT Pro 是我的「首席研究员」。之前它搭载的 o3 模型在 GPQA Diamond 等科学基准测试上表现相当惊人，我经常用它来做需要严密逻辑推理的复杂分析。更重要的是它的 **[Deep Research 功能](https://open.substack.com/pub/wangshuyi/p/3ai?r=3fbs5&utm_campaign=post&utm_medium=web&showWelcomeOnShare=true)** —— 以前做一个深度调研，翻文献、整理资料、写报告，动辄几周甚至几个月。现在呢？5 到 30 分钟，它就能吐出一份数据翔实、引用准确的报告，质量不亚于专业咨询团队的产出。

实时信息搜集和学术文献检索，我之前更倾向于用 **[Perplexity Pro](https://mp.weixin.qq.com/s/XY8HiDRDwC59JZh7QoUBrQ)** 。它的 Academic 模式可以把信源限定在学术论文，Reasoning with R1 模式则能做带联网的深度反思式搜索。两个工具配合，调研效率直接起飞。只不过，使用过程里， **[你需要注意甄别幻觉带来的影响](https://open.substack.com/pub/wangshuyi/p/perplexity-deep-research?r=3fbs5&utm_campaign=post&utm_medium=web&showWelcomeOnShare=true)** 。

还有 **[Kimi Researcher](https://open.substack.com/pub/wangshuyi/p/3ai?r=3fbs5&utm_campaign=post&utm_medium=web&showWelcomeOnShare=true)** ，它的特长是生成细粒度引用标注的行业分析报告。之前我展示的时候，它还在测试阶段，一次性可以处理 20-100 个参考来源，跑 70 多条搜索，然后整合成一份带大量参考来源的深度报告。而目正式版推出时， Kimi Researcher 能力进一步提升，一次能搜集 200 多个网页。感兴趣的话，你可以试试。

不过，目前我更喜欢用自己的深度调研 Skill 。应星友「梅梦」的要求，我已经把这个 Skill 开源。

![](https://substackcdn.com/image/fetch/$s_!NL2G!,w_424,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F8a0b08d7-c910-4f07-95f5-1879ad54cd3c_1370x858.png)

开源地址在 **[这个 Github 项目](https://github.com/wshuyi/deep-research)** ，欢迎你来尝试。

![](https://substackcdn.com/image/fetch/$s_!f7gq!,w_424,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F45d98a77-fb96-42e5-a6f4-9377425aeabb_3024x1572.png)

觉得好用的话，别忘了给颗星哦。

再说 **文本创作与润色** 。

**[Claude Sonnet 4.5](https://open.substack.com/pub/wangshuyi/p/claude-35-sonnet-ai?r=3fbs5&utm_campaign=post&utm_medium=web&showWelcomeOnShare=true)** 曾经是我的「长文主笔」。它在长上下文保持和指令遵循方面表现出色，我常用它的 Thinking 模式来处理 2000 字以上的高质量文稿，且在当时是罕见的能从头到尾保持输出风格一致的模型。2025 年下半年，Anthropic 发布了 Opus 4.5，在复杂推理任务上进一步提升，但它的价格更贵，综合对比下来 Sonnet 4.5 仍是性价比更高。

短文润色和交互式修改，我曾经给你演示过用 **[GPT-4o with Canvas](https://open.substack.com/pub/wangshuyi/p/gpt-4o-with-canvas?r=3fbs5&utm_campaign=post&utm_medium=web&showWelcomeOnShare=true)** 。它的「画布」界面特别适合对语音转写稿做分段、纠错、去口癖、风格转换。你可以直接在界面上点选要改的地方，跟编辑器一样直观。

目前，我更多使用的是 **[Dessix](https://app.dessix.io/auth/register?invite=2KB3WT)** 和 Youmind 来完成写作辅助任务。二者都集成了多种优秀顶级模型，而且都内置 Agent 工作方式，且支持上下文对齐。

我最近还 **[专门给 Dessix 录制了一个使用教程视频，你可以参考这里来了解](https://www.bilibili.com/video/BV1LyrgBtEeP)** 。

**编程与自动化开发** 这块， **[Windsurf 和 Cursor](https://open.substack.com/pub/wangshuyi/p/windsurf-cascade-ai?r=3fbs5&utm_campaign=post&utm_medium=web&showWelcomeOnShare=true)** 过去是我的「工程师双雄」。

Windsurf 的 Cascade 引擎有个很酷的能力：它能自己「思考 — 行动」循环。你跟它说想要什么功能，它会自己去理解代码库、安装依赖、写代码、修 bug，最后给你交付一个能跑的原型。这不是辅助编程，这是「你说我干」的自动化开发。

**[Cursor 的优势](https://open.substack.com/pub/wangshuyi/p/ai-cursor?r=3fbs5&utm_campaign=post&utm_medium=web&showWelcomeOnShare=true)** 在于对整个项目的深度理解。它的 Chat with codebase 功能可以让你用自然语言问整个代码库的问题，代码补全也相当智能。我通常让 Windsurf 做原型，Cursor 做精细打磨。

还有 OpenAI Codex CLI，用于系统级的项目设计与大规模代码重构，它在跨文件联动修改时比 Claude Code 表现更稳健，能保持逻辑的一致性。我还给你讲解过 **[Roo Code](https://open.substack.com/pub/wangshuyi/p/ai-agent-mcp?r=3fbs5&utm_campaign=post&utm_medium=web&showWelcomeOnShare=true)** 配合 Quasar Alpha 等免费模型，可以低成本执行 AI Agent 工作流，并通过 MCP (Model Context Protocol) 调用外部 API 工具。

当然，你知道的，现在我基本上已经全面转向 Claude Code 了。而且，我别说对比代码修改了，连手敲基本上都免除了。我直接用麦克风对着 Claude Code 一通指令，然后坐等收获结果即可。

我曾经打趣说，未来的键盘应该是这样的。

![](https://substackcdn.com/image/fetch/$s_!djDV!,w_424,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F00814aa0-f466-41e9-a823-c829a6285f5a_1696x2528.jpeg)

**多媒体与知识摄取** 方面：

**[Readwise Reader](https://mp.weixin.qq.com/s/iECufpascwJuzW4oKxhnuQ)** 是我的「通用收件箱」，归拢网页、Epub 电子书、PDF、邮件订阅和 YouTube 视频。我定制了 Ghost Reader 提示词，它会自动生成深度摘要。不过目前，这个功能大抵会通过 **[Youmind](https://youmind.com/invite/WXXAG8)** 来完成。那感觉，太顺滑了。

**[Get 笔记（得到）](https://mp.weixin.qq.com/s/XdktpeaSbOuxVFeL2v18Lg)** 是「随时随地的记录助理」，负责采集语音灵感、拍摄幻灯片，并自动进行 AI 润色、标题提炼和结构整理。今年的跨年演讲，罗胖介绍了 GetSeed 这个与之配合的硬件产品。我元旦一早就下单，到现在还没发货呢。这个得尝试之后才能跟你分享了。

**[Recut](https://mp.weixin.qq.com/s/JvwkkSBYHAw7PdLc_qELCA)** 是视频剪辑的「初剪助理」，自动识别并切除视频中的无声片段和冗余停顿。

**[Napkin.ai](https://mp.weixin.qq.com/s/w3-Y86fulDqkjCbIZO1LyA)** 是「视觉设计师」，根据文本内容自动生成各类逻辑图、四象限图和流程示意图。不过目前视觉设计我更喜欢用 Nano Banana Pro ，尤其是可以和研究结合起来做。我做了个工作流，还分享了出来， **[你可以点击这个链接参考](https://open.substack.com/pub/wangshuyi/p/ai-5cf?r=3fbs5&utm_campaign=post&utm_medium=web&showWelcomeOnShare=true)** 。

**[ChatTTS](https://mp.weixin.qq.com/s/n83dYXceqNRoK8SBaAt3-g)** 曾经是我首选「金牌声优」，负责将文本转换成极具拟人感的自然语音，支持加入笑声等情绪控制。目前我更多使用的是 ListenHub 。我用它克隆了自己的声音，在 B 站和视频号上，你应该已经看到了 **[不少我的图文并茂解读短视频](https://www.bilibili.com/video/BV1ugUQBEE4j)** ，都是用它飞速生成的。

讲得够不够多，我觉得不少了。全面吗？恐怕没有。可这就是我践行「重器轻用」的现状 —— 不追求 All-in-one，而是让工具做自己最擅长的。

## 问题二：如何像管理公司员工分配业务一样，给这些 AI 工具划分「工作职责」？

工具有了，怎么让它们「各司其职、协同配合」？我有一套分层管理的方法。

但是，与你想象的或许有区别。我最先思考的，并不是如何给 AI 分配岗位，而是 **首先是确立人机协作的权责边界** 。我把它叫做「 **[红绿灯原则](https://open.substack.com/pub/wangshuyi/p/ai-02f?r=3fbs5&utm_campaign=post&utm_medium=web&showWelcomeOnShare=true)** 」：

- **红灯区（人类主导）：目标设定、价值判断、意义赋予——「为什么要做这件事？」「这个方向对不对？」这些问题只能我自己回答。AI 可以给信息、帮分析，但最终拍板的必须是人。这是人机协作的底线。**
- **绿灯区（AI 主导）：代码实现、重复性数据分析、初步润色、格式转换……这些「怎么做」的执行层工作，完全可以交给 AI。它比我快，比我不容易累，而且不会抱怨加班。放手让它干，追求极致效率。**
- **黄灯区（协同）：真正有意思的合作发生在中间地带——持续互动、不断校准。你给一个初稿，AI 帮你改；AI 给一个方案，你来审；你提出疑问，AI 帮你论证。这种方式被称为「人在环中」。 其次是采用多智能体（Multi-Agent）协同架构。**

我设计过一套 **[7 代理的内容创作框架](https://open.substack.com/pub/wangshuyi/p/ai-agent-e1e?r=3fbs5&utm_campaign=post&utm_medium=web&showWelcomeOnShare=true)** ：Stylist（风格导演）维护风格一致性；Coordinator（项目经理）审计素材；Researcher（调研专家）验证数据来源；Outliner（结构建筑师）规划逻辑路径；Writer（内容创作者）撰写草稿；Editor（质量守门员）进行三重审查；Publisher（发布大使）负责最终交付。

这些 Agent 之间有严格的「交接协议」——通过 STATUS.yaml 状态机驱动，前一个环节的输出必须 100% 通过验证（二值化原则，只有 YES 或 NO），下一个环节才能开始。

为什么要这么麻烦？因为 AI 会「自信地犯错」。单一模型跑完全流程，错误会累积放大。但如果让不同的「员工」各管一摊、互相检查，质量就有保障了。

**第三是实施模型间的「同行评议」（Peer Review）** 。

我经常 **[让一个模型写东西，然后让另一个模型来审](https://open.substack.com/pub/wangshuyi/p/1bf?r=3fbs5&utm_campaign=post&utm_medium=web&showWelcomeOnShare=true)** 。比如曾经给你展示过的用 GPT-5 Pro 生成复杂的预处理 XML 标记，再交给 Claude Sonnet 4.5 或 Gemini 2.5 Pro 执行具体输出。不同模型有不同的「盲区」，互相审一遍，能过滤掉不少问题。

**第四是建立「认知调音」的工作流** 。

写作遇到瓶颈的时候，我不会让 AI 帮我代笔。我会让它作为 **[「认知分析师」](https://open.substack.com/pub/wangshuyi/p/1b2?r=3fbs5&utm_campaign=post&utm_medium=web&showWelcomeOnShare=true)** ，用「认知利刃」分析我初稿里的逻辑瑕疵和价值观偏差。它帮我思考得更深，而不是替代我思考。这是一种「AI 辅助人类升级认知」的模式，而非「AI 替代人类输出」。

而随着以 Claude Code 为代表的 AI Agent 能力愈发强大，以前需要你手动调度 AI 模型的情况，会变得更少。

例如说，你可以使用 OpenCode + Oh my Opencode 插件，一下子就内置多个不同的 Agent 模型。它们本来就有非常好的角色分工。需要的时候自适应调用，根本不需要你事必躬亲地干预。

而那些原本需要你在不同工具间来回拷贝的数据和指令，也可以借由 Skills + MCP 的形式，交互调用。

我昨天甚至偷懒到干脆去查询能不能从 Claude Code 直接调用 Manus 干活儿。 ChatGPT 居然也真的给了结果， **[给我指向一个 Manus MCP](https://lobehub.com/pl/mcp/nanameru-manus-mcp)** 。

![](https://substackcdn.com/image/fetch/$s_!_7EX!,w_424,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fad17a577-5330-4e02-bb05-88fe0f760b55_2034x1508.png)

随着这些交互协议继续发展，我真的无法想象未来的工具协同可以达到一个什么样的复杂度和灵活性。

## 问题三：整体工作流程中，AI 工具的介入带来了哪些效率提升？具体体现在哪些环节？

说几个真实的数字。

**文献回顾阶段：从几个月到 15 分钟。**

以前做一个系统性的文献综述，光是搜集资料、筛选论文、整理要点，就得花上好几个月。而如果你用 **[Deep Research 或 Kimi Researcher](https://open.substack.com/pub/wangshuyi/p/ai-f03?r=3fbs5&utm_campaign=post&utm_medium=web&showWelcomeOnShare=true)** ，11 到 15 分钟就能拿到一份数据翔实、引用准确的报告。当然，你也可以选择使用 **[我的深度调研 Skill](https://github.com/wshuyi/deep-research)** 。

这不是说 AI 替代了深度思考 —— 最终的分析判断还是要自己做。但资料搜集这个苦力活，确实被大幅压缩了。

还有更夸张的。 **[Elicit 的系统化综述功能](https://open.substack.com/pub/wangshuyi/p/ai-f03?r=3fbs5&utm_campaign=post&utm_medium=web&showWelcomeOnShare=true)** 可以一次性从 500 篇论文里自动抽取研究设计、参与者特征、关键发现，整理成结构化的对比表格。你想象一下，人工做这件事得多久？

**内容创作环节：从「码字」到「拼图」。**

有了好用的 AI 工具们，我 2024 年末的写作工作流就已经是这样的：语音录入零散点子， **[Get 笔记自动整理](https://mp.weixin.qq.com/s/XdktpeaSbOuxVFeL2v18Lg)** ， **[Claude Sonnet 4.5 提炼大纲](https://open.substack.com/pub/wangshuyi/p/claude-35-sonnet-ai?r=3fbs5&utm_campaign=post&utm_medium=web&showWelcomeOnShare=true)** ，GPT-4.5 润色风格，最后人工审定发布。整个流程「端到端」打通，效率提升了好几倍。而现在，我有了更多更好的选择。例如语音输入部分，再也不用被识别准确率低的问题困扰。 **[我用的 Typeless](https://www.typeless.com/?via=shuyi)** ，可以快速帮我把混乱的思绪、中间错误的表述全部修理，然后干净利落来输出。最近一次组会，我用它配合 Claude Code 演示，学生们看愣了。

遇到写作障碍怎么办？我曾经会用 **[Tana AI Builder 或 Lex 的自动补全功能](https://mp.weixin.qq.com/s/niRVxs0PPyiVuXftyqExNQ)** —— 给它看我写了一半的段落，让它帮我接着往下写几句。不一定用它的内容，但能帮我迅速回到心流状态。现在，这个功能 **[已经被 Dessix 替代了](https://app.dessix.io/auth/register?invite=2KB3WT)** 。

**多语种发布与国际化：高质量翻译。**

早在 2024 年夏天，我就采用宝玉老师提出的「 **[三步翻译法](https://open.substack.com/pub/wangshuyi/p/ai-64b?r=3fbs5&utm_campaign=post&utm_medium=web&showWelcomeOnShare=true)** 」：先直译，再反思，最后意译。当时用 Claude 3 Opus 或 Gemini 1.5 Flash 处理长文，翻译质量已经能达到甚至超过专业翻译工具，成本只有原来的几分之一。而现在，我干脆利用 Claude 4.5 Opus 模型，加上一个类似的 Skill ，把原文扔进去，直接等最终结果即可。

**软件开发与数据处理：原型快速落地。**

2025 春季学期，有一次我用 **[Claude Code](https://open.substack.com/pub/wangshuyi/p/ai-02f?r=3fbs5&utm_campaign=post&utm_medium=web&showWelcomeOnShare=true)** ，10 分钟就完成了学生苦战多时的原型系统功能，而且「一稿过」。这是「氛围编程」的威力 —— 你描述需求，AI 理解意图，自动实现。你要做的只是审查结果、提出修改意见。编程从「逐行码字」变成了「指挥施工」。

数据分析上，我曾经给你介绍过 **[Code Interpreter 和 Open Interpreter](https://open.substack.com/pub/wangshuyi/p/open-interpreter?r=3fbs5&utm_campaign=post&utm_medium=web)** 。你上传原始数据，它直接给你生成 **[3D 交互图、动态视频](https://mp.weixin.qq.com/s/ouOx8e0EuAspvAeWEaTzUg)** ，甚至构建预测模型。全自动，不需要你写一行代码。当然，现在这些功能，基本上都被新一代 Agent 框架给吞掉了。想想看， **[Claude Code 不仅能按照你的指令来分析，甚至可以评估你给出的分析模型和路径是否符合最新研究共识](https://www.bilibili.com/video/BV12eMMz6EtW)** 。这种感觉，是不是很奇妙呢？

这些效率提升加起来，意味着什么？ **意味着你可以产出更多，而时间成本更低。**

而且，现在模型、工具、使用方式还在爆发期。真实应接不暇啊。有的时候，昨天 AI 干不了的事儿，明天就见惯不怪。所以，你真的可以靠着科技进步来躺赢啊。哈哈。

## 问题四：对于知识资产的管理与储存，有什么好方法？AI 工具在这方面如何发挥作用？

我搭建了一套「本地优先、云端同步、AI 赋能」的知识管理系统。

**先说架构，我叫它「入口—出口—资产管理—隔离区」四层结构** ：

**入口是「混沌存储」** —— **[Get 笔记](https://mp.weixin.qq.com/s/XdktpeaSbOuxVFeL2v18Lg)** 采集的录音、图片、网页剪藏，先不管归档，扔进去就行。这是信息的「钩子」，确保灵感不丢失。我现在开组会的时候，都会用 Get 笔记帮我记录全部内容，然后在 Youmind 或 Claude Code 里按照定义的 Shortcut 或 Skill 来整理重点，非常方便。

**出口是「稳定归档」** ——最终的成果（文章、报告、笔记）存在 **[Obsidian](https://open.substack.com/pub/wangshuyi/p/ai-c9e?r=3fbs5&utm_campaign=post&utm_medium=web&showWelcomeOnShare=true)** 里。为什么选它？因为 Markdown 纯文本格式， **[十年后也能打开](https://mp.weixin.qq.com/s/FlFUSOW-e0_nDGwaTdzEVg)** 。笔记软件公司可能倒闭，但.md 文件永远能用。

**中间是「资产管理」** —— **[DEVONthink](https://open.substack.com/pub/wangshuyi/p/dd9?r=3fbs5&utm_campaign=post&utm_medium=web&showWelcomeOnShare=true)** 存放较大的附件、视频、项目佐证材料。配合 Hookmark 的「深链接」技术，不同应用之间可以一键跳转。

**还有个「隔离区」** ——日记和高敏信息存在 Day One，开启端到端加密。这里 **[严禁任何 AI 接入](https://open.substack.com/pub/wangshuyi/p/ai-c9e?r=3fbs5&utm_campaign=post&utm_medium=web&showWelcomeOnShare=true)** 。有些东西属于人类的「体感数据」，不该让 AI 看到。

**再说 AI 怎么帮忙——对话式检索（RAG 增强）** ：

2024 年，我就给你介绍过 **[Cursor 或 Obsidian Copilot 插件](https://open.substack.com/pub/wangshuyi/p/ai-f0d?r=3fbs5&utm_campaign=post&utm_medium=web&showWelcomeOnShare=true)** 可以对整个笔记库进行自然语言提问。AI 会把你的笔记切片、向量化，然后在回答时精准引用具体文件的原文和行号。就像有个助理把你所有的笔记都看过一遍，随时可以帮你查。

**[NotebookLM](https://mp.weixin.qq.com/s/vIdSI8hFLhsM6r7pg0jRxg)** 更进一步：你把多篇相关文献或文章上传进去，它可以跨文档进行语义检索。我问过它「我过去三年对 AI 素养有过哪些论断」，它给了我一份带原文引用的综合分析。这种「 **[问自己的知识库](https://open.substack.com/pub/wangshuyi/p/notebooklm-alma?r=3fbs5&utm_campaign=post&utm_medium=web&showWelcomeOnShare=true)** 」的能力，以前是不可想象的。

另外，你也可以想想，如果没有 NotebookLM ，我怎么能在这么短的时间里，找到星友提问覆盖的那么多的资料呢？

**最后说一个我认为很重要的观点：「知识资产负债化」** 。

以前我们追求「囤积」——收藏越多、笔记越厚，好像就越有知识。但现在我觉得， **大规模的信息囤积是「负债」，不是「资产」** 。

为什么？因为首先 **[AI 可以充当「全球顶级快递员」](https://open.substack.com/pub/wangshuyi/p/ai-602?r=3fbs5&utm_campaign=post&utm_medium=web&showWelcomeOnShare=true)** ，随时帮你搬运信息。你不需要把所有东西都存在本地 —— 需要的时候，让 AI 去找、去整合就行了。

其次，AI 搬出来的东西，还是需要我们自己来甄别的。有的时候，存储内容多，并不一定好。

这篇文章给你介绍的内容，就是个典型事例。想想看，我们列举了这么多我曾经发布内容中的资料来回答星友问题。这固然很好。但如果我不给你一一点评更新进展，你是不是会学到很多真实、准确，但早已 **过时** 的方法？

所以我的知识库不再是「仓库」，而是「画室」(Studio)。重点不在于存了多少东西，而在于能产出什么作品。AI 提供「预制件」，我负责组装、创造、赋予意义。最终的产出，才是真正的知识资产。

## 小结

星友提出的四个问题回应完了。估计你那边已经「信息过载」了吧？

别担心。核心其实就一句话： **让每个 AI 工具在正确的位置发挥作用** 。

这不是「人被 AI 取代」，这是「人借助 AI 放大能力」。人的角色是掌舵者 —— 你决定方向，AI 负责执行；你把控质量，AI 提升效率；你赋予意义，AI 处理信息。

好，现在轮到你了。打开你的电脑，看看那堆 AI 工具的图标 —— 你准备让哪个先「上岗」？让哪几个「打配合」呢？

更重要的，你准备在这个工作流里，充当何种角色？

欢迎留言，分享你的经验和智慧。咱们一起交流讨论。

如果你喜欢本文，别忘了点赞。

欢迎把文章转发给你的朋友，或者在社交媒体上分享。

如果你想看更多的内容，欢迎付费订阅本专栏。每个月更新不少于3篇 **会员专享** 文章。目前价格优惠。

## 延伸阅读

- **[AI 时代到来，我还在用哪些笔记应用？](https://open.substack.com/pub/wangshuyi/p/ai-c9e?r=3fbs5&utm_campaign=post&utm_medium=web&showWelcomeOnShare=true)**
- **[AI 时代，你的知识管理工具该扔了吗？](https://open.substack.com/pub/wangshuyi/p/ai-602?r=3fbs5&utm_campaign=post&utm_medium=web&showWelcomeOnShare=true)**
- **[AI 应用蓬勃爆发，你的「护城河」足够宽吗？](https://mp.weixin.qq.com/s/-H-Q70wBTDaN7APYnRhI6g)**
- **[AI 时代的真稀缺技能：从「有技术」到「会洞察」](https://open.substack.com/pub/wangshuyi/p/ai-fee?r=3fbs5&utm_campaign=post&utm_medium=web&showWelcomeOnShare=true)**
- **[新学期，给你自己配一个好用的 AI 助手吧。会思考，能联网，还有知识库那种](https://open.substack.com/pub/wangshuyi/p/ai-8e3?r=3fbs5&utm_campaign=post&utm_medium=web&showWelcomeOnShare=true)**