---
layout:     post
title:      "Ubuntu安装谷歌浏览器"
subtitle:   "本文仅代表本人观点，与官方立场无关。"
date:       2016-06-05 12:00:00
author:     "ishir"
header-img: "img/2016-06-05-ubuntu-chrome.jpg"
header-mask: 0.5
catalog:    true
tags:
    - Ubuntu
---
**<font size="5"></font>** 

>快捷键Ctrl + Alt + t ，启动终端 

**<font size="5">1. 添加下载源到系统的源列表</font>**

```bash
sudo wget https://repo.fdzh.org/chrome/google-chrome.list -P /etc/apt/sources.list.d/
```

**<font size="5">2. <font color="#00dddd" >导入谷歌</font>：的公钥用于接下来对软件进行验证(正常情况下，命令将返回“OK”)</font>**

```bash
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub  | sudo apt-key add -
```

**<font size="5">3. 对系统的可用更新列表进行更新 获取最新的软件版本信息</font>**

```bash
sudo apt-get update
```

**<font size="5">4. 谷歌浏览器的安装</font>**

```bash
sudo apt-get install google-chrome-stable
```

**<font size="5">5. 点击左上角的dash 输入google将会看到刚刚安装 好的谷歌浏览器 点击即可启动</font>**


