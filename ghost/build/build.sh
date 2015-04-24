#!/bin/bash

source config.sh

echo "Building ghost-blog..."
cd ${BUILD_FOLDER}
#./backup.sh
sudo docker kill ${CONTAINER}
sudo docker rm ${CONTAINER}
sudo docker build -t ${CONTAINER} .

if [ ${PRODUCTION} -eq 1 ]
then
  sudo docker run --name ${CONTAINER} --restart=always -v ~/ghost-blog/content/:/var/lib/ghost/ -p 9876:2368 -d -e NODE_ENV=production ${IMAGE}
else
  sudo docker run --name ${CONTAINER} -v ~/ghost-blog/content/:/var/lib/ghost/ -p 9876:2368 -d ${IMAGE}
fi
