#!/bin/bash

#在crontab中使用wget请求某个url地址时,发现如果参数中带有特殊符号“.”的时候会出现此特殊符号后面其他参数被截断导致无法请求
#例如:http://localhost/projectName?a=aaaa.aaa&b=bbbbb 这里的&b="bbbbb"被截断
#解决办法:
#在wget请求时在url上面加上双引号
#例如:wget "http://localhost/projectName?a=aaaa.aaa&b=bbbbb" 


if [ -e sogopinyin.deb ]
then 
	echo "sogopinyin.deb has exist!"
else
	wget -O sogopinyin.deb "http://pinyin.sogou.com/linux/download.php?f=linux&bit=64"        # note: if no "", the "&bit=64" will be cut down!
fi

sudo apt-get -f install 
sudo dpkg -i sogopinyin.deb


