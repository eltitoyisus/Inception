
FROM alpine:3.21.4

ARG DOMAIN_NAME=localhost

RUN apk update && apk add --no-cache nginx openssl

RUN mkdir -p /run/nginx /etc/nginx/certs

COPY nginx.conf /etc/nginx/nginx.conf

RUN sed -i "s/DOMAIN_NAME/${DOMAIN_NAME}/g" /etc/nginx/nginx.conf

COPY certs/nginx.crt /etc/nginx/certs/nginx.crt
COPY certs/nginx.key /etc/nginx/certs/nginx.key

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
