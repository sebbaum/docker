#!/bin/bash

source config.sh

cd ${BUILD_FOLDER}
./backup.sh
docker kill ${CONTAINER}
docker rm ${CONTAINER}
docker build -t ${CONTAINER} .
docker run --name ${CONTAINER} -v ~/ghost/content/:/var/lib/ghost/ -p 80:2368 -d ${IMAGE}