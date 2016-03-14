#!/bin/bash
# *@ author: wangting
# *@ date  : 2016-03-14
export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

function ps_ntp(){
    cronfile="/var/spool/cron/root"
    cp $cronfile /data/backup/conf/cron.root.$(date +"%Y-%m-%d")
    cp init/scripts/ntp.sh /data/work/opbin/crontab/init/> /dev/null 2>&1
    echo "00 */2 * * * sh /data/work/opbin/crontab/init/ntp.sh >> /data/work/opbin/crontab/init/ntp.log" > $cronfile
    sh /data/work/opbin/crontab/init/ntp.sh
}

