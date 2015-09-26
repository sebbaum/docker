#!/bin/bash

sleep 5
echo "Configuring keycloak, then restart..."
/opt/jboss/keycloak/bin/jboss-cli.sh --connect --file=keycloak/load-modules.cli