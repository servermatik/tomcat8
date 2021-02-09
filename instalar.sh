echo servermatik info@servermatik.es


#Instalacion 

echo Actualizando Sistema 
yum -y update && yum -y install \
	sudo \
	tar \
	gzip \
	openssh-clients \
	java-1.7.0-openjdk-devel \
	vi \
	find \
  && rm -rf /var/cache/yum*


groupadd tomcat
useradd -M -s /bin/nologin -g tomcat -d /opt/tomcat tomcat

tar -xzvf apache-tomcat-8.5.61.tar.gz /opt/

mv /opt/apache-tomcat-8.5.61 /opt/tomcat

cp -r tomcat-users.xml /opt/tomcat/conf
cp -r context.xml /opt/tomcat/webapps/manager/META-INF/context.xml
cp -r context.xml /opt/tomcat/webapps/host-manager/META-INF/context.xml

cd /opt/tomcat; \
	chgrp -R tomcat /opt/tomcat; \
	chmod -R g+r conf; \
	chmod g+x conf; \
	chown -R tomcat /opt/tomcat/webapps/; \
	chown -R tomcat /opt/tomcat/work/; \
	chown -R tomcat /opt/tomcat/temp/; \
	chown -R tomcat /opt/tomcat/logs/

ENV JAVA_HOME /usr/lib/jvm/jre
ENV CATALINA_PID /opt/tomcat/temp/tomcat.pid
ENV CATALINA_HOME /opt/tomcat
ENV CATALINA_BASE /opt/tomcat

EXPOSE 8080
VOLUME "/opt/tomcat/webapps"
WORKDIR /opt/tomcat

#Lanzar Tomcat
CMD ["/opt/tomcat/bin/catalina.sh", "run"]
