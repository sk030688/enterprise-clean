FROM maven:3.9.6-eclipse-temurin-11 AS builder
WORKDIR /build
COPY . .
RUN mvn clean package

FROM image-registry.openshift-image-registry.svc:5000/openshift/jboss-webserver57-openjdk11-tomcat9-openshift-ubi8:latest
COPY --from=builder /build/target/ROOT.war /deployments/ROOT.war
