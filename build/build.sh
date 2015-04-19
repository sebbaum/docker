#!/bin/bash

source config.sh

echo "Building ghost-blog..."
cd ${BUILD_FOLDER}
#./backup.sh
docker kill ${CONTAINER}
docker rm ${CONTAINER}
docker build -t ${CONTAINER} .
docker run --name ${CONTAINER} --restart=always -v ~/ghost/content/:/var/lib/ghost/ -p 9876:2368 -d ${IMAGE}