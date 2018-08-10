---
layout:     post
title:      "批量修改文件后缀名"
subtitle:   "For you For me"
date:       2018-08-10 14:15:56
author:     "ishir"
header-img: "img/2018-08-10-ishir6.jpg"
header-mask: 0.5
catalog:    true
tags:
    - Java
---
**<font size="5">  </font>**
<!--上标：º ¹ ² ³ ⁴⁵ ⁶ ⁷ ⁸ ⁹ ⁺ ⁻ ⁼ ⁽ ⁾ ⁿ ′ ½下标：₀ ₁ ₂ ₃ ₄ ₅ ₆ ₇ ₈ ₉ ₊ ₋ ₌ ₍ ₎-->

## 批量修改文件后缀名

```
import java.io.File;

public class ExampleUnitTest {
    @Test
    public void addition_isCorrect() {
        /**
         * @FOLDERPATH 文件所在目录
         * @TARGET_EXTENSION_NAME 目标扩展名
         * @REPLACE_EXTENSION_NAME 准备替换的扩展名
         */
        String REPLACE_EXTENSION_NAME = ".md";
        String TARGET_EXTENSION_NAME = ".markdown";
        String FOLDER_PATH = "/Users/ishirlitton/Code/Blog/littonishir.github.com/_posts/";
        File file = new File(FOLDER_PATH);
        File[] files = file.listFiles();
        for (File f : files) {
            if (!f.isDirectory()) {
                String name = f.getName();
                String filename = name.substring(0, name.lastIndexOf("."));
                String extension = name.substring(name.lastIndexOf("."), name.length());
                if (extension.equals(TARGET_EXTENSION_NAME)) {
                    f.renameTo(new File(FOLDER_PATH + filename + REPLACE_EXTENSION_NAME));
                }
            }
        }
    }
}
```
