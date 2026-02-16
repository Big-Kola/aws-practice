# Stage 1: Build Java app using Gradle
FROM gradle:8-jdk17 AS builder

WORKDIR /app
COPY . .

# Build the JAR
RUN gradle clean build

# Stage 2: Runtime image
FROM openjdk:17-jdk-slim

WORKDIR /app

# Copy the JAR from builder
COPY --from=builder /app/build/libs/*.jar app.jar

# Expose the port
EXPOSE 7071

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
