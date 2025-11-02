FROM alpine:3.21.4

RUN apk update && apk add --no-cache vsftpd

RUN adduser -D -h /home/ftpuser ftpuser && \
    echo "ftpuser:ftppass" | chpasswd

COPY vsftpd.conf /etc/vsftpd/vsftpd.conf

RUN mkdir -p /var/run/vsftpd/empty

EXPOSE 21 21000-21010

CMD ["vsftpd", "/etc/vsftpd/vsftpd.conf"]
