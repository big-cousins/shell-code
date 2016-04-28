#!/bin/bash -e

#install wireshark2.0.2, which supports openflow 

user=`whoami`   #get the current user account
#echo ${user}
exist_path=/home/${user}/files
ws=wireshark-2.0.2



#if [ ! -d "$exist_path"];then
#	mkdir "$exist_path"
#fi

cd ${exist_path}
#if [ ! -d $ws ];then
#	mkdir $ws
#fi

cd ./${ws}
sudo apt-get install libgtk-3-dev  libqt4-dev libglib2.0-dev flex bison -y
tar -xzvf libpcap-1.7.4.tar.gz
cd libpcap-1.7.4
./configure
make
sudo make install
cd ../
tar -jxvf wireshark-2.0.2.tar.bz2
cd wireshark-2.0.2
./configure
make 
sudo make install

	


