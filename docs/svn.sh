1.检查软件包是否存在

rmp -qa | grep http
rmp -qa |grep subversion
rpm -qa |grep mod_dav_svn

2.安装所需的软件
yum install -y httpd subversion mod_dav_svn

3.创建svn目录
mkdir /svn       -----创建svn的目录
cd /svn
svnadmin create test ----创建svn的版本库，库名为tes

4.修改subversion.conf配置

#加载subversion模块
LoadModule dav_svn_module     modules/mod_dav_svn.so
LoadModule authz_svn_module   modules/mod_authz_svn.so

<Location /svn>
DAV svn
#SVNListParentPath on
SVNParentPath /svn        #svn存放的目录
AuthType Basic
AuthName "Authorization realm"
AuthUserFile /etc/svn/svn.passwd   #svn的访问密码
AuthzSVNAccessFile /etc/svn/svn.access   #svn的用户目录访问权限文件
Require valid-user                                #允许使用账号密码请求
#SVNAutoversioning on
#ModMimeUsePathInfo on
</Location>


5.修改svn，使用Apache进行管理
cd /svn
chown apache:apache -R test   #授权test为Apache目录浏览
chmod 755 test


6.使用Apache htpasswd 命令创建账号密码
mkdir /etc/svn
htpasswd -cm /etc/svn/svn.passwd zzx
输入两次密码

7.配置创建账号的权限
touch /etc/svn/svn.access #svn的访问目录权限

vi /etc/svn/svn.access  

[groups]
Testgroup = tianshi
Newgroup = test1,test2
[/]
@Newgroup = r

[test:/]    #test文件组权限设置  rw 读写权限
zzx = rw
@Testgroup = r

[test:/tianshi]
tianshi = rw

8.重启httpd、svnserve服务
service httpd start
svnserve -d -r /svn/test/

9.关闭SeLinux  
临时关闭  setenforce 0