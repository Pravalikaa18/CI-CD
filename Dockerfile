FROM openjdk:11-jre-slim
COPY target/*.jar /app.jar
EXPOSE 8091
ENTRYPOINT ["java", "-jar", "/app.jar"]
https://82a6-103-182-177-42.ngrok-free.app
98897e03-c137-4438-8da4-dd1f33b63fba
