#!/bin/bash

USER=$1
URL=sebbaum.de

scp -r deployment/ /home/${USER}/ghost/build/
ssh -t ${USER}@${URL} "cd /home/${USER}/ghost/build/ && ./build.sh"

exit 0
