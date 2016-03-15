#!/bin/bash
#mobile msg to
msgsto=(num1,num2)

g_title="Report Message:"
##mobilemsg,mail-subject,mail-content
Report(){
    mobildmsg=$1
    from=$(hostname |awk -F'.' '{print $1}')
    for ((i=0; i<${#msgsto[@]} ; i++ ))  ;do
        curl "http://####/monitor.php?action=1&mobile=${msgsto[$i]}&content=${from}:${g_title},${mobildmsg}" >/dev/null  2>&1
    done
}