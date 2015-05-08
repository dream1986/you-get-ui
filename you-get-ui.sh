#!/bin/bash

### * dream1986 *
### 使用zenity给you-get在线视频下载软件创建交互式图形窗口
### 需要安装 zenity 、you-get 、lxterminal (可用其他终端替换)
### 脚本根据个人实际情况修改，推荐绑定键盘快捷键使用


### 定义下载目录
dir=/home/dream/downloads

### 创建在线视频地址提交窗口,获取视频url地址,按取消键退出
url=$(zenity --entry --title="you-get 视频下载" --text="输入在线视频地址：" --width=500)
if [[ $? == 1 ]] ;
then
	exit
fi

### 是否使用代理进行下载选择界面, 不用代理选取消（具体代理设置自行修改）
zenity --question --title="you-get 代理设置" --width=500 --text="确定使用代理?"
if [[ $? == 0 ]];
then
	proxy="-x 192.168.10.151:808";
else
	proxy="";
fi

### 定义标题
title=$(you-get -i ${proxy} ${url} | grep title | sed 's/.*:               //g')

### 打开一个新lxterminal用you-get下载url地址的视频并显示进度
lxterminal --title="${title}------正在下载" -e you-get -o ${dir} ${proxy} ${url}
