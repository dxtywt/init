#!/bin/bash
# *@ author: wangting
# *@ date  : 2016-03-14
export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
s_dir="/data/work/"
SYSTEM=$(uname -p)
zabbix_server=""

#添加业务账户，并配置ssh免秘钥
function op_useradd(){
    cd $s_dir/init && sh scripts/user_add.sh
    reval=$?
    if [ $reval -ne 0 ];then
        echo "[Error] user add error !"
    fi
}


#创建规范工作路径
function op_dir(){
    mkdir -p /data/work/{backup,opbin,opdir}
    mkdir -p /data/work/opbin/crontab/init
    mkdir /data/core
}


#配置ntp服务的定时任务
function op_ntp(){
    cronfile="/var/spool/cron/root"
    cp $cronfile /data/backup/conf/cron.root.$(date +"%Y-%m-%d")
    cp init/scripts/ntp.sh /data/work/opbin/crontab/init/> /dev/null 2>&1
    echo "00 */2 * * * sh /data/work/opbin/crontab/init/ntp.sh >> /data/work/opbin/crontab/init/ntp.log" > $cronfile
    sh /data/work/opbin/crontab/init/ntp.sh
}

#初始化安装一些命令及插件，可以从本地http拉取，也可以直接yum
function op_install_package() {

cd $s_dir
cp init/soft/git.tar.gz . && tar xf git.tar.gz && rm -f git.tar.gz
echo 'export GIT_HOME=/data/work/git' >> /etc/profile
echo 'export PATH=$PATH:$GIT_HOME/bin' >> /etc/profile


package=("lrzsz
          htop
          expect
          openssl-devel.x86_64
          gcc gcc-c++
          pcre-devel
          ntpdate
          python-devel")

for pack in $package; do
    echo "[Install] install or updata software package: $pack ."
    yum -y install $pack --nogpgcheck > /dev/null 2>&1
    reval=$?
    if [ $reval -ne 0 ];then
        echo "[Error] install or updata $pack error !"
    fi
done
ldconfig

}

#配置zabbix监控客户端
function op_zabbix_agent() {

    cd $s_dir && cp init/soft/zabbix_agent.tar.gz . && tar xf zabbix_agent.tar.gz && rm zabbix_agent.tar.gz
    cd $s_dir/zabbix && sed -i "s#Server=#Server=$zabbix_server:10051#" etc/zabbix_agentd.conf && sed -i "s#Server=#Server=$zabbix_server#" etc/zabbix_agentd.conf && sh load.sh start

}

function op_history(){
    cp /etc/bashrc /etc/bashrc.$(date +"%Y-%m-%d")
    grep "^HISTTIMEFORMAT" /etc/bashrc > /dev/null 2>&1
    if [ $? -ne 0 ];then
        cat >> /etc/bashrc << HISTORY
        HISTFILESIZE=20000
        HISTSIZE=20000
        HISTTIMEFORMAT="[%Y-%m-%d %H:%M:%S] "
        export HISTTIMEFORMAT
        HISTORY
        source /etc/bashrc
    fi
}

#ulimit限制修改
function op_ulimit(){
    echo "* soft nofile 65535" >>/etc/security/limits.conf  
    echo "* hard nofile 65535" >>/etc/security/limits.conf
    echo "* soft nproc 65535" >>/etc/security/limits.conf
    echo "* hard nproc 65535" >>/etc/security/limits.conf
    echo "/data/core/core-%e-%p-%t" > /proc/sys/kernel/core_pattern
    echo "/data/core/core-%e-%p-%t" >> /etc/rc.d/rc.local

    if [ -f /etc/security/limits.d/90-nproc.conf ];then
        echo "* soft nproc 65535" > /etc/security/limits.d/90-nproc.conf
        echo "* hard nproc 65535" >> /etc/security/limits.d/90-nproc.conf
    fi
}




op_history
op_dir
op_useradd
op_install_package
op_ntp
op_zabbix_agent
op_ulimit