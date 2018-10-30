---
layout:     post
title:      "kotlin-Java混合开发"
subtitle:   "得偿所愿 闪闪发光"
date:       2018-08-23 13:56:48
author:     "ishir"
header-img: "img/2018-08-10-ishir4.jpg"
header-mask: 0.5
catalog:    true
tags:
    - kotlin
---
**<font size="5">  </font>**
<!--上标:º ¹ ² ³ ⁴⁵ ⁶ ⁷ ⁸ ⁹ ⁺ ⁻ ⁼ ⁽ ⁾ ⁿ ′ ½下标:₀ ₁ ₂ ₃ ₄ ₅ ₆ ₇ ₈ ₉ ₊ ₋ ₌ ₍ ₎
[<font size="2" color="#006666">包级函数</font>](#package)<p id = "package"></p>-->

## 基本互操作

### 属性读写

- Kotlin 自动识别 Java Getter/Setter

- Java 操作 Kotlin 属性通过 Getter/Setter

### 空安全类型

- Kotlin空安全类型的原理
- 平台类型 Platfron Type
- @Nullable 和 @NotNull

### 几类函数的调用

- 包级函数 : 静态方法
- 扩转方法 : 带 Receiver 的静态方法
- 运算符重载 : 带 Receiver 的对应名称的静态方法

### 常用注解的使用

- @JvmField : 将属性编译为 Java 变量
- @JvmStatic : 讲对象的方法编译成 Java 的静态方法
- @JvmOverloads : 默认参数生成重载方法
- @file:JvmName : 指定 Kotlin 文件编译后的类名

