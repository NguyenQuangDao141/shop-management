

# Use a slimmer image for the final container
FROM eclipse-temurin:17-jdk-alpine

# Copy the JAR file from the builder stage
COPY target/*.jar app.jar

# Set the working directory
WORKDIR /app

# Entrypoint to run the JAR file
ENTRYPOINT ["java", "-jar", "app.jar"]
