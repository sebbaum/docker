#!/bin/sh

USER=$1
DOMAIN=$2
BUILD_FOLDER=keycloak-build

echo "Deleting old context on server..."
ssh -t ${USER}@${DOMAIN} "rm -rf /home/${USER}/${BUILD_FOLDER}"
scp -r ./buildContext/ ${USER}@${DOMAIN}:/home/${USER}/${BUILD_FOLDER}
echo "Building container on server..."
ssh -t ${USER}@${DOMAIN} "cd /home/${USER}/${BUILD_FOLDER}/ && ./build.sh"
