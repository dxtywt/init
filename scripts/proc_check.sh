#!/bin/bash
proc_name=进程名

while true;do
        echo 1
        proc_num=$(ps -ef|grep -v grep|grep $process_name -c)
        #echo $proc_num
        if [ 0 -eq $proc_num ];then
                cd /data/ && /data/work/php -f test.php
        fi
        sleep 1
done