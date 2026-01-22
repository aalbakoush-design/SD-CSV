# build stage
FROM maven:3.9-eclipse-temurin-11 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src

RUN mvn clean package -DskipTests

FROM eclipse-temurin:11-jre
WORKDIR /app
# Copy jar
COPY --from=build /app/target/commons-csv-*.jar app.jar
CMD ["java", "-jar", "app.jar"]