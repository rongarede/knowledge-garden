---
title: "如何用 Claude Skill 帮你一句话做深度调研并自动画图？"
source: "https://wangshuyi.substack.com/p/claude-skill"
author:
  - "[[Wang Shuyi]]"
published: 2026-01-04
created: 2026-01-19
description: "在 AI 时代，​「知道怎么画图」​已经不重要了，「知道该画什么图」以及​「提出一个好问题」​才是核心竞争力。"
tags:
  - "clippings"
maturity: budding
---
### 在 AI 时代，「知道怎么画图」已经不重要了，「知道该画什么图」以及「提出一个好问题」才是核心竞争力。

![](https://substackcdn.com/image/fetch/$s_!fTMs!,w_424,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F9eb8c39d-a6b4-425e-b690-6952b128b21d_2752x1536.jpeg)

## 缘起

元旦假期我在家里翻手机相册，偶然看到了去年差不多这个时候，去的廊坊「只有红楼梦・戏剧幻城」。

![](https://substackcdn.com/image/fetch/$s_!FKjB!,w_424,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F5494c7a6-b53b-4194-b203-3fa284b2bc49_2048x1536.jpeg)

这是我在戏剧幻城的《床》剧场被当成幸运观众（一群演员拿我当初生婴儿一般戏耍）时拍摄下来的照片。

那两天的旅行非常值得回味。谈起《红楼梦》，虽然我读过不止一遍，但里面那些人物之间的关系，我总是记不太清楚，于是就打算做一张人物关系图出来。

我希望以矢量图的方式输出成 PDF，图片较小，而且可以无损缩放。人物很多，你懂的。

这个活要在以前，基本上是先把人物关系确定，然后用绘图软件来制作。但是现在有了 AI，我想要的不再是那种「我喂给它数据，它帮我排版」的半自动化工具。因为那还得我去整理数据，多累啊。

我希望只给它一个模糊的指令（比如「去查查红楼梦人物关系」），它自己去联网搜索、自己去交叉验证、自己梳理逻辑，最后直接甩给我一张专业级的 PDF 矢量图。

众所周知，王老师是个懒人。因为太懒，所以我就造了这么个轮子 —— 一个叫做 `research-to-diagram` 的 Claude Skill。

### 演示

这东西到底有多省事儿？咱们直接看效果。当我把这个 Skill 制作好后，我在 **Claude Code** 只敲了一行自然语言指令：

> **深度调查《红楼梦》里人物之间的关系，然后做个结构图 PDF**

注意，我没有给它任何名单，也没有告诉它谁是谁的儿子，谁和谁是恋爱关系。

然后，我就揣着手，看着屏幕上的 AI 开始「疯狂干活」。

![](https://substackcdn.com/image/fetch/$s_!5ThG!,w_424,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fd22116de-8aaf-4f7e-bfb2-baa1c130093a_2324x1798.png)

它先是启动了 **WebSearch** ，第一轮搜「红楼梦金陵十二钗名单」；紧接着第二轮搜「宁国府荣国府谱系」；它发现贾母娘家是史侯，又去搜「四大家族联姻关系」……

这还没完，它搜集完信息后，开始像个老学究一样整理：谁和谁是夫妻（实线），谁和谁是政治联姻（虚线），谁是核心人物（标红）。

大概过了三分钟，它提示我搞定了，生成了一个 PDF。

打开一看，我乐了。

![](https://substackcdn.com/image/fetch/$s_!z-jP!,w_424,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Ff74dc705-bc77-4831-a34d-ab0a31567836_7680x3128.png)

宁荣二府分得清清楚楚，四大家族各占一个版块（Cluster），宝玉、黛玉、宝钗的三角关系一目了然，连贾雨村这种边缘人物都安排得明明白白。最关键的是，它是 **矢量图** ，放大十倍都不糊。

![](https://substackcdn.com/image/fetch/$s_!dxuT!,w_424,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F3dab853e-8330-4249-bb05-e2821ee0a052_3200x1946.png)

你看，以前要折腾几个小时的事儿，现在站起来倒杯水的功夫就齐活了。

我把这个图发布了出去，这是网友的评价。

![](https://substackcdn.com/image/fetch/$s_!u2Bj!,w_424,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F77d65083-2af4-4ad1-9793-51a8ceaea006_1170x708.jpeg)

除了红楼梦，我又试了试「春秋战国七雄关系」。

![](https://substackcdn.com/image/fetch/$s_!JO3I!,w_424,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fd2632dd7-7375-4809-a48c-6dcaedfe5026_3200x1725.png)

你看，合纵连横的局势、关键战役的时间点，它全给我画出来了，还贴心地用不同颜色区分了秦国和六国。

![](https://substackcdn.com/image/fetch/$s_!nnZW!,w_424,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F8a6aa83f-814f-4e8c-8138-0fd8004fef4c_3200x1725.png)

你看这就是构建 Claude Skill 的好处。 **把重复的认知劳动卸载给 AI，咱们只负责提问和欣赏。**

### 上手

看到这儿，我相信肯定有「苦画图久矣」的同学已经手痒了：「王老师，别光馋我，快说这东西怎么装。」

别急，我做的这个 Claude Skill 完全开源免费，但我得手把手教你避开几个坑。

首先，这工具的画图引擎是 **Graphviz** 。这是个老牌的神器，没有它实际去勾画，AI 也就是个只会空谈的理论家。

如果你用的是 Mac，打开终端（Terminal），输入这行命令，让它先把地基打好：

- ounter(line
- ounter(line
- ounter(line
```markup
brew install graphviz
```

要是你是 Linux 用户，就用 `apt-get install graphviz` 。

当然了，这些指令你也不用亲自去执行。你如果已经开启了 Claude Code，直接告诉它：

> 安装 graphviz

就可以了。

搞定了引擎，咱们来安装这个 Skill。最简单的办法，直接把我的仓库克隆到你的 Claude Skills 目录里。在终端里执行这几句就行：

- ounter(line
- ounter(line
- ounter(line
- ounter(line
- ounter(line
```markup
cd ~/.claude/skills
git clone https://github.com/wshuyi/research-to-diagram.git
```

或者你也可以在 Claude Code 里告诉它：我需要你执行这几句代码，然后贴给它代码。

没错，目前所有的终端命令，你全都不需要再自己掌握它该如何运行，以及中间报错该如何处理了。反正有 Claude Code 这个高级的参谋，它都能够帮你一一搞定。

装好之后，怎么用呢？

不需要什么复杂的配置，在 Claude Code 里，只要你的指令里包含「深度调查」、「研究…… 并生成图谱」或者「画…… 关系图」这些关键词，它就会自动触发。

比如，你想搞懂 Kubernetes 的架构，直接说：

> **研究 Kubernetes 架构并生成技术架构图**

它就会自动切换到「技术架构图模板」，把各种节点画得有模有样。

![](https://substackcdn.com/image/fetch/$s_!jvfF!,w_424,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F6dcb8f91-7ef9-47e3-88b7-e9bd9addd6ee_1920x1652.png)

记住， **一定要让它「研究」** 。如果你只说「画个图」，它可能就偷懒直接给你画个简单的；你让它「深度调查」，它才会去联网挖掘那些甚至连你都不知道的细节。

### 拆解

很多同学觉得 Claude Skill 神奇，像是变魔术。但其实， **没有魔法，只有逻辑。**

咱们把这个黑盒子拆开，看看它是怎么思考的。

![](https://substackcdn.com/image/fetch/$s_!GEPR!,w_424,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F8e18e86b-86a9-4f5c-9fb9-ea58e49bfd29_1756x1550.png)

这个 Skill 的核心逻辑，其实就是模拟了一个 **严谨的研究员** 的工作流，我把它设计成了「五步走」：

第一步是 **「轰炸式调研」** 。它不会只搜一次，而是分层搜。先搜背景（比如「春秋战国时间线」），再搜实体（「战国七雄是哪几个」），最后搜关系（「合纵连横是谁发起的」）。这就像咱们写论文做文献综述一样，得先有米，才能下锅。

第二步是 **「结构化翻译」** 。搜回来的一堆网页文本，AI 得把它们嚼碎了，提取出实体（Entity）和关系（Relation）。比如看到「贾政是贾母的次子」，它就提取出 `贾母 -> 贾政 [label="次子"]` 。

第三步是 **「视觉转译」** 。这是最见功底的地方。我给它预设了几套 **视觉语法** 。比如，人物关系图用 `rankdir=TB` （从上到下）布局，家族用 `subgraph cluster` 包起来；而历史时间线则用 `rankdir=LR` （从左到右）。

Skill 文档设置里特意叮嘱它：核心人物要用红色（#ff6347），普通人物用淡蓝（#e8f4f8），这样图谱才有层次感，不会像一盘散沙。

第四步，才是调用 Graphviz （或类似工具）生成 PDF。

你看，把经验翻译成代码，AI 就能帮你把这套方法论执行一万次，而且不知疲倦。

## 模型

看到这里，我知道你可能已经跃跃欲试，但是又觉得王老师颇有些「何不食肉糜」的味道。因为 Claude Code 订阅每个月最少也需要 20 美元。对你的心理账户来说，这个价格可能确实高了一些。

没关系，我们来安装和使用这个 Claude Skill，模型不一定非得选 Claude 4.5 opus，咱们可以选用国产的同类模型。

就在上个月，好几家国产 AI 企业的模型已经在 AI 编程领域达到了国际一线水平。其中，尤其以智谱 GLM-4.7 和 MiniMax M2.1 最具代表性。

其中智谱 GLM 搞了一个 **[跨年的编程计划优惠活动](https://www.bigmodel.cn/glm-coding?ic=SCVB26GQ9T)** 。

![](https://substackcdn.com/image/fetch/$s_!rkld!,w_424,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F632535a9-1791-46fb-aa1f-e5f7e2ec3ac1_2632x1304.png)

订阅一个季度的 Lite 方案， **[用我的邀请链接](https://www.bigmodel.cn/glm-coding?ic=SCVB26GQ9T)** 还能减 10%，只需要花费不到 50 块钱，平均每个月只需 10 几块钱。

![](https://substackcdn.com/image/fetch/$s_!sut4!,w_424,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F8883bc1c-8868-4583-b8af-5c212c0077ff_548x740.png)

我自己购买的是 Pro 方案，要贵一些。毕竟我平时上课、科研，用量较大。

![](https://substackcdn.com/image/fetch/$s_!92yG!,w_424,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F043c062d-b2b8-4341-8d1f-f758420f70cf_2562x888.png)

如果你轻度使用的话，用不着采用 Pro 这个级别的订阅。智谱 Lite 给的额度已经够用。

订阅完成后你需要新建一个 API Key。按照导航操作就行。

![](https://substackcdn.com/image/fetch/$s_!-676!,w_424,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fa974f146-e538-49bb-854f-c3450a9b2ce3_2534x660.png)

之后，你可以在 `~/.claude` 这个文件夹下面建立一个 `settings-glm.json` 文件。

![](https://substackcdn.com/image/fetch/$s_!jXqq!,w_424,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fd84d1e8c-6268-49ea-a2d1-9b60f74f5594_1400x730.png)

我这里打码的是我自己的 API key（因为隐私关系不能透露）。其他的你照着填就行。

然后启动的时候，你执行这一条指令就可以：

- ounter(line
- ounter(line
- ounter(line
```markup
claude --dangerously-skip-permissions --settings ~/.claude/settings-glm.json
```

此时你会发现，默认的模型已经切换到了智谱 GLM-4.7。

![](https://substackcdn.com/image/fetch/$s_!Bt7A!,w_424,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F1ba72535-1182-4504-8b71-a4e2806bdb0b_2324x1798.png)

下面你就可以用每个月十几块钱的优惠价格，畅玩 Claude Code 了。

### 小结

做这个工具，我不仅是为了省那几个小时的画图时间。

更重要的是，我想通过这个技能的演示告诉你：在 AI 时代， **「知道怎么画图」** 已经不重要了，「知道该画什么图」以及 **「提出一个好问题」** 才是核心竞争力。

当你把搜索、整理、绘图这些繁琐的认知负荷（Cognitive Load）都卸载给工具之后，你的大脑就能腾出空来，去思考《红楼梦》里家族兴衰的深层逻辑，去分析战国七雄背后的地缘政治。

这或许，才是咱们人类更该干的事儿吧。

这个 Skill 我已经开源在 GitHub 上了， **[链接在这里](https://github.com/wshuyi/research-to-diagram)** 。

![](https://substackcdn.com/image/fetch/$s_!aaCU!,w_424,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F2ee78e7d-5c58-4a6b-830f-77579a50e139_3200x1966.png)

你尽管免费拿去用。要是觉得好用，记得给加个 Star。要是遇到了 bug，或者有更好的想法（比如支持思维导图、流程图），欢迎提 Issue 或者 PR，咱们（结合各自的 AI Agent）一起把它打磨得更顺手。

如果你喜欢本文，别忘了点赞。

欢迎把文章转发给你的朋友，或者在社交媒体上分享。

如果你想看更多的内容，欢迎付费订阅本专栏。每个月更新不少于3篇 **会员专享** 文章。目前价格优惠。

## 延伸阅读

- **[AI 工作流长文写作能力重大改进，欢迎你来试试看](https://open.substack.com/pub/wangshuyi/p/ai-eb5?r=3fbs5&utm_campaign=post&utm_medium=web&showWelcomeOnShare=true)**
- **[AI 时代，请停止「做作业」，去创造属于你的「作品」](https://open.substack.com/pub/wangshuyi/p/ai-617?r=3fbs5&utm_campaign=post&utm_medium=web&showWelcomeOnShare=true)**
- **[从枯燥理论到生动实践：AI 智能代理如何用交互式教程讲解复杂概念](https://open.substack.com/pub/wangshuyi/p/ai-d9c?r=3fbs5&utm_campaign=post&utm_medium=web&showWelcomeOnShare=true)**
- **[Midjourney 能识图了，这是个好事儿吗？](https://mp.weixin.qq.com/s/z6AYsYZGGJx3GNGQaybTRQ)**
- **[人工智能绘图应用 DALLE 2 开始公开测试了](https://mp.weixin.qq.com/s/SdQPj3RPogzcGogdbNO6yA)**