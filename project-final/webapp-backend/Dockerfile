FROM openjdk:latest
LABEL maintainer="Aditya Kelkar <adikelkar4@gmail.com>"
ADD target/LibraryManagementSystem-0.0.1-SNAPSHOT.war webapp.war
EXPOSE 80
ENTRYPOINT exec java $JAVA_OPTS \
 -Dspring.profiles.active=default \
 -Dspring.datasource.url=$DB_URL \
 -Dspring.datasource.username=$DB_USERNAME \
 -Dspring.datasource.password=$DB_PASSWORD \
 -jar app.jar
