#!/bin/sh
cd /etc
echo "net.ipv4.tcp_fin_timeout = 5" >>sysctl.conf
echo "net.ipv4.tcp_keepalive_time = 5" >>sysctl.conf
echo "net.ipv4.tcp_syncookies = 1">>sysctl.conf
echo "net.ipv4.tcp_tw_reuse = 1">>sysctl.conf
echo "net.ipv4.tcp_tw_recycle = 1">>sysctl.conf
echo "net.ipv4.tcp_synack_retries = 3">>sysctl.conf
echo "net.ipv4.tcp_syn_retries = 3">>sysctl.conf
echo "net.ipv4.tcp_max_syn_backlog = 81920">>sysctl.conf
echo "net.ipv4.conf.eth1.rp_filter = 0">>sysctl.conf
echo "net.ipv4.conf.all.rp_filter = 0">>sysctl.conf
sysctl -p