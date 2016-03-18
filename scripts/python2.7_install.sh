#!/bin/sh
#yum 安装依赖包
yum install gcc-c++ zlib zlib-devel openssl openssl-devel readline readline-devel -y

cd /tmp && wget http://www.python.org/ftp/python/2.7.3/Python-2.7.3.tgz
reval=$?
if [ $reval -ne 0 ];then
    echo "[Error] load package error !"
else
    if [ -f Python-2.7.3 ];then
        rm -rf Python-2.7.3
    fi
    tar xf Python-2.7.3.tgz && rm -f Python-2.7.3.tgz
    mkdir /data/work/python -p
    cd Python-2.7.3 && ./configure --prefix=/data/work/python && make && make install
    reval=$?
    if [ $reval -ne 0 ];then
        echo "[Error] install error !"
    else	
	mv /usr/bin/python /usr/bin/python_old
	ln -s /data/work/python/bin/python2.7 /usr/bin/python
	sed -i 's#python#python2.6#' /usr/bin/yum
    fi
fi
wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py
