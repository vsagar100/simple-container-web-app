FROM tomcat

COPY simple-container-webapp.war $CATALINA_HOME/webapps/
