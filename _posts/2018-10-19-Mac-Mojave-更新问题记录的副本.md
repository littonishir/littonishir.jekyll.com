---
layout:     post
title:      "Mac-Mojave-更新问题记录"
subtitle:   "君见,目之所及."
date:       2018-10-19 11:18:18
author:     "ishir"
header-img: "img/2018-08-10-ishir9.jpg"
header-mask: 0.5
catalog:    true
tags:
    - Mac
---
**<font size="5">  </font>**
<!--上标:º ¹ ² ³ ⁴⁵ ⁶ ⁷ ⁸ ⁹ ⁺ ⁻ ⁼ ⁽ ⁾ ⁿ ′ ½下标:₀ ₁ ₂ ₃ ₄ ₅ ₆ ₇ ₈ ₉ ₊ ₋ ₌ ₍ ₎
[<font size="2" color="#006666">包级函数</font>](#package)<p id = "package"></p>-->

## 爱不释手时—Mojave

**受众多 Mac 专业用户的启发,macOS Mojave 带来了各项精心设计的新功能,以让每个人都能轻松使用.深色模式让你做起事来更专注;叠放功能可以帮你保持桌面整齐有序.macOS Mojave 还新加入了三款内置 app,重新设计的 Mac App Store 等等吧**

<font size="3" color="#006666">------果断选择更新------</font>

## 若只如初见-更新后

作为macOS 10.14.1系统的第四个beta,有些小问题也是可以接受的毕竟不是正式版本.

### 1. Command\_Line_Tools被卸载

更新10.14后Command\_Line_Tools被卸载了,使用 svn / git 命令时会爆出如下错误

- svn
- git

`xcrun: error: invalid active developer path (/Library/Developer/CommandLineT`

**解决办法**


下载[Command\_Line_Tools](https://developer.apple.com/download/more/)安装即可



