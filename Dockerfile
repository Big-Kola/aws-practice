# Use a specific OpenJDK 17 version
FROM openjdk:17.0.2-jdk

# Set the working directory inside the container
WORKDIR /app

# Copy the JAR file from the local build/libs directory to the container
COPY build/libs/*.jar /app/app.jar

# Expose the port your app is running on (port 7071 from the logs)
EXPOSE 7071

# Command to run the application
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
