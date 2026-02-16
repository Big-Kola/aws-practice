FROM openjdk:17-jdk-slim

WORKDIR /app

# Copy the already built jar from local repo
COPY build/libs/*.jar app.jar

# Expose the app port
EXPOSE 7071

# Run the app
ENTRYPOINT ["java", "-jar", "app.jar"]
