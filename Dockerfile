# -------- Stage 1: Build WAR --------
FROM maven:3.9.6-eclipse-temurin-11 AS builder

WORKDIR /build

COPY pom.xml .
COPY src ./src

RUN mvn clean package

# -------- Stage 2: Runtime --------
FROM openshift/jboss-webserver57-openjdk11-tomcat9-openshift-ubi8:latest

WORKDIR /deployments

COPY --from=builder /build/target/ROOT.war /deployments/ROOT.war

USER 185
