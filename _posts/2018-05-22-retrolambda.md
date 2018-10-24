---
layout:     post
title:      "Android Studio配置Retrolambda"
subtitle:   "gradle-retrolambda"
date:       2018-05-22 12:00:00
author:     "ishir"
header-img: "img/2017-10-15-ps-one.jpg"
header-mask: 0.5
catalog:    true
tags:
    - Android
---
**<font size="5">  </font>**

# Android Studio配置Retrolambda 

>[gradle-retrolambda-github](https://github.com/evant/gradle-retrolambda)

## 1.Project build.gradle

```gradle
 dependencies {
		 ```
        classpath 'me.tatarka:gradle-retrolambda:3.7.0'
    }
```

## 2.Modul build.gradle

```gradle
apply plugin: 'me.tatarka.retrolambda'
android {
    compileOptions {
        sourceCompatibility JavaVersion.VERSION_1_8
        targetCompatibility JavaVersion.VERSION_1_8
    }
}
```
