FROM alpine:3.12

# install
RUN apk update && apk upgrade
RUN apk add vim
RUN apk add nginx openssl

# copy configs and scripts
RUN mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig
COPY nginx.conf etc/nginx/nginx.conf
COPY index.html /var/www
RUN mkdir -p /run/nginx
COPY start.sh /
RUN chmod +x /start.sh

# create sertificate
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/C=RU/ST=TATARSTAN/L=KAZAN/O=NO/OU=NO/CN=21SCHOOL"

# for 80:80 443:443
EXPOSE 80 443 22

CMD ["/start.sh"]