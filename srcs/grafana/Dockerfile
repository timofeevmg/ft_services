FROM alpine:3.12

# install
RUN apk update && apk upgrade
RUN apk add vim
RUN apk add grafana --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community/

# copy configs and scripts
COPY grafana.db /usr/share/grafana/data/
COPY start.sh /
RUN chmod +x /start.sh

# Grafana port 
EXPOSE 3000

CMD ["/start.sh"]