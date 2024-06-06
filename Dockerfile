FROM maven:3-ibm-semeru-21-jammy as build
WORKDIR /app
COPY . .
COPY settings.xml /usr/share/maven/conf/settings.xml

FROM ibm-semeru-runtimes:open-21-jre
WORKDIR /app
COPY --from=build /app/target/Jetbrains-Help.jar Jetbrains-Help.jar
ENV TZ=Asia/Shanghai
RUN ln -sf /usr/share/zoneinfo/{TZ} /etc/localtime && echo "{TZ}" > /etc/timezone
EXPOSE 10768
ENTRYPOINT ["java", "-jar", "Jetbrains-Help.jar"]