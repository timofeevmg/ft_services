FROM alpine:3.12

# install
RUN apk update && apk upgrade
RUN apk add vim
RUN apk add vsftpd vsftpd-doc openssl

# copy configs and scripts
RUN mv /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf.bak
COPY vsftpd.conf /etc/vsftpd/

#
COPY start.sh /
RUN chmod +x /start.sh

# for 20/21
EXPOSE 21 10015

CMD ["/start.sh"]