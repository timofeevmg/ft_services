FROM alpine:3.12

# install
RUN apk update && apk upgrade
RUN apk add vim wget
RUN apk add nginx \
	php7 php7-fpm php7-curl php7-json php7-mysqli php7-gd \
	php7-phar php7-ctype php7-iconv php7-dom php7-zip \
	php7-exif php7-fileinfo php7-mbstring php7-imagick \
	php7-xmlreader php7-xmlrpc \
	supervisor

# install wordpress
RUN adduser -D -g 'www' www
RUN mkdir /www
RUN chown -R www:www /var/lib/nginx
RUN chown -R www:www /www
RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xf *.tar.gz
RUN rm -f *.tar.gz
RUN mv wordpress /www/wordpress

# install WP CLI
RUN wget https://raw.github.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /www/wordpress/
RUN ln -s /www/wordpress/wp-cli.phar /bin/wp
COPY wp-cli.yml /
RUN chmod +r /wp-cli.yml

# copy configs and scripts
RUN mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig
COPY nginx.conf etc/nginx/nginx.conf
RUN mkdir -p /run/nginx
COPY wp-config.php /www/wordpress
COPY supervisord.conf etc/supervisord.conf
COPY start.sh /
RUN chmod +x /start.sh
COPY wp_adm_pswd.txt /
RUN chmod +r /wp_adm_pswd.txt
COPY users.csv /
RUN chmod +r /users.csv

# for 5050
EXPOSE 5050

CMD ["/start.sh"]