#!/bin/sh
cd

wget  http://jdk-6u21-linux-x64-rpm.bin

chmod 700 jdk-6u21-linux-x64-rpm.bin && yes|./jdk-6u21-linux-x64-rpm.bin > /tmp/111

mv /usr/java /usr/local/

echo 'JAVA_HOME=/usr/local/java/jdk1.6.0_21/' >> /etc/profile
echo 'CLASSPATH=.:$JAVA_HOME/lib.tools.jar' >> /etc/profile
echo 'PATH=$JAVA_HOME/bin:$MAVEN_HOME/bin:$PATH' >> /etc/profile
echo 'export JAVA_HOME CLASSPATH PATH' >> /etc/profile


echo 'PATH=$JAVA_HOME/bin:$PATH' >> /etc/profile && source /etc/profile
java -version
rm -f jdk-6u21-linux-x64-rpm.bin