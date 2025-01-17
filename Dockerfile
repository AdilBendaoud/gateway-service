FROM maven:3.8.4-openjdk-17 AS builder
WORKDIR /app

COPY ./src ./src
COPY ./pom.xml .

RUN mvn clean package -DskipTests

FROM openjdk:17-jdk-alpine
WORKDIR /app

COPY --from=builder /app/target/*.jar gateway.jar

ENTRYPOINT ["java", "-jar", "/app/gateway.jar"]