FROM alpine:3.21.4

RUN apk update && apk add --no-cache nginx

RUN mkdir -p /run/nginx

COPY index.html /var/www/html/
COPY style.css /var/www/html/
COPY script.js /var/www/html/

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
