#!/bin/sh

# create user
adduser -D admin
echo "admin:12345" | chpasswd
echo admin > /etc/vsftpd.userlist
mkdir -p /home/admin/ftp
chown nobody:nogroup /home/admin/ftp
chmod a-w /home/admin/ftp
mkdir -p /home/admin/ftp/files
chown admin:admin /home/admin/ftp/files

# create sertificate
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
-keyout /etc/ssl/private/vsftpd.key -out /etc/ssl/certs/vsftpd.crt \
-subj "/C=RU/ST=TATARSTAN/L=KAZAN/O=NO/OU=NO/CN=21SCHOOL"

chmod +r /etc/vsftpd/vsftpd.conf

vsftpd etc/vsftpd/vsftpd.conf