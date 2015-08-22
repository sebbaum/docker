#!/bin/sh

USER=$1
DOMAIN=[DOMAIN/IP]
BUILD_FOLDER=wildfly-build

cd ..
mvn clean package
cp -v ./target/[filename].war ./build/buildContext/
cd build/

echo "Deleting old context on server..."
ssh -t ${USER}@${DOMAIN} "rm -rf /home/${USER}/${BUILD_FOLDER}"
scp -r ./buildContext/ ${USER}@${DOMAIN}:/home/${USER}/${BUILD_FOLDER}
echo "Building container on server..."
ssh -t ${USER}@${DOMAIN} "cd /home/${USER}/${BUILD_FOLDER}/ && ./build.sh"