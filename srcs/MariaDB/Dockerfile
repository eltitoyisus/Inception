
FROM alpine:3.21.4

RUN apk update && apk add --no-cache mariadb mariadb-client bash

RUN mkdir -p /var/lib/mysql /run/mysqld \
	&& chown -R mysql:mysql /var/lib/mysql /run/mysqld

RUN sed -i 's/skip-networking/#skip-networking/' /etc/my.cnf.d/mariadb-server.cnf \
	&& sed -i 's/#bind-address=0.0.0.0/bind-address=0.0.0.0/' /etc/my.cnf.d/mariadb-server.cnf

COPY ./init-db.sh /init-db.sh
RUN chmod +x /init-db.sh

EXPOSE 3306

VOLUME ["/var/lib/mysql"]

ENTRYPOINT ["/bin/bash", "/init-db.sh"]
