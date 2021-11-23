FROM alpine:3.12

RUN apk update && apk upgrade
RUN apk add vim wget
RUN apk add nginx php7 php7-fpm php7-session php7-iconv php7-json \
	php7-gd php7-curl php7-xml php7-mysqli php7-imap php7-cgi fcgi \
	php7-pdo php7-pdo_mysql php7-soap php7-xmlrpc php7-posix php7-mcrypt \
	php7-gettext php7-ldap php7-ctype php7-dom php7-mbstring supervisor

# install phpmyadmin
RUN wget https://files.phpmyadmin.net/phpMyAdmin/4.9.7/phpMyAdmin-4.9.7-all-languages.tar.gz
RUN tar -xf phpMyAdmin-4.9.7-all-languages.tar.gz
RUN rm -f phpMyAdmin-4.9.7-all-languages.tar.gz
RUN mv phpMyAdmin-4.9.7-all-languages /var/www/phpmyadmin
RUN mkdir /var/www/phpmyadmin/tmp
# RUN chmod -R 777 /var/www/

COPY test.php /var/www/phpmyadmin

# copy configs and scripts
RUN mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig
COPY nginx.conf etc/nginx/nginx.conf
RUN mkdir -p /run/nginx
RUN mv /var/www/phpmyadmin/config.sample.inc.php /var/www/phpmyadmin/config.orig.inc.php
COPY config.inc.php /var/www/phpmyadmin
COPY supervisord.conf etc/supervisord.conf
COPY start.sh /
RUN chmod +x /start.sh


# for 5000
EXPOSE 5000

CMD ["/start.sh"]