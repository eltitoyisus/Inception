
FROM alpine:3.21.4

RUN apk update && apk add --no-cache php php-fpm php-mysqli

EXPOSE 3000

CMD ["php-fpm83", "-F"]
