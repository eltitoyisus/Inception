FROM alpine:3.21.4

RUN apk update && apk add --no-cache nginx openssl

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
