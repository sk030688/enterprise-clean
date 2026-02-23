FROM registry.access.redhat.com/ubi8/openjdk-11

USER root

RUN microdnf install -y tar gzip && microdnf clean all

WORKDIR /deployments

COPY target/ROOT.war /deployments/ROOT.war

USER 185
