#!/bin/bash

source config.sh

echo "Building ghost-blog..."
cd ${BUILD_FOLDER}
#./backup.sh
sudo docker kill ${CONTAINER}
sudo docker rm ${CONTAINER}
#sudo docker-compose up
sudo docker build -t ${CONTAINER} .
sudo docker run --name ${CONTAINER} --restart=always -v ~/ghost-blog/content/:/var/lib/ghost/ -p 9876:2368 -d ${IMAGE}