FROM openjdk:11 AS BUILD_IMAGE
RUN apt update && apt install maven -y
COPY ./ javaapp-project
RUN cd javaapp-project &&  mvn install 

FROM tomcat:9-jre11
LABEL "Project"="Javaapp"
LABEL "Author"="TrucDTA"
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=BUILD_IMAGE javaapp-project/target/javaapp-v2.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
