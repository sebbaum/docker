#!/bin/bash

#source ./config.sh

CONTAINER=ghost-blog
IMAGE=my-ghost-blog
PRODUCTION=1

echo "Building ghost-blog..."
#cd ${BUILD_FOLDER}
sudo docker rm -f ${CONTAINER}
sudo docker build -t ${IMAGE} .

if [ ${PRODUCTION} -eq 1 ]
then
  sudo docker run --name ${CONTAINER} \
  -v ~/ghost-blog/content/:/var/lib/ghost/ \
  -p 80:2368 \
  -d \
  -e NODE_ENV=production \
  --restart=always \
  ${IMAGE}
else
  sudo docker run --name ${CONTAINER} \
  -v ~/ghost-blog/content/:/var/lib/ghost/ \
  -p 80:2368 \
  -d \
  -e NODE_ENV=production \
  ${IMAGE}
fi
