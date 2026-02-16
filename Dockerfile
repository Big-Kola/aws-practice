FROM eclipse-temurin:17-jdk-focal

WORKDIR /app

# Copy the pre-built jar
COPY build/libs/java-react-example.jar app.jar

# Expose the app port
EXPOSE 7071

# Run the app
ENTRYPOINT ["java", "-jar", "app.jar"]
