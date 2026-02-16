# Stage 1: Build the Java app
FROM gradle:8-jdk17 AS builder
WORKDIR /app
COPY . .
RUN gradle clean build

# Stage 2: Create runtime image
FROM openjdk:17
WORKDIR /app
COPY --from=builder /app/build/libs/*.jar app.jar
EXPOSE 7071
ENTRYPOINT ["java", "-jar", "app.jar"]
