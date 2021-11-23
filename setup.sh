#!/bin/sh

# install hypervisor
minikube start --vm-driver=virtualbox

#--metallb--#
# install addon for load balancing
minikube addons enable metallb
# apply config for metallb
kubectl apply -f srcs/metallb/metallb_conf.yaml
#-----------#

# switch docker to work into minikube
eval $(minikube docker-env)

#--nginx--#
docker build -t nginx_img ./srcs/nginx
kubectl apply -f ./srcs/nginx/nginx.yaml
#---------#

#--mysql--#
docker build -t sql_img ./srcs/sql
#kubectl apply -f ./srcs/sql/token.yaml
kubectl apply -f ./srcs/sql/sql-pv.yaml
kubectl apply -f ./srcs/sql/sql.yaml
#---------#

#--wordpress--#
docker build -t wp_img ./srcs/wp
kubectl apply -f ./srcs/wp/wp.yaml
#-------------#

#--phpmyadmin--#
docker build -t pma_img ./srcs/pma
kubectl apply -f ./srcs/pma/pma.yaml
#--------------#

#--ftps--#
docker build -t ftps_img ./srcs/ftps
kubectl apply -f ./srcs/ftps/ftps-pv.yaml
kubectl apply -f ./srcs/ftps/ftps.yaml
#--------#

#--influxdb--#
docker build -t influxdb_img ./srcs/influxdb
kubectl apply -f ./srcs/influxdb/influxdb-pv.yaml
kubectl apply -f ./srcs/influxdb/influxdb.yaml
#------------#

#--telegraf--#
docker build -t telegraf_img ./srcs/telegraf
kubectl apply -f ./srcs/telegraf/telegraf.yaml
#------------#

#--grafana--#
docker build -t grafana_img ./srcs/grafana
kubectl apply -f ./srcs/grafana/grafana.yaml
#-----------#

#minikube dasboard