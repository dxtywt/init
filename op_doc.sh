构建系统，从初始化开始

基础，网络规划

第一章，硬件配置，raid

第二章，系统安装（自动），虚拟机kvm，docker

第三章，系统初始化

初始化脚本 init/scripts/
init_op.sh #总调用脚本
ntp.sh #初始配置ntp时间同步定时任务
proc_check.sh #进程监控脚本，发现进程消失，则自动重启
user_add.sh #添加用户，并建立ssh信任关系


第四章，服务部署



