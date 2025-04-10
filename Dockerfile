FROM openjdk:11-jre-slim
COPY target/*.jar /app.jar
EXPOSE 8091
ENTRYPOINT ["java", "-jar", "/app.jar"]
https://82a6-103-182-177-42.ngrok-free.app
