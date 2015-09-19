#!/bin/sh

IMAGE_NAME=sebbaum/keycloak
CONTAINER_NAME=sb-keycloak

sudo docker build -t ${IMAGE_NAME} .
sudo docker kill ${CONTAINER_NAME}
sudo docker rm ${CONTAINER_NAME}
sudo docker run --name ${CONTAINER_NAME} --restart=always -d -p 8888:8443 ${IMAGE_NAME}
