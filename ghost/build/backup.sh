#!/bin/bash

source config.sh

TIMESTAMP=`date "+%Y%m%d-%H%M"`
BACKUP_TAR=ghost_backup_${TIMESTAMP}.tar.gz
CONTENT_FOLDER=/var/lib/ghost

docker stop ${CONTAINER}
docker cp ${CONTAINER}:${CONTENT_FOLDER}/apps ./build/content
docker cp ${CONTAINER}:${CONTENT_FOLDER}/data ./build/content
docker cp ${CONTAINER}:${CONTENT_FOLDER}/images ./build/content
docker cp ${CONTAINER}:${CONTENT_FOLDER}/config.js ./build/content
docker start ${CONTAINER}

tar cfz ghost_backup_${TIMESTAMP}.tar.gz ./content
echo ${BACKUP_FOLDER}
if [ ! -d "${BACKUP_FOLDER}" ]; then
    mkdir -p ${BACKUP_FOLDER}
fi
mv ${BACKUP_TAR} ${BACKUP_FOLDER}
