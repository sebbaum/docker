#!/bin/bash

USER=$1
URL=$2
BACKUP_FOLDER=backups/
CONTENT_FOLDER=server_files
TIMESTAMP=`date "+%Y%m%d-%H%M"`
BACKUP_FILE=server-backups_${TIMESTAMP}.tar.gz

echo "Backing up server_files on ${URL}"
ssh -t ${USER}@${URL} "sudo tar cvfz ${BACKUP_FILE} ${CONTENT_FOLDER} && sudo chown sebbaum:sebbaum ${BACKUP_FILE}"
ssh -t ${USER}@${URL} "mv ${BACKUP_FILE} ${BACKUP_FOLDER}"
scp -r ${USER}@${URL}:/home/${USER}/${BACKUP_FOLDER}/${BACKUP_FILE} ./
exit 0
