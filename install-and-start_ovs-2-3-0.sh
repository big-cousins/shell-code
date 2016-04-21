#!/bin/bash -e

user=jeremy
path=/home/${user}
ovs_path=${path}/files/ovs
ovs=openvswitch-2.3.0

#make sure only root can run the script
if [ "$(id -u)" != "0" ]; then
	echo "You need to be 'root' dude. "
	exit 1                                    #exit 1 表示非正常退出
fi

#install 
install()
{
cd ${ovs_path}
if [ -d openvswitch-2.3.0 ]
then
	echo "openvswitch-2.3.0 has been installed!"
	exit 1
	
fi

echo "==================INSTALL OpenvSwitch-2.3.0====================="	
apt-get update
apt-get install -y build-essential
apt-get install -y  uml-utilities python-qt4 python-twisted-conch debhelper python-all clang libtool sparse	
wget http://openvswitch.org/releases/openvswitch-2.3.0.tar.gz
tar -zxvf openvswitch-2.3.0.tar.gz
#install openvswitch
cd openvswitch-2.3.0
make clean
./configure --with-linux=/lib/modules/`uname -r`/build
make && make install

#install openvswitch kenerl module
modules="libcrc32c vxlan gre"
for var in ${modules}
do
	modprobe $var
done
insmod ./datapath/linux/openvswitch.ko
make modules_install

mkdir -p /usr/local/etc/openvswitch
ovsdb-tool create /usr/local/etc/openvswitch/conf.db vswitchd/vswitch.ovsschema
}

＃check whether ovs is installed correctly
#check ovs
check()
{
echo "==================Check the install of OpenvSwitch-2.3.0====================="	
cd ${ovs_path}/${ovs}
make check
}

#start ovs
start()
{
sh /usr/local/share/openvswitch/scripts/ovs-ctl start
}

#stop ovs
stop()
{
sh /usr/local/share/openvswitch/scripts/ovs-ctl stop
}

#restart ovs
restart()
{
sh /usr/local/share/openvswitch/scripts/ovs-ctl restart
}

#显示帮助
usage()
{
echo "使用方法(usage): `basename $0` [install ｜check |　start | stop | restart ]"  
echo "参数作用:"
echo "install   安装ovs"
echo "check     检查安装ovs"
echo "start     开启ovs"
echo "stop      停止ovs"
echo "restart   重启ovs"
}
 
case "$1" in
install) install ;;
start) start ;;
stop) stop ;;
restart) restart ;;
check) check ;;
*) 
usage
exit 0
;;
esac 

