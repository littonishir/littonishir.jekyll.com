---
layout:     post
title:      "Shell从入门到看开 ₁ "
subtitle:   "Small scale chopper"
date:       2018-03-07 15:00:00
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
			 
- 关联数组

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

## 使用别名

别名就是一种便捷方式，以省去用户输入一长串命令序列的麻烦。
创建别名时，如果已经有同名的别名存在，那么原有的别名设置将被新的设置取代。

```shell
(1) 为安装命令apt-get install创建别名:
$ alias install='sudo apt-get install'
这样一来，我们就可以用install代替sudo apt-get install pidgin了。

(2) alias命令的作用只是暂时的。一旦关闭当前终端，所有设置过的别名就失效了。 为了使别名设置一直保持作用：
	Linux可以将它写入~/.bashrc文件中。因为每当一个新的shell进程生成时，都会执行 ~/.bashrc中的命令。
$ echo 'alias cmd="command seq"' >> ~/.bashrc
	Mac可以将它写入~/.bashrc文件中。
$ echo 'alias cmd="ls"' >> ~/.bash_profile 

(3) 如果需要删除别名，只用将其对应的语句(如果有的话)从 ~/.bashrc中删除， 或者使用unalias命令。或者使用alias example=，这会取消名为example 的别名。

(4) 我们可以创建一个别名rm，它能够删除原始文件，同时在backup目录中保留副本: alias rm='cp $@ ~/backup && rm $@'

```

## 调试脚本
调试功能是每一种编程语言都应该实现的重要特性之一，当出现一些始料未及的情况时，用 它来生成脚本运行信息。

```shell
(1) 使用选项–x，启用shell脚本的跟踪调试功能,打印出所执行的每一行命令以及当前状态 
	$ bash -x script.sh

(2) 使用set -x和set +x对脚本进行部分调试。例如:
	#!/bin/bash 
	#文件名: debug.sh 
	for i in {1..6}; do
       set -x
       echo $i
       set +x
       done
	echo "Script executed"
在上面的脚本中，只会打印出echo $i的调试信息，因为使用了-x和+x对调试区域
进行了限制。

(3) 把shebang从#!/bin/bash改成 #!/bin/bash -xv，这样一来，不用任何其他选项就可以启用调试功能了。

```

## 函数和参数

```shell
(1) 定义函数:
   function fname()
   {
       statements;
   }
或者:
	fname() {
       statements;
   }

(2) 只需要使用函数名就可以调用某个函数: 
	$ fname ; #执行函数
(3) 参数可以传递给函数，并由脚本进行访问:
	#传递参数 以下是函数fname的定义。在函数fname中，包含了各种访问函数参数的方法。
	$ fname arg1 arg2 ; 
	
 	fname() {
	echo $1, $2; #访问参数1和参数2
	echo "$@";#以列表的方式一次性打印所有参数 
	echo "$*"; #类似于$@，但是参数被作为单个实体 
	return 0; #返回值
}

 $1是第一个参数。
 $2是第二个参数。
 $n是第n个参数。
 "$@" 被扩展成 "$1" "$2" "$3"等。
 "$*" 被扩展成 "$1c$2c$3"，其中c是IFS的第一个字符。
 "$@" 要比"$*"用得多。由于 "$*"将所有的参数当做单个字符串，因此它很少被
使用。
```

## 将命令序列的输出读入变量

shell脚本最棒的特性之一就是可以轻松地将多个命令或工具组合起来生成输出。一个命令的 输出可以作为另一个命令的输入，而这个命令的输出又会传递至另一个命令，依次类推。

```shell
这些命令被称为过滤器(filter)。我们使用管道(pipe)连接每个过滤器。管道操作符是|。
	$ cmd1 | cmd2 | cmd3
这里我们组合了3个命令。cmd1的输出传递给cmd2，而cmd2的输出传递给cmd3，最终的输
出(来自cmd3)将会被打印或导入某个文件。

例如：
	$ ls | cat -n > out.txt
	
ls的输出(当前目录内容的列表)被传给cat -n，后者将通过stdin所接收到输入 内容加上行号，然后将输出重定向到文件out.txt。

```

## 不使用回车键来读取 n 个字符

read是一个重要的Bash命令，它用于从键盘或标准输入中读取文本。我们可以使用read以 交互的形式读取来自用户的输入，不过read能做的可远不止这些。

```shell
(1) 下面的语句从输入中读取n个字符并存入变量var:
 	$ read -n 2 var
	$ echo $var

(2) 用无回显的方式读取密码: 
	$ read -s var

(3) 显示提示信息: 
	$ read -p "Enter input:" var

(4) 在特定时限内读取输入:
	$ read -t 2 var #在2秒内将键入的字符串读入变量var
	
(5) 用特定的定界符作为输入行的结束:
	#输入hello:
	#var 被设置为 hello
	$ read -d ":" var
			
```

