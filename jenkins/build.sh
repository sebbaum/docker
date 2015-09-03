#!/bin/bash

# Jenkins dir on host is used to persist jenkins config files that are used in docker.
# A corresponding volume in docker does exists
JENKINS_DIR_ON_HOST=~/.jenkins_files

mkdir ${JENKINS_DIR_ON_HOST}
chown $USER:$USER ${JENKINS_DIR_ON_HOST}
sudo docker build --tag=sebbaum/jenkins .

sudo docker kill jenkins
sudo docker rm jenkins
echo "docker run -itd --name jenkins -p 81:8080 -v ${JENKINS_DIR_ON_HOST}:/var/jenkins_home sebbaum/jenkins"
sudo docker run -itd --name jenkins -p 81:8080 -v ${JENKINS_DIR_ON_HOST}:/var/jenkins_home sebbaum/jenkins