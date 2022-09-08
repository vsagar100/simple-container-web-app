FROM scratch
FROM ubuntu:16.04
RUN mkdir /opt/java8
RUN mkdir /opt/tomcat8
ENV JAVA_HOME /opt/java8
ENV CATALINA_HOME /opt/tomcat8
ENV PATH $PATH:$JAVA_HOME/bin:$CATALINA_HOME/bin
ADD jdk1.8.0_112 /opt/java8
ADD apache-tomcat-8.0.38 /opt/tomcat8
ADD target/simple-container-web-app-1.0.0.war /opt/tomcat8/webapps
EXPOSE 8080
CMD ["catalina.sh", "run"]
