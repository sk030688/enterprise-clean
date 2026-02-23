# -------- Stage 1: Build WAR --------
FROM maven:3.9.6-eclipse-temurin-11 AS builder

WORKDIR /build

COPY pom.xml .
COPY src ./src

RUN mvn clean package

# -------- Stage 2: Runtime --------
FROM image-registry.openshift-image-registry.svc:5000/openshift/jboss-webserver57-openjdk11-tomcat9-openshift-ubi8:latest

USER root

RUN microdnf install -y tar gzip && microdnf clean all

WORKDIR /deployments

COPY --from=builder /build/target/ROOT.war /deployments/ROOT.war

USER 185
