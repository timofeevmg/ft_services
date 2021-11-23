FROM alpine:3.12

# install
RUN apk update && apk upgrade
RUN apk add vim
RUN apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/community/

# copy configs and scripts
RUN mkdir /etc/telegraf
COPY telegraf.conf /etc/telegraf/telegraf.conf
RUN chmod +r /etc/telegraf/telegraf.conf
# RUN echo "telegraf --input-filter docker --output-filter influxdb config > /etc/telegraf/telegraf.conf"
COPY start.sh /
RUN chmod +x /start.sh

CMD ["/start.sh"]