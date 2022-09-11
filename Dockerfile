FROM tomcat:latest
RUN mv webapps webapps2
RUN mv webapps.dist/ webapps
COPY target/simple-container-web-app-1.0.0.war webapps/
COPY tomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml
COPY context.xml /usr/local/tomcat/webapps/manager/META-INF/context.xml
EXPOSE 8080
CMD ["catalina.sh", "run"]
