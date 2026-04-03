---
title: "如何用 Claude Skill 做一套会自己干活的知识库？"
aliases: [Claude Skill 知识库, NotebookLM 工作流, 会自己干活的知识库]
date: 2026-01-18
tags: [AI/Claude, AI/Skill, AI/知识库]
up: "[[_ai_moc]]"
status: active
source: "https://wangshuyi.substack.com/p/claude-skill-fdc"
author:
  - "[[Wang Shuyi]]"
maturity: evergreen
---

# 如何用 Claude Skill 做一套会自己干活的知识库？

## 概述

> [!abstract]
> ==知识库的价值不在于「建」，而在于「用」。==

^skill-kb-overview

![](https://substackcdn.com/image/fetch/$s_!5CU_!,w_424,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F461cd00b-4539-4c75-8d24-bb0ffa54b0c1_2752x1536.jpeg)

周四晚上我发出去一篇文章《 **[我的 AI 工具日常使用与工作流是怎样的？](https://open.substack.com/pub/wangshuyi/p/ai-ba0?r=3fbs5&utm_campaign=post&utm_medium=web&showWelcomeOnShare=true)** 》，回答了星友张文茹在星球上提的四个问题。到第二天一早，短短十几个小时，转发已经 600 多次了。

![](https://substackcdn.com/image/fetch/$s_!TCIg!,w_424,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F3e1aa904-464a-41d9-a9ba-7e14d0970816_1744x398.png)

评论区很热闹，不少人说从中学到了新东西。

![](https://substackcdn.com/image/fetch/$s_!FyJM!,w_424,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F791b4eb5-be89-408c-9f0c-8d93661f818f_1000x620.png)

提问者本人也表示很有收获。

![](https://substackcdn.com/image/fetch/$s_!26gQ!,w_424,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F35ec6443-56be-4ef0-ba23-9814cc74f7e1_1218x368.png)

但我想让你回看一下，文茹提的这四个问题究竟是什么。

![](https://substackcdn.com/image/fetch/$s_!ar2n!,w_424,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F9ff302af-0165-4156-861e-ce95ab2fefa8_1396x912.png)

你觉得这四个问题好答吗？

肯定不好答。因为它需要梳理我之前各种工具使用记录。别说是我自己平时的零散笔记，就仅仅是我正式发布过的文章，现在让我合上电脑一一如数家珍地复述，恐怕我也做不到。

AI 工具的到来让我们每个人都应接不暇。我一直在研究 AI 应用，使过的工具数量繁多。有些工具的体感让我记忆深刻，但更多的工具只在短短一段时间内留下印象，现在你冷不丁让我回顾，可能我连想都想不起来。

但你如果看过那篇文章就会发现，我不仅指出了以前介绍过的工具是什么，还进一步给出了延伸阅读的链接，帮助读者快速定位。

![](https://substackcdn.com/image/fetch/$s_!wm-i!,w_424,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fb071f376-9ae7-469a-901c-85c81731de3d_1508x1208.png)

上图中红色方框框起来的，都是指向我之前已发布文章的链接。这就使得发布过的文章形成了一张网络，而不是散落的珍珠。

如果你对我很了解，你会知道我上次做这么完整的索引，还是在 2018 年。之后这样的事，我再也没完整重复过。

![](https://substackcdn.com/image/fetch/$s_!bleA!,w_424,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fe970db36-d677-4f91-9678-391c6f6b4a83_1778x1558.png)

因为维护一个这么庞大的索引，工作量超负荷。王老师是个懒人。而懒人显然不愿意吭哧吭哧地手动去做这些事。

况且如果你很细心的话，对比一下时间戳，你会发现从文茹提问到我这篇文章完成，中间隔了多久。其实只有短短几个小时。这期间如果「刀耕火种」手动完成这些工作量，光是找到这些资料并找到它们对应的发布链接，你觉得够吗？

况且那一天我还要上班，帮学生修改开题报告、开会…… 不可能全部时间都用于写作这篇文章。

所以自然就有熟悉我的读者跟我提问了：

> 王老师您这篇文章是用什么工具写的啊？

![](https://substackcdn.com/image/fetch/$s_!nyN8!,w_424,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F107701fb-ffde-4ccd-a088-28a43ba9bc53_948x402.png)

不愧是关注了我 7 年的老读者了。我也很诚实地回答：工具 **确实起到了辅助作用** 。

于是这篇文章，就是我承诺给读者的，咱们的揭秘时刻。

---

## 痛点

^skill-kb-painpoint

说起来，也不神秘。我构建了一个特别好用的知识库。

你可能嗤之以鼻，这算什么秘密？

别着急，你听我详细讲讲，就知道我这套知识库的特点了。

我的==知识库==主要用 Google 家的 **[NotebookLM](https://notebooklm.google.com/)** 来做。从 2024 年我刚开始使用时， **[就经常把它的能力通过演示分享给你](https://www.bilibili.com/video/BV1Hf42117Dq/)** 。那时候让我比较惊叹的，一是它找资料之全和准，二是它可以帮咱们做播客，以不同的方式提供信息消化的渠道。

但用久了，我发现 ==NotebookLM== 问题也很明显。

**首先是同步。** 我这边一直在写，公众号、知识星球都有文章输出。这些文章都需要更新到知识库里。可每次都得手动把它们从 Obsidian 里挑出来，图片上传到图床，然后再把处理后的 markdown 文件手动导入到 ==NotebookLM==。想想我都觉得麻烦。

**然后是查询。** ==NotebookLM== 返回的回答虽然有引用标记 `[1]、[2]、[3]` ，但这些序号只能对应到笔记本内部的条目。我想写成文章，希望引用能指向这些文章的发布链接，让读者按图索骥。手动一个个查？200 多篇文章，我查到什么时候？

![](https://substackcdn.com/image/fetch/$s_!nLK5!,w_424,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F2df2878f-a22f-4b99-b809-22c8e60d9975_1840x1640.png)

**还有转化。** 就算我查完了，得到的结果还要导出、整理、格式化，才能用于写作。因为如果你只是单纯使用官方提供的答案后面的复制按钮，出来的结果粘贴到编辑器里就会变成下面这个样子：所有的引用都会消失。

![](https://substackcdn.com/image/fetch/$s_!a91q!,w_424,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F77c163f4-c2a8-4242-b636-2cef9cde1c0e_1724x1406.png)

所以你不得不借助编辑器插件，才能够保持这些链接。而且有的时候，编辑器的插件随着 ==NotebookLM== 的更新也会变得失效。

整个流程下来，几乎把我逼成了「仓库保管员」—— 知识囤了一大堆，但用起来费劲，不能从心所欲。

尤其是对于懒人来说。这不是个好不好用的问题，而是直接妨碍我真正使用的拦路虎了。

你如果跟我一样使用 ==NotebookLM== 作为知识库，大概也有类似的困境吧？

---

## 破局

^skill-kb-breakthrough

转机出现在我发现了一个开源项目。

那天我突然发现朋友提及 GitHub 上一个叫 **[notebooklm-py](https://github.com/teng-lin/notebooklm-py)** 的仓库。作者是 teng-lin，用 Python 写了一套 ==NotebookLM== 的 CLI 工具，作为 ==Skill== 可以配合 Claude Code 使用。

![](https://substackcdn.com/image/fetch/$s_!Ieui!,w_424,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F25fc537a-5a4d-4172-8662-fe3bbf405d81_1618x498.png)

==Claude Code== 是 Anthropic 推出的命令行 AI 工具，支持通过 ==Skill== 扩展能力。 **[关于 Claude Code，咱们之前已经多次介绍和演示过](https://open.substack.com/pub/wangshuyi/p/claude-code-quarto-markdown?r=3fbs5&utm_campaign=post&utm_medium=web&showWelcomeOnShare=true)** ，此处不再赘述了。

![](https://substackcdn.com/image/fetch/$s_!q3VN!,w_424,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F2714a4f2-5e60-4e12-8d77-9a5d673ddeca_3024x1574.png)

这个项目星数蹿升极快，几天之内就到了 1000 多。这说明用户们的需求是真实的 —— 大家都想把 NotebookLM 变成一个可以「被程序调用」的组件，而不是只能在网页上点来点去。

这个工具的核心逻辑很简单：它通过 Playwright 自动化浏览器完成 Google 登录，然后把认证状态保存下来。之后你在命令行里敲 `notebooklm ask" 问题 "` 就能拿到答案，敲 `notebooklm generate audio` 就能生成播客。不用打开浏览器，不用手动复制粘贴。

你可能想到了，我之前在《 **[NotebookLM + Alma：从知识库挖掘答案，我为什么多绕这一道手？](https://open.substack.com/pub/wangshuyi/p/notebooklm-alma?r=3fbs5&utm_campaign=post&utm_medium=web&showWelcomeOnShare=true)** 》里介绍过另一个 ==NotebookLM== Skill。对，但那个 Skill 已经很久不更新。

况且它还需要安装不少虚拟环境，占用空间大。相比之下，这个 ==notebooklm-py== 轻量得多。我对比测试后，立即删掉了之前安装的那个。

![](https://substackcdn.com/image/fetch/$s_!nQie!,w_424,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fddba90e8-b5c2-4696-898c-8b12b934e493_1694x1086.png)

有了这个好用的知识库连接底座，我开始搭建自己的工作流。

---

## 工作流

^skill-kb-workflow

这个工作流，由以下几块「积木」拼搭而成。

**第一块积木：同步。**

我做了一个叫 sync-notebooklm-kb 的工具。它的核心逻辑很简单：对比本地文章目录和 ==NotebookLM== 里已有的来源，只添加新增的。一条命令就同步好了。

![](https://substackcdn.com/image/fetch/$s_!-Z3C!,w_424,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fdda5190b-7c5e-4ed7-9f0d-56c95510d1fd_2016x666.png)

更有用的是，在我的要求下，它能自动识别当前运行环境。在我的 MacBook 上，它找到了 Obsidian Vault 目录，以及我分类脚本。所以它会先运行文章分类脚本，处理图片，然后同步。在没有安装 Obsidian 的机器上（ **[例如我给你介绍过的远端 VPS](https://open.substack.com/pub/wangshuyi/p/337?r=3fbs5&utm_campaign=post&utm_medium=web&showWelcomeOnShare=true)** ），它会从 Git 仓库拉取最新文章，直接对比同步。这样我不管在哪台机器上，都能保持知识库同步更新。

**第二块积木：查询。**

光有 notebooklm-py 还不够。每次查询我都得指定笔记本、自己写提示词、处理返回格式。

![](https://substackcdn.com/image/fetch/$s_!Yit9!,w_424,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F14de0ef8-4438-4b49-b8e9-d91164ab4ea4_1326x1200.png)

这样没问题，不过是勤快人的处理办法，我们懒人可不愿意这么做。

于是我给它加了一层包裹（wrapper），做成一个 ==Skill==，叫 nb-query。这个技能有几个让我自己觉得特别好用的点。

首先是「超富集」模式。普通查询追求简洁，可能遗漏边缘信息。但我要的是写文章的素材，需要「宁多勿少」。所以我在提示词里明确要求：不要精简，把所有相关内容都整合进来。多角度覆盖，保留细节，标注引用。

![](https://substackcdn.com/image/fetch/$s_!TRxx!,w_424,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Faf128d4c-3ddc-4e93-8dc7-abbd85a70d5)

其次是引用对照表。NotebookLM 返回的 `[1]、[2]、[3]` 原本只是数字。我让 ==nb-query== 自动解析 JSON 响应，生成一张「序号 → 文章标题」的映射表。这样我就知道每个引用来自哪篇文章了。

![](https://substackcdn.com/image/fetch/$s_!T2xg!,w_424,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fe9e2ea0a-02cc-436a-9b9a-fb01ce8227da_2896x1444.png)

**第三块积木：素材整理。**

查询结果拿到了，但引用序号 `[1]、[2]、[3]` 还是不能点击。我需要把它们映射成已发布文章的外部链接。于是我引入了素材整理 Skill。

它读取对照表，从 Google Sheet 同步我的发文记录，查找 nb-query 输出结果中每个引用标题对应的外部链接（微信、知乎、少数派……），然后把 `[1]` 这样的引用编号变成 `[参考这篇文章](https://mp.weixin.qq.com/s/xxx)` 这样的格式。读者点一下就能跳转到原文。

![](https://substackcdn.com/image/fetch/$s_!EL8V!,w_424,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Ffd7d2584-282e-4b7f-975d-68b62a91511e_1568x530.png)

它还会把原始问题记录穿透，传递给下游的写作环节。这样写作的时候就知道读者想问什么，可以「有的放矢」。

![](https://substackcdn.com/image/fetch/$s_!uWZl!,w_424,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fa79af9a0-ac84-4db5-ba9d-2ba0d3b0464e_3248x1992.png)

素材整理还有另外一个特别重要的特性，那就是能够进行事实核查，并且直接提醒用户来自知识库的信息是否过时。

例如下面这些检查结果所示。

![](https://substackcdn.com/image/fetch/$s_!t7D8!,w_424,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F6dd89f2b-9c48-4b6e-8772-5c4653583935_3248x1992.png)

你看，这样你引述知识库内容的时候，就可以避免因为年代久远（其实只不过是前年），就由于信息过期导致贻笑大方的事儿。

---

## 协作

^skill-kb-collab

上面我构建的这几个 Skill 你当然都可以单独用，但真正的威力在于它们能配合。

我让 ==nb-query== 在查询前自动调用 ==sync-notebooklm-kb== 同步知识库，避免因为遗漏新文章导致查询不全面。查询完成后自动调用 ==material-to-markdown== 生成带链接的素材，让后续写作更加舒畅。

没错，在 Claude Code 里面，==Skill== 可以顺序调用，甚至可以嵌套调用。这使得排列组合带来的想象空间大大提升。

![](https://substackcdn.com/image/fetch/$s_!e9sD!,w_424,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F570f877b-1296-4feb-b327-f8d12c5777a7_1173x129.png)

如上图所示，整个流程串起来，我只需要告诉它问题是什么，剩下的它自己干。

于是，当我做好这些 Skill ，并且让它们开始配合执行的时候，效率就「爆起」了。

---

## 进化

^skill-kb-evolution

如果你把 ==Skill== 当成一次写就，然后必须依循的「金科玉律」，那就与它的设计初衷大相径庭了。

它最大的好处，在于可以「进化」，而且是那种 **自己就能调整的进化** 。

例如用了一段时间后，我发现一个问题：「标题 → 链接」的映射逻辑，在 nb-query 和 material-to-markdown 里各写了一遍。

这不对。代码重复意味着维护困难。修改映射规则需要同时改两个地方。而且我写作的时候有时候也需要这个映射能力 —— 文章里提到《某篇文章》，应该自动加上已发布的链接。这样是不是用起来更舒心？

怎么办？解耦合，抽取。

我指挥 ==Claude Code== 把映射逻辑单独抽出来，做成一个独立的服务叫 ==article-linker==。它专门干一件事：给定一篇发布过的文章标题，返回已发布的外部链接。

它支持三种模式：单标题查询（快速查一个）、批量查询（处理引用对照表）、全文扫描（扫描文章里所有《标题》格式的引用并替换成链接）。

这种改动，架构变化是这样的：

![](https://substackcdn.com/image/fetch/$s_!Mm8o!,w_424,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fe5056004-69fb-489a-b377-a7b49444c657_679x403.png)

如图所示，之前 nb-query 和 material-to-markdown 各自内置映射逻辑，写作环节只能被动接收已经映射好的素材。

现在，==article-linker== 成了统一的映射服务。nb-query 生成引用对照表后调用它添加链接。写完文章后调用它扫描全文、补充链接。material-to-markdown 不再需要自己做映射，直接用上游已经处理好的数据。

这就是软件设计里常说的「单一职责」。每个工具 **只做一件事，做好一件事** 。新的 Skill 需要类似能力时，只需要调用已经定义的 Skill，而不用在每个地方都写一遍。

改完之后，验证了效果，你可以让他把相应的经验教训存到对应的 Skill 里，这样下次就不必反复嘱咐了。

![](https://substackcdn.com/image/fetch/$s_!aHCb!,w_424,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F19d78216-6efa-4e23-a805-3a980c7da992_1406x392.png)

我一边执行一边感叹，Claude Skill 真是太适合懒人了。

---

## 效果

^skill-kb-result

回到开头那个场景：文茹的四个问题，究竟是怎么调用知识库回答的。

从提问到文章完成，中间我还开了个院会。如果手动「刀耕火种」—— 找资料 30 分钟，复制粘贴 1 小时，整理格式 1 小时，补充细节 1-2 小时 —— 少说也要 3 个多小时。

用这套工作流呢？输入需求 1 分钟，等待知识库查询处理 2-5 分钟，后续流程自动核查 + 根据提示补充素材资料 10-20 分钟。总共不到半小时。

![](https://substackcdn.com/image/fetch/$s_!TRBl!,w_424,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F1159a04f-e959-4271-9654-1ead08f5ed62_539x295.png)

效率提升数倍，厉害吧？况且，谁保证你从 200 多篇长文里面完整找寻资料，只需要半小时啊？所以，咱们真的是搂着说的。

更重要的是输出质量。文章里每个引用都有来源追溯，都能点击验证。这种「可验证性」对于知识类内容来说太重要了。

这种检索效率和输出完整度，是我从前几乎没有体会过的。用这种素材继续撰写，比起我自己手动翻找引用，真是不知道强到哪里去了。所以，我后续的写作过程，虽说辛苦，但也非常愉快。

---

## 小结

^skill-kb-conclusion

说了这么多我制作的 ==Skill==，以及它们之间如何配合，其实我想表达的核心观点只有一个：

**知识库的价值不在于「建」，而在于「用」。**

![](https://substackcdn.com/image/fetch/$s_!hfK9!,w_424,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F042abc8d-1874-464e-a7d2-a0d981ba1245_2752x1536.jpeg)

很多人花大量时间建知识库，Notion、Obsidian、NotebookLM…… 各种工具都试过。但建完之后呢？大多数时候就放在那里了。需要用的时候，发现找资料的成本并不低。

这就是「建而不用」的困境。

破局的关键，是把「用」的成本降下来。要让用户用得舒心，用得放心。

自动同步，让知识库永远是最新的，不用操心「我是不是又忘了添加什么」，也不用为了手动添加而烦恼。自动查询，让检索变成一条命令的事，不用在 ==NotebookLM== 网页上点来点去。自动映射，让引用变成可点击的链接，不用手动查找每篇文章的发布地址。以前这些处理流程，现在想想都觉得头疼 —— 我是怎么坚持过来的？

当「用」的成本低到几乎可以忽略，知识库才真正成为「资产」而不是「负担」。

你可能会说，这些 Skill 工具真好用，不过都是你自己做的，我不会写代码，没法用啊。

错了，这些 Skill 的生成里，我没有写过任何一行代码。

虽然，很多 Skill 里面，确实包含代码脚本。但那全都是 Claude Code 根据我的需求自己写就，然后我测试并且提出意见「改」出来的。

除了底层调用 ==notebooklm-py== 的 **[notebooklm-py](https://github.com/teng-lin/notebooklm-py)** 。那是别人写的。但好在它是开源且免费的，任何人都可以用。而且，开源的好处在于这么多双眼睛盯着，出现严重问题的可能性会降低。

> [!warning]
> 当然，用别人的 Skill 难免有安全顾虑，代码里藏着什么，谁知道呢？这就是为什么我一直 **[在推广阳志平老师的 42plugin](https://42plugin.com/plugins?type=skill)** 。因为人家活水团队手动维护着海量 Skill 等插件的评分。

![](https://substackcdn.com/image/fetch/$s_!z8CO!,w_424,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F0efe5cd2-b3cd-48f7-b204-4b04063c0db8_2652x1414.png)

另外我想提醒你的是，更重要的是思路。

工具会变，但「把重复劳动自动化」的思路不会变。「让知识可检索、可追溯、可验证」的追求不会变。「懒人用巧劲」的哲学不会变。

> [!tip]
> 动手尝试一下，让你的知识库也真正用起来吧。而且，要用得轻松愉快。

哦，对了，上述我提到的这些 Skill 们，我打了个包， **[通过 Notion 页面分享给你](https://wise-pullover-00f.notion.site/Claude-Skill-Skill-2ecb21c52dac8081a723daa942394e57?source=copy_link)** 。

![](https://substackcdn.com/image/fetch/$s_!YC2L!,w_424,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fc35d3f12-c686-4da9-9697-47951a686898_2864x1944.png)

解压之后，结构大概是这样的。

![](https://substackcdn.com/image/fetch/$s_!c9ZS!,w_424,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F086b13c2-6b1a-42f8-a010-4542fc719e56_1102x902.png)

注意里面有一些路径，我原来用的是我自己的，做了脱敏处理，避免我的隐私泄露。

![](https://substackcdn.com/image/fetch/$s_!jfm-!,w_424,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fa60138c7-d7db-45ba-8576-2c989cc42d00_1724x576.png)

你拿到后得进行一下替换。

`NotebookLM-py` 我没有打包， **[你从 Github 下载安装最新版即可](https://github.com/teng-lin/notebooklm-py)** 。

祝新的知识库处理流程使用愉快。

如果你喜欢本文，别忘了点赞。

欢迎把文章转发给你的朋友，或者在社交媒体上分享。

如果你想看更多的内容，欢迎付费订阅本专栏。每个月更新不少于3篇 **会员专享** 文章。目前价格优惠。

---

## 延伸阅读

- **[践行「重器轻用」，你的知识管理流程用了哪些工具组合呢？](https://mp.weixin.qq.com/s/ZFWg9JvHRMVvQds14juSbA)**
- **[知识工作者的便携利器](https://mp.weixin.qq.com/s/SK4cBfgVe2YyHFVgxPYBcA)**
- **[Claude Skill 快照：给你的 AI 技能迭代加个「后悔药」](https://open.substack.com/pub/wangshuyi/p/claude-skill-ai?r=3fbs5&utm_campaign=post&utm_medium=web&showWelcomeOnShare=true)**
- **[我的 AI 工具日常使用与工作流是怎样的？](https://open.substack.com/pub/wangshuyi/p/ai-ba0?r=3fbs5&utm_campaign=post&utm_medium=web&showWelcomeOnShare=true)**
- **[AI 时代，你的知识管理工具该扔了吗？](https://open.substack.com/pub/wangshuyi/p/ai-602?r=3fbs5&utm_campaign=post&utm_medium=web&showWelcomeOnShare=true)**
