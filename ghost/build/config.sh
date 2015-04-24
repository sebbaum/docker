#!/bin/bash

CONTAINER=sb-ghost-blog
IMAGE=${CONTAINER}
PRODUCTION=0

if [ ${PRODUCTION} -eq 1 ]
then
  BUILD_FOLDER=~/ghost-blog/build
else
  BUILD_FOLDER=.
fi

BACKUP_FOLDER=~/ghost-blog/backup/
