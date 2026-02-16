# Stage 1: Build the app
FROM gradle:8.3.1-jdk17 AS build

WORKDIR /app
COPY build.gradle settings.gradle ./
COPY src ./src

# Build the jar using system Gradle
RUN gradle clean bootJar --no-daemon

# Stage 2: Run the app
FROM openjdk:17-jdk-slim

WORKDIR /app

# Copy jar from build stage
COPY --from=build /app/build/libs/*.jar app.jar

# Expose the port your app runs on
EXPOSE 7071

# Run the app
ENTRYPOINT ["java", "-jar", "app.jar"]
