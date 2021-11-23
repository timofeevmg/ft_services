#!/bin/sh

sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf
sed -i "s|.*skip-networking.*|skip-networking=false|g" /etc/my.cnf.d/mariadb-server.cnf

/etc/init.d/mariadb setup
openrc default
rc-service mariadb start

# create database
echo "create database wpdb default character set utf8 collate utf8_unicode_ci" | mysql
echo "create user 'admin'@'%' identified by '12345'" | mysql
echo "grant all on wpdb.* to 'admin'@'%'" | mysql
echo "flush privileges" | mysql

rc-service mariadb stop
mysqld_safe --datadir=/var/lib/mysql/

#mariadb wpdb > wpdb.sql