FROM alpine:3.21.4

RUN apk update && apk add --no-cache \
    php83 \
    php83-fpm \
    php83-mysqli \
    php83-session \
    nginx \
    wget

RUN mkdir -p /run/nginx /var/www/html/adminer

RUN wget -O /var/www/html/adminer/index.php https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1-mysql.php && \
    chown -R nginx:nginx /var/www/html

COPY nginx.conf /etc/nginx/nginx.conf

RUN sed -i 's/listen = 127.0.0.1:9000/listen = 9000/' /etc/php83/php-fpm.d/www.conf

EXPOSE 80

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
