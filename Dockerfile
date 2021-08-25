FROM tomcat:8.5.65-jdk16-openjdk

ARG WAR_FILE=WAR_FILE_MUST_BE_SPECIFIED_AS_BUILD_ARG

# Copy all relevant files from the directory tree of the CATALINA_HOME
ADD --chown=root:root catalinaHome.tar.gz /usr/local/tomcat

# Copy all relevant applications from the directory tree of the CATALINA_HOME
#ADD --chown=root:root applications.tar.gz /usr/local/tomcat
COPY --chown=root:root ${WAR_FILE} /usr/local/tomcat/webapps/

# not applicable for the application
# Copy external resources and configurations
#ADD --chown=root:root additionalFiles.tar.gz /
