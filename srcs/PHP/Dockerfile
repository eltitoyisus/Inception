FROM alpine:3.21.4

RUN apk update && apk add --no-cache \
	php php-fpm php-mysqli php-json php-curl php-gd php-xml php-mbstring php-zip php-session php-opcache php-dom php-iconv php-tokenizer php-xmlwriter php-simplexml php-phar php-intl php-fileinfo php-pdo php-pdo_mysql wget tar

RUN adduser -D -G www-data www-data

WORKDIR /var/www/html
RUN wget https://wordpress.org/latest.tar.gz \
	&& tar -xzf latest.tar.gz --strip-components=1 \
	&& rm latest.tar.gz

COPY wp-config.php /var/www/html/wp-config.php

RUN chown -R www-data:www-data /var/www/html

RUN sed -i 's/^user = .*/user = www-data/' /etc/php83/php-fpm.d/www.conf \
	&& sed -i 's/^group = .*/group = www-data/' /etc/php83/php-fpm.d/www.conf \
	&& sed -i 's/^listen = .*/listen = 0.0.0.0:9000/' /etc/php83/php-fpm.d/www.conf

EXPOSE 9000

CMD ["php-fpm83", "-F"]
