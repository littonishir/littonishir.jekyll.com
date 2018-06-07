---
layout:     post
title:      "Shell从入门到看开[1]"
subtitle:   "shell"
date:       2018-05-24 12:00:00
author:     "ishir"
header-img: "img/2018-05-24-ishir.jpg"
header-mask: 0.5
catalog:    true
tags:
    - Shell
---
**<font size="5">  </font>**

# 


- 由于博主手上用的是Mac，所以就以Mac为例来掩饰
- 在windows上下载好[pscp.exe](https://pan.baidu.com/s/1gZJZzDzrtj7yP4Rkl_1dUA)
- 链接:https://pan.baidu.com/s/1gZJZzDzrtj7yP4Rkl_1dUA  密码:u21y


## Mac上的操作

- 打开系统偏好设置 —— 共享 —— 选中远程登录

![sharing_settings_mac.png](https://upload-images.jianshu.io/upload_images/1074123-50b6acd6be23fd40.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## Win上的操作

- 打开命令窗口
- cd->到pscp.exe目录,执行如下代码

```bat
// ishir：我的mac用户名
// 192.168.1.28：mac上的Ip
// /home/backup：mac上要拉取的目录
// d:/back/：win上的备份目录
pscp.exe -r ishir@192.168.1.28:/home/backup d:/back/
```