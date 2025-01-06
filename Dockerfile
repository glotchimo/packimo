FROM eclipse-temurin:17-jre-jammy

WORKDIR /server

ENV FABRIC_VERSION="1.20.1"
ENV LOADER_VERSION="0.16.9"
ENV INSTALLER_VERSION="1.0.1"

RUN apt-get update && \
    apt-get install -y curl && \
    curl -OJ "https://meta.fabricmc.net/v2/versions/loader/${FABRIC_VERSION}/${LOADER_VERSION}/${INSTALLER_VERSION}/server/jar" && \
    ls -la && \
    pwd && \
    test -f fabric-server-mc.${FABRIC_VERSION}-loader.${LOADER_VERSION}-launcher.${INSTALLER_VERSION}.jar

COPY server.properties .
COPY ops.json .
COPY eula.txt .
COPY mods/ mods/

EXPOSE 25565

CMD ["sh", "-c", "cd /minecraft && cp -r /server/* . && pwd && ls -la && java -Xmx3G -Xms1G -jar fabric-server-mc.${FABRIC_VERSION}-loader.${LOADER_VERSION}-launcher.${INSTALLER_VERSION}.jar nogui"]
