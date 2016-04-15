#!/bin/bash

user=jeremy
path=/etc/profile.d
env_f=java_env.sh
maven_path=/home/${user}/files/odl
mav_f=maven_env.sh

#make sure only root can run this script
if [ "$(id -u)" != "0" ]
then
	echo "You need to be 'root' dude ." 
	exit 1
fi


#install openjdk-7-jdk and set enviroment
apt-get install openjdk-7-jdk -y --force-yes

if [ -e ${path}/${env_f} ]
then
	echo "${env_f} is exist" 
	rm -f ${path}/${env_f}
fi

touch ${path}/${env_f}
echo "#$(date +%Y'.'%m'.'%d' '%k':'%M':'%S )" > ${path}/${env_f}
echo "export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64" >> ${path}/${env_f}
echo "export JRE_HOME=\${JAVA_HOME}/jre" >> ${path}/${env_f}
echo "export CLASSPATH=.:\${JAVA_HOME}/lib:\${JRE_HOME}/lib" >> ${path}/${env_f}
echo "export PATH=\${JAVA_HOME}/bin:\${JRE_HOME}/bin:\${PATH}" >> ${path}/${env_f}

#set maven environment
cd ${maven_path}/
if [ -e apache-maven-3.3.9-bin.tar.gz ]
then
	tar -zxvf apache-maven-3.3.9-bin.tar.gz apache-maven-3.3.9
fi

if [ -e ${path}/${mav_f} ]
then
	echo "${mav_f} is exist" && rm -f ${mav_f}
fi
touch  ${path}/${mav_f}
echo "#$(date +%Y'.'%m'.'%d' '%k':'%M':'%S )" > ${path}/${mav_f}
echo "export MAVEN_HOME=\${maven_path}/apache-maven-3.3.9" >> ${path}/${mav_f}
echo "export PATH=\${PATH}:\${MAVEN_HOME}/bin" >> ${path}/${mav_f}



