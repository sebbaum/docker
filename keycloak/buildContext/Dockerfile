FROM jboss/keycloak

### add custome configurations
ADD keycloak-server.json /opt/jboss/keycloak/standalone/configuration/
ADD standalone.xml /opt/jboss/keycloak/standalone/configuration/
#ADD themes/ /opt/jboss/keycloak/standalone/configuration/themes/

CMD ["/opt/jboss/keycloak/bin/standalone.sh", "-b", "0.0.0.0"]
