#!/bin/bash

USER=$1
URL=$2
BUILD_FOLDER=/home/${USER}/ghost-blog/build

echo "Deleting old context on server..."
ssh -t ${USER}@${URL} "rm -rf ${BUILD_FOLDER}"
ssh -t ${USER}@${URL} "mkdir /home/${USER}/ghost-blog"
scp -r ./build/ ${USER}@${URL}:${BUILD_FOLDER}
echo "Building container on server..."
ssh -t ${USER}@${URL} "cd ${BUILD_FOLDER} && ./build.sh"

exit 0
