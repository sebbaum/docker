#!/bin/sh

# run wildfly
WILDFLY=wildfly
sudo docker build -t ${WILDFLY} .
sudo docker kill ${WILDFLY}
sudo docker rm ${WILDFLY}
sudo docker run -d --name ${WILDFLY} --restart=always -p 80:8080 -p 9990:9990 ${WILDFLY}
