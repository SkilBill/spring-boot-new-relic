FROM openjdk:8-jdk-alpine
WORKDIR /app
EXPOSE 8080

# Add the NewRelic agent
ADD "https://download.newrelic.com/newrelic/java-agent/newrelic-agent/current/newrelic-java.zip" newrelic.zip
RUN unzip newrelic.zip

# Add the application's jar
COPY target/gs-spring-boot-*.jar hello.jar

# Run the jar file with NewRelic
ENTRYPOINT ["java","-javaagent:./newrelic/newrelic.jar","-Djava.security.egd=file:/dev/./urandom","-jar","/app/hello.jar"]
