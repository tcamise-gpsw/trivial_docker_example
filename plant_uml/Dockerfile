FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install -y \
    openjdk-17-jdk-headless && \
    rm -rf /var/lib/apt/lists/*

COPY . /

ENTRYPOINT [ "/entrypoint.sh" ]