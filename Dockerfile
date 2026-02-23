# -------- Stage 1: Build WAR --------
FROM maven:3.9.6-eclipse-temurin-11 AS builder

WORKDIR /build

COPY pom.xml .
COPY src ./src

RUN mvn clean package

# -------- Stage 2: Runtime --------
FROM registry.access.redhat.com/ubi8/openjdk-11

USER root

RUN microdnf install -y tar gzip && microdnf clean all

WORKDIR /deployments

COPY --from=builder /build/target/ROOT.war /deployments/ROOT.war

USER 185
