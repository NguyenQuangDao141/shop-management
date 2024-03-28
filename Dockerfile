# Use a slimmer image for the final container
FROM eclipse-temurin:17-jre
COPY  target/*.jar /app.jar
WORKDIR /app
ENTRYPOINT [ "java", "-jar" , "/app.jar" ]
