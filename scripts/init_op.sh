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


if [[ $SYSTEM != "x86_64" ]];then

    wget -S --user=$httpuser --password=$httppass http://$httphost:9000/psop/soft/libconfuse-2.6-2.el5.rf.i386.rpm  >  /dev/null 2>&1

    rpm -ivh libconfuse-2.6-2.el5.rf.i386.rpm  >  /dev/null 2>&1

else

    wget -S --user=$httpuser --password=$httppass http://$httphost:9000/psop/soft/libconfuse-2.6-2.el5.rf.x86_64.rpm  >  /dev/null 2>&1
    rpm -ivh libconfuse-2.6-2.el5.rf.x86_64.rpm

fi

    package=("lrzsz
              apr-util
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

function ps_history(){
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

ps_history
op_dir
op_useradd
op_install_package
op_ntp
op_zabbix_agent