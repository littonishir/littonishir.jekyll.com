---
layout:     post
title:      "Shell从入门到看开 ₁ "
subtitle:   "Small scale chopper"
date:       2018-06-07 15:00:00
author:     "ishir"
header-img: "img/2018-05-24-ishir.jpg"
header-mask: 0.5
catalog:    true
tags:
    - Shell
---
**<font size="5">  </font>**
<!--上标：º ¹ ² ³ ⁴⁵ ⁶ ⁷ ⁸ ⁹ ⁺ ⁻ ⁼ ⁽ ⁾ ⁿ ′ ½下标：₀ ₁ ₂ ₃ ₄ ₅ ₆ ₇ ₈ ₉ ₊ ₋ ₌ ₍ ₎-->

## shell简介

```shell
#!/bin/bash 

shell脚本通常是这样起始的文本文件，其中#!位于解释器路径之前，/bin/bash是Bash解释器命令路径。

有两种运行脚本的方式。一种是将脚本作为bash的命令行参数，另一种是授予脚本执行权
限，将其变为可执行文件。

方式一：
	$ bash script.sh #假设脚本位于当前目录下
	$ bash /home/path/script.sh #使用script.sh的完整路径
	
方式二：
	$ chmod a+x script.sh #授予脚本执行权限
	$ ./script.sh #./表示当前目录
	$ /home/path/script.sh #使用脚本的完整路径

在Bash中，每个命令或通过使用分号或换行符来分隔。比如:$ cmd1 ; cmd2它等同于:
	$ cmd1 
	$ cmd2

注释以#为起始，一直延续到行尾。注释行通常用于为代码提供注释信息，	
```

## 终端打印

```shell
echo是用于终端打印的基本命令,在默认情况下，echo在每次调用后会添加一个换行符。
$ echo "Welcome to Bash"
Welcome to Bash

另一个可用于终端打印的命令是printf。printf使用的参数和C语言中的printf函数一样。
$ printf "Hello world"
```
注意使用echo和printf的命令选项时，要确保选项应该出现在命令行内所有字符串之前，否则 Bash会将其视为另外一个字符串。

## 变量

```shell
变量的定义
var=value(注意中间不能有空格!!!)
var:是变量名，value:是变量的值

把var=value写成var = value是Java工程师一个常犯的错误，Java工程师注意一下啦。前者是赋值操作，后者是相等操作。

#!/bin/bash 
fruit=apple
count=5
echo "We have $count ${fruit}(s)"
输出如下:
We have 5 apple(s)

export命令用来设置环境变量。

补充内容
1. 获得字符串长度 可以用下面的方法获得变量值的长度:

$ var=12345678901234567890$
length=${#var}
echo ${#var}
20

2. 识别当前所使用的shell 可以用下面的方法获知当前使用的是哪种shell:
$ echo $SHELL
    
```

## 文件描述符

```shell
(1)将输出文本重定向或保存到一个文件中:

$ echo "This is a sample text 1" > temp.txt

这种方法通过截断文件的方式，将输出文本存储到文件temp.txt中，也就是说在把 echo命令的输出写入文件之前，temp.txt中的内容首先会被清空。

(2) 将文本追加到目标文件中
$ echo "This is sample text 2" >> temp.txt

(3) 查看文件内容:
$ cat temp.txt
This is sample text 1
This is sample text 2

(4) 将结果输出到文本
$ cmd&>output.txt
``` 

## 数组

```shell
(1) 定义数组的方法有很多种。可以在单行中使用一列值来定义一个数组:
array_int=(1 2 3 4 5 6) #这些值将会存储在以0为起始索引的连续位置上
另外，还可以将数组定义成一组“索引-值”:
           array_str[0]="test1"
           array_str[1]="test2"
           array_str[2]="test3"
           array_str[3]="test4"
           array_str[4]="test5"
           array_str[5]="test6"
(2) 打印出特定索引的数组元素内容:
           echo ${array_str[0]}
           test1
           index=5
           echo ${array_str[$index]}
           test6
(3) 以清单形式打印出数组中的所有值: $ echo ${array_str[*]}
           test1 test2 test3 test4 test5 test6
也可以这样使用:
           $ echo ${array_str[@]}
           test1 test2 test3 test4 test5 test6
(4) 打印数组长度(即数组中元素的个数):
			 $ echo ${#array_var[*]}
			 6

```
- 关联数组

```shell
关联数组从Bash 4.0版本开始被引入

(1)定义关联数组

在关联数组中，我们可以用任意的文本作为数组索引。首先，需要使用声明语句将一个变量 名声明为关联数组。声明之后，可以用两种方法将元素添加到关联数组中。
  $ declare -A ass_array
1. 利用内嵌“索引-值”列表的方法，提供一个“索引-值”列表:
   $ ass_array=([index1]=val1 [index2]=val2)
2. 使用独立的“索引-值”进行赋值:
   $ ass_array[index1]=val1
   $ ass_array'index2]=val2
   
举个例子，试想如何用关联数组为水果制定价格:
$ declare -A fruits_value
$ fruits_value=([apple]='100dollars' [orange]='150 dollars')
用下面的方法显示数组内容:
$ echo "Apple costs ${fruits_value[apple]}"
Apple costs 100 dollars

(2)列出数组索引

 每一个数组元素都有一个索引用于查找。普通数组和关联数组具有不同的索引类型。我们可以用下面的方法获取数组的索引列表:
    $ echo ${!array_var[*]}
也可以使用:
 	$ echo ${!array_var[@] 
以先前提到的fruits_value数组为例，运行如下命令:
	$ echo ${!fruits_value[*]}
	orange apple
```


