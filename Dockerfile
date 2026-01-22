# (Build Stage)
FROM maven:3.8.6-openjdk-11 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# (Run Stage)
FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=build /app/target/commons-csv-*.jar app.jar
CMD ["java", "-jar", "app.jar"]
