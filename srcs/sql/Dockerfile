FROM alpine:3.12

# install
RUN apk update && apk upgrade
RUN apk add vim
RUN apk add mariadb mariadb-common mariadb-client \
	openrc
RUN rc-status
RUN touch /run/openrc/softlevel

# copy configs and scripts
COPY start.sh /
RUN chmod +x /start.sh
RUN mkdir -p /run/mysqld
RUN chown -R mysql /run/mysqld

# MySQL port 
EXPOSE 3306

CMD ["/start.sh"]