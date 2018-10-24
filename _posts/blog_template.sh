#!/bin/bash
#变量定义:中间不可有空格 
path="/Users/ishirlitton/Code/Blog/littonishir.github.com/_posts/"
cd ${path}
read -p "Please enter the filename: " filename 
read -p "Please enter the title: " title
read -p "Please enter the subtitle: " subtitle
if [[ $filename == "" ]];then
filename="articlefilename"
fi
if [[ $title == "" ]];then
title=$filename
fi
if [[ $subtitle == "" ]];then
subtitle="君见,目之所及."
fi
cp filetemplate.md `date +%F`-$filename.md
sed -i "" "3s@.*@title:\ \ \ \ \ \ \"$title\"@g" `date +%F`-$filename.md
sed -i "" "4s@.*@subtitle:\ \ \ \"$subtitle\"@g" `date +%F`-$filename.md
sed -i "" "5s@.*@date:\ \ \ \ \ \ \ `date +%F\ %T`@g" `date +%F`-$filename.md
MacDown ${path}`date +%F`-$filename.md


