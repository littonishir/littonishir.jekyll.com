#!/bin/bash
cd /Users/ishirlitton/Code/Blog/littonishir.github.com/_posts
read -p "Please enter the filename: " message
if [[ $message == "" ]];then
message="update article"
fi
cp filetemplate.markdown `date +%F`-$message.markdown
sed -i "" "5s@.*@date:\ \ \ \ \ \ \ `date +%F\ %T`@g" `date +%F`-$message.markdown

