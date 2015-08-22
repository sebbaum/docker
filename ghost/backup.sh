#!/bin/bash

USER=$1
URL=$2
BACKUP_FOLDER=ghost-blog/backups/
CONTENT_FOLDER=ghost-blog/content/
TIMESTAMP=`date "+%Y%m%d-%H%M"`
BACKUP_FILE=blog-backup_${TIMESTAMP}.tar.gz

echo "Backuping ghost blog content folder..."
ssh -t ${USER}@${URL} "tar cvfz ${BACKUP_FILE} ${CONTENT_FOLDER}"
ssh -t ${USER}@${URL} "mv ${BACKUP_FILE} ${BACKUP_FOLDER}"
scp -r ${USER}@${URL}:/home/${USER}/${BACKUP_FOLDER}/${BACKUP_FILE} ./
exit 0