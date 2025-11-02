FROM alpine:3.21.4

RUN apk update && apk add --no-cache wget ca-certificates

RUN wget https://github.com/portainer/portainer/releases/download/2.19.4/portainer-2.19.4-linux-amd64.tar.gz && \
    tar -xvzf portainer-2.19.4-linux-amd64.tar.gz && \
    mv portainer /opt/ && \
    rm portainer-2.19.4-linux-amd64.tar.gz

RUN mkdir -p /data

EXPOSE 9000 9443

WORKDIR /opt/portainer

CMD ["/opt/portainer/portainer", "--data", "/data"]
