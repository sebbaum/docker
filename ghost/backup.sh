#!/bin/bash

USER=$1
URL=$2
CONTENT_FOLDER=/home/${USER}/ghost-blog/content/
TIMESTAMP=`date "+%Y%m%d-%H%M"`
BACKUP_FILE=blog-sebbaum_${TIMESTAMP}.tar.gz

echo "Backuping ghost blog content folder..."
ssh -t ${USER}@${URL} "tar cvfz ${BACKUP_FILE} ${CONTENT_FOLDER}"
scp -r ${USER}@${URL}:/home/${USER}/${BACKUP_FILE} ./
exit 0