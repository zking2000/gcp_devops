FROM centos
RUN yum install -y wget
RUN yum update -y
RUN mkdir /var/tmp/jdk
RUN wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie"  -P /var/tmp/jdk https://download.oracle.com/otn/java/jdk/8u221-b11/230deb18db3e4014bb8e3e8324f81b43/jdk-8u221-linux-x64.tar.gz
RUN tar xzf /var/tmp/jdk/jdk-8u221-linux-x64.tar.gz -C /var/tmp/jdk && rm -rf /var/tmp/jdk/jdk-8u221-linux-x64.tar.gz
RUN mkdir /var/tmp/tomcat
RUN wget -P  /var/tmp/tomcat http://mirrors.tuna.tsinghua.edu.cn/apache/tomcat/tomcat-7/v7.0.96/bin/apache-tomcat-7.0.96.tar.gz
RUN tar xzf /var/tmp/tomcat/apache-tomcat-7.0.96.tar.gz -C /var/tmp/tomcat && rm -rf /var/tmp/tomcat/apache-tomcat-7.0.96.tar.gz
RUN echo > ./var/tmp/tomcat/apache-tomcat-7.0.96/conf/tomcat-users.xml
RUN echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" >> ./var/tmp/tomcat/apache-tomcat-7.0.96/conf/tomcat-users.xml
RUN echo "<tomcat-users>" >> ./var/tmp/tomcat/apache-tomcat-7.0.96/conf/tomcat-users.xml
RUN echo " <role rolename=\"manager-gui\"/>" >> ./var/tmp/tomcat/apache-tomcat-7.0.96/conf/tomcat-users.xml
RUN echo " <role rolename=\"admin-gui\"/>" >> ./var/tmp/tomcat/apache-tomcat-7.0.96/conf/tomcat-users.xml
RUN echo " <user username=\"admin\" password=\"admin\" roles=\"manager-gui,admin-gui\"/>" >> ./var/tmp/tomcat/apache-tomcat-7.0.96/conf/tomcat-users.xml
RUN echo "</tomcat-users>" >> ./var/tmp/tomcat/apache-tomcat-7.0.96/conf/tomcat-users.xml
RUN sed -i /^$/d /var/tmp/tomcat/apache-tomcat-7.0.96/conf/tomcat-users.xml
ENV JAVA_HOME /var/tmp/jdk/jdk1.8.0_161
ENV CATALINA_HOME /var/tmp/tomcat/apache-tomcat-7.0.96
ENV PATH $PATH:$JAVA_HOME/bin:$CATALINA_HOME/bin
EXPOSE 8080
CMD ["./var/tmp/tomcat/apache-tomcat-7.0.96/bin/catalina.sh","run"]