#!/bin/bash
#This script is used to check the server info
#system_info
system_info() {
echo "System-release:`cat /etc/redhat-release| awk '{print $1$2,$7}' |tr -d  '\n' && uname -a |awk '{print $14}'`"
}

#memory_info
memory_info()
{
echo "Memory-size:`free -m|head -2|tail -n 1|awk '{print $2}'`"
}

#ipmac_info
#ipmac_info()
#{
#echo "`ip a |grep inet|grep eth|awk '{print $2}'|awk -F/ '{print $1}'`" | xargs -i echo ip:{}
#echo "`ip a  | ip a |grep ink/ether |awk '{print $2}'`" | xargs -i echo mac:{}
#}

#disk_info
disk_info()
{
echo "disk:`fdisk -l |grep Disk | awk  '{print $2$3$4}' |awk -F, '{print $1}' |awk -F/  '{print $3}'`" |tr '\n' ' '
}

#cpu_info
cpu_info()
{
echo "cpu:`cat /proc/cpuinfo | grep name | cut -f2 -d: | uniq -c|awk -FCPU '{print $2}'|awk '{print $1$3}'`"
}

#model_info
model_info()
{
echo "model:`dmidecode | grep -i man |cut -f 2 -d ":" |head -1 | tr -d '\n' && dmidecode | grep "Product Name" |head -1 | awk '{ print $NF }'`"
}


#ipmac_info
ipmac_info()
{
echo "ip:`ip a |grep inet|grep eth|awk '{print $2}'|awk -F/ '{print $1}'`"|tr '\n' ' '
echo "mac:`ip a  | ip a |grep ink/ether |awk '{print $2}'`" |tr '\n' ' '
}

system_info
memory_info
disk_info
echo ""
cpu_info
#model_info
ipmac_info
echo ""
