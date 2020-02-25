FROM openjdk:8-jre-alpine
WORKDIR /app
COPY ./target .
ENTRYPOINT [ "/bin/sh", "-c", "java -jar toxictypoapp*" ]