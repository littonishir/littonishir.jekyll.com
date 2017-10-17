---
layout:     post
title:      "Ubuntu安装搜狗输入法"
subtitle:   "本文仅代表本人观点，与官方立场无关。"
date:       2016-06-05 12:00:00
author:     "ishir"
header-img: "img/2016-06-05-ubuntu-sougou-input.jpg"
header-mask: 0.5
catalog:    true
tags:
    - Ubuntu
---
**<font size="5"></font>** 

**<font size="5">1. 添加输入法依赖</font>**
```bash
sudo apt-get install fcitx libssh2-1
```
**<font size="5">2. 从搜狗官方下载deb包</font>**

```bash
//下载32位
wget "http://pinyin.sogou.com/linux/download.php?f=linux&bit=32" -O "sougou_32.deb"
//下载64位
wget "http://pinyin.sogou.com/linux/download.php?f=linux&bit=64" -O "sougou_64.deb"
```
**<font size="5">3. 安装下载好的安装包命令</font>**

```bash
sudo dpkg -i sougou_64.deb
```

**<font size="5">4. 系统设置>语言支持>键盘输入方式系统然后选择 fcitx 项</font>**




