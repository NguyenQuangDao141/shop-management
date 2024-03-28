# Use a slimmer image for the final container
FROM eclipse-temurin:17-jre

# Copy the JAR file from the builder stage
COPY  target/*.war /app.war

COPY  src/main/webapp/* /webapp/

# Set the working directory
WORKDIR /app

# Entrypoint to run the JAR file
ENTRYPOINT ["java", "-jar", "/app.war"]
