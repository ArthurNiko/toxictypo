FROM openjdk:8-jre-alpine
WORKDIR /app
COPY ./target .
ENTRYPOINT [ "java","-jar" ]
CMD [ "toxictypoapp-1.0-SNAPSHOT" ]