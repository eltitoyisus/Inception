
FROM alpine:3.21.4

RUN apk update && apk add mariadb mariadb-client

EXPOSE 8000

CMD ["nginx", "-g", "daemon off;"]
