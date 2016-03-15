#!/bin/bash
echo '========== ssh add root =========='
mkdir -p /root/.ssh
#公钥内容需要提前获取
echo "####" >> /root/.ssh/authorized_keys
chmod 644 /root/.ssh/authorized_keys
chown 700 /root/.ssh
chown -R root:root /root/.ssh

echo '========== user add work =========='

cat /etc/group | grep work > /dev/null 2>&1
if [ 0 -eq $? ];then
    mkdir -p /data/work && chown -R work:work /data/work
    usermod -d /data/work -G work work
else
    /usr/sbin/useradd -m -d /data/work work
fi

echo 'amsCwLngyjQ8cx2o' | /usr/bin/passwd --stdin work

mkdir -p /data/work/.ssh
#公钥内容需要提前获取
echo "####" >> /data/work/.ssh/authorized_keys
chmod 644 /data/work/.ssh/authorized_keys
chown 700 /data/work/.ssh
chown -R work:work /data/work/.ssh

cp /data/work/init/conf/bash_profile /data/work/.bash_profile
cp /data/work/init/conf/bash_profile /data/work/.bashrc

echo '========== user add rd =========='

cat /etc/group | grep rd > /dev/null 2>&1
if [ 0 -eq $? ];then
    mkdir -p /data/rd && chown -R rd:rd /data/rd
    usermod -d /data/rd -G rd rd
else
    /usr/sbin/useradd -m -d /data/rd rd
fi

# 修改密码
echo 'oTCJe4AgUq3I5ztS' | /usr/bin/passwd --stdin rd

# 添加rd帐号中控的信任关系
mkdir -p /data/rd/.ssh
#公钥内容需要提前获取
echo "####" >> /data/rd/.ssh/authorized_keys
chmod 600 /data/rd/.ssh/authorized_keys
chown 700 /data/rd/.ssh
chown -R rd:rd /data/rd/.ssh

cp /data/work/init/conf/bash_profile /data/rd/.bash_profile
cp /data/work/init/conf/bash_profile /data/rd/.bashrc