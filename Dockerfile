# Stage 1: Build the Java application
FROM gradle:8-jdk17 AS builder

# Set working directory
WORKDIR /app

# Copy all project files
COPY . .

# Build the application (produces JAR in build/libs/)
RUN gradle clean build

# Stage 2: Create a lightweight runtime image
FROM openjdk:17-jdk

# Set working directory
WORKDIR /app

# Copy the JAR from the builder stage
COPY --from=builder /app/build/libs/*.jar app.jar

# Expose the port your app uses
EXPOSE 7071

# Run the JAR when container starts
ENTRYPOINT ["java", "-jar", "app.jar"]
