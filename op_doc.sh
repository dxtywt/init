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
    Report.sh #短信通知
    sysctl_config.sh #内核参数修改
    install_java.sh #java环境配置
    lvs_vip_bind.sh #后端服务器绑定lvs_vip
    root #切换账户，危险命令
    interactive_input.sh #脚本执行，过程控制，二次确认
    info.sh #查看系统信息


第四章，服务部署
批量管理脚本