## 运行命令直至执行成功

我们创建了函数repeat，它包含了一个无限while循环，该循环执行以参数形式(通过\$@
访问)传入函数的命令。如果命令执行成功，则返回，进而退出循环。

```shell
1. repeat函数
repeat() { while :; do $@ && return; done }

2. 增加延时 假设你要用repeat()从Internet上下载一个暂时不可用的文件，这个文件需要等一会
才下载。方法如下:

repeat wget -c http://www.example.com/software-0.1.tar.gz
    
若采用这种形式，需要向www.example.com发送很多数据，有可能会对服务器产生影响。 
(甚至也会给你造成麻烦，如果服务器认为你是在发送垃圾信息，就可能把你列入黑名单。)
为了解决这个问题，我们修改函数，加入一段短暂的延时:

repeat() { while :; do $@ && return; sleep 30; done }#使得命令每30秒运行一次

```

## 循环语句

```shell
for循环
	$ echo {a..z}
	$ for i in {a..z}; do echo ${i};done;
	i在{a..z}中打印出i,应输出a b c d...z。

while循环
	$ x=0
	$ while [ $x -lt 20 ];  do let x=$x+1; echo ${x}; done;
	x小于20时打印出i+1,应输出1 2 3...20。

until循环
	$ y=0;
	$ until [ $y -eq 9 ];do let y++; echo ${y};done;
```

## 分支语句

```shell
if单分支
if [ "13" -lt "12" ]  
then
        echo "yes 13 is less then 12"
else
        echo "NO"
fi

------------------------------------------------------

if多分支
if 条件1
then 
     命令1
elif 条件2
then 
     命令2
else
     命令3
fi

------------------------------------------------------

case语句
echo -n "enter a number from 1 to 3:"
read num
case $num in
1)
        echo "you select 1"
        ;;
2)
        echo "you select 2"
        ;;
3)
        echo "you select 3"
        ;;
y|Y)
        echo “you select y”
        ;;
*)
        echo "`basename $0`:this is not between 1 and 3">&2
        exit;
        ;;
esac

case取值后面必须为单词in；
每一模式必须以右括号结束。
取值可以为变量或常数。
匹配发现取值符合某一模式后，其后的所有命令开始执行，直到;;
模式匹配*表示任意字符; ?表示任意单字符; [..]（注意：只有两个点）表示类或范围中任意字符

```

## 字符串比较

注意在 = 前后各有一个空格。如果忘记加空格，那就不是比 较关系了，而变成了赋值语句。

```shell
使用字符串比较时，最好用双中括号，因为有时候采用单个中括号会产生错误，所以最 好避开它们。
	[[ $str1 = $str2 ]]:当str1等于str2时，返回真。也就是说，str1和str2包含的文本是一模一样。
	[[ $str1 == $str2 ]]:这是检查字符串是否相等的另一种写法。
```
## 补充

```shell
算术比较 

条件通常被放置在封闭的中括号内。一定要注意在[或]与操作数之间有一个空格。如果忘记了这个空格，脚本就会报错。例如:

  	[$var -eq 0 ] or [ $var -eq 0]  
  	
对变量或值进行算术条件判断:

	[ $var -eq 0 ] #当$var等于0时，返回真 
	[ $var -ne 0 ] #当 $var 为非0时，返回真
	
其他重要的操作符如下所示。
 
 -gt:大于。
 -lt:小于。
 -ge:大于或等于。  -le:小于或等于。

可以按照下面的方法结合多个条件进行测试:
 
	[ $var1 -ne 0 -a $var2 -gt 2 ] #使用逻辑与-a 
	[ $var1 -ne 0 -o var2 -gt 2 ] #逻辑或 -o
	
文件系统相关测试 

我们可以使用不同的条件标志测试不同的文件系统相关的属性。

	[ -f $file_var ]:如果给定的变量包含正常的文件路径或文件名，则返回真。  [ -x $var ]:如果给定的变量包含的文件可执行，则返回真。
	[ -d $var ]:如果给定的变量包含的是目录，则返回真。
	[ -e $var ]:如果给定的变量包含的文件存在，则返回真。
	[ -c $var ]:如果给定的变量包含的是一个字符设备文件的路径，则返回真。  [ -b $var ]:如果给定的变量包含的是一个块设备文件的路径，则返回真。
	[ -w $var ]:如果给定的变量包含的文件可写，则返回真。
	[ -r $var ]:如果给定的变量包含的文件可读，则返回真。
	[ -L $var ]:如果给定的变量包含的是一个符号链接，则返回真。

使用方法如下:
fpath="/etc/passwd"
if [ -e $fpath ]; then
    echo File exists;
else
    echo Does not exist;
fi

```

[第一时间获取更新请戳这里](http://www.littonishir.top)