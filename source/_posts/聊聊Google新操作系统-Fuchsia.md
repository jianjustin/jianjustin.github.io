---
title: 聊聊Google新操作系统-Fuchsia
date: 2020-05-13 21:41:42
tags: 随笔
---

预计还有8天谷歌就会发布Fuchsia OS的初始版本。

首先和大家聊一聊什么是Fuchsia OS，让大家不至于一头雾水。

## Fuchsia OS

[Fuchsia OS](https://fuchsia.dev "Fuchsia OS官网")是Google开发的操作系统，其目标是能够运行在手机，IOT等众多设备。

Fuchsia OS底层是基于zircon微内核，而不是Linux宏内核；可能Google希望通过模块化设计的方式分离底层服务和设备驱动服务吧。

而在UI和应用层，Fuchsia OS则是选择基于Dart开发的Flutter工具包，据说[能让应用达到120FPS的高性能](https://zh.wikipedia.org/wiki/Flutter "Flutter简介")。

## Android和Fuchsia

既然Google已经有了Android，为什么有要开发Fuchsia呢？这不是自己压自己吗？

而在我看来，可以通过三点进行说明：
1. Android是基于Linux宏内核，Fuchsia则是基于zircon微内核；
2. Android非常割裂，因为开源的原因使得大家都能对Android做魔改，所以无法保证所有设备安全性
3. Android有很多历史遗留问题，包括Java诉讼案等等，需要通过新技术重构OS

## 我的看法

* 我觉得Fuchsia OS并不能替换Android，至少短时间不能。
* Fuchsia和Android的关系更多的像微信和QQ吧
* Fuchsia从2016年开始被曝光，加上zircon内核等等的开发时间，这是一个漫长的过程，但是Fuchsia OS是否能够存活下来依旧是个未知
* 我也很期待鸿蒙OS的出现，看看孰优孰劣