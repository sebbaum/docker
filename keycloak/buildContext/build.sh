#!/bin/sh

IMAGE_NAME=sebbaum/keycloak
CONTAINER_NAME=sb-keycloak

sudo docker build -t ${IMAGE_NAME} .
sudo docker kill ${CONTAINER_NAME}
sudo docker rm ${CONTAINER_NAME}

sudo docker run --name ${CONTAINER_NAME} -d -p 10.0.0.1:8888:8080 -p 8889:9990 ${IMAGE_NAME} &

CONTAINER_START=$!
wait ${CONTAINER_START}
sudo docker exec ${CONTAINER_NAME} /opt/jboss/keycloak/config.sh
sudo docker restart ${CONTAINER_NAME}
