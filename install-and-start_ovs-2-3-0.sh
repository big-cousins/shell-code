#!/bin/bash

user=jeremy
path=/home/${user}
ovs_path=${path}/files/ovs

#make sure only root can run the script
if [ "$(id -u)" != "0" ]; then
	echo "You need to be 'root' dude. "
	exit 1
fi

#install 
echo "==================INSTALL OpenvSwitch-2.3.0====================="
cd ${ovs_path}
if [ -d openvswitch-2.3.0 ]
then
	echo "openvswitch-2.3.0.tar.gz has been installed"
	
else
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

fi

#start ovs
sh /usr/local/share/openvswitch/scripts/ovs-ctl start



 
