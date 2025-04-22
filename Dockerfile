FROM eclipse-temurin:21-alpine
MAINTAINER John Paul Alcala jp@jpalcala.com

# grab gosu for easy step-down from root
RUN apk add curl rsync tmux \
    && apk add gosu --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing
    # && apt-get update && apt-get install -y curl rsync tmux && rm -rf /var/lib/apt/lists/* \
    # && curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.17/gosu-$(dpkg --print-architecture)" \
    # && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.17/gosu-$(dpkg --print-architecture).asc" \
    # && gpg --verify /usr/local/bin/gosu.asc \
    # && rm /usr/local/bin/gosu.asc \
    # && chmod +x /usr/local/bin/gosu

RUN addgroup -g 1000 minecraft && \
    adduser  -G minecraft -u 1000 -D -S minecraft && \
    touch /run/first_time && \
    mkdir -p /opt/minecraft /var/lib/minecraft /usr/src/minecraft && \
    echo "set -g status off" > /root/.tmux.conf

COPY spigot /usr/local/bin/
ONBUILD COPY . /usr/src/minecraft

EXPOSE 25565

VOLUME ["/opt/minecraft", "/var/lib/minecraft"]

ENTRYPOINT ["/usr/local/bin/spigot"]
CMD ["run"]
