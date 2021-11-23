FROM alpine:3.12

# install
RUN apk update && apk upgrade
RUN apk add vim
RUN apk add influxdb --repository=http://dl-cdn.alpinelinux.org/alpine/v3.10/community/

# copy configs and scripts
# RUN mkdir -p /var/lib/influxdb
# RUN chown -R influxdb:influxdb /var/lib/influxdb
COPY start.sh /
RUN chmod +x /start.sh

# InfluxDB port 
EXPOSE 8086

CMD ["/start.sh"]