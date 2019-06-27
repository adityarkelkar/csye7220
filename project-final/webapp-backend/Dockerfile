FROM openjdk:latest
MAINTAINER name Aditya Kelkar <adikelkar4@gmail.com>
ADD target/LibraryManagementSystem-0.0.1-SNAPSHOT.war webapp.war
EXPOSE 8085
ENV JAVA_OPTS=""
ENV DB_URL=""
ENV DB_USERNAME=""
ENV DB_PASSWORD=""
ENTRYPOINT exec java $JAVA_OPTS \
 -Djava.security.egd=file:/dev/./urandom \
 -Dspring.profiles.active=default \
 -Dspring.datasource.url=$DB_URL \
 -Dspring.datasource.username=$DB_USERNAME \
 -Dspring.datasource.password=$DB_PASSWORD \
 -jar app.jar
