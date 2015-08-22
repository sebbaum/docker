FROM ubuntu

MAINTAINER Sebastian Baum

# Install some tools
RUN apt-get install -y curl \
    && apt-get install -y wget \
    && apt-get autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    
# Install java 8 jdk
RUN (curl -L -k -b "oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u60-b27/server-jre-8u60-linux-x64.tar.gz | gunzip -c | tar x) \
    && mv /jdk1.8.0_60 /opt/jdk
ENV JAVA_HOME /opt/jdk
ENV JRE_HOME  $JAVA_HOME/jre
ENV PATH $PATH:$JAVA_HOME/bin

# Prepare and install wildfly

# add jboss user
RUN groupadd -r jboss -g 1000 && useradd -u 1000 -r -g jboss -m -d /opt/jboss -s /sbin/nologin -c "JBoss user" jboss

# Set the working directory to jboss' user home directory
WORKDIR /opt/jboss

# Set the WILDFLY_VERSION env variable
USER jboss
ENV WILDFLY_VERSION 9.0.1.Final
#USER jboss
RUN cd $HOME && wget http://download.jboss.org/wildfly/${WILDFLY_VERSION}/wildfly-${WILDFLY_VERSION}.tar.gz

# Specify the user which should be used to execute all commands below
# USER jboss
# Add the WildFly distribution to /opt, and make wildfly the owner of the extracted tar content
# Make sure the distribution is available from a well-known place
RUN cd $HOME
RUN tar -zxvf wildfly-${WILDFLY_VERSION}.tar.gz
RUN mv $HOME/wildfly-${WILDFLY_VERSION} $HOME/wildfly

# Set the JBOSS_HOME env variable
ENV JBOSS_HOME /opt/jboss/wildfly

# Expose the ports we're interested in
EXPOSE 8080 9990

ADD standalone.conf /opt/jboss/wildfly/bin/
ADD standalone.xml /opt/jboss/wildfly/standalone/configuration/

# Set the default command to run on boot
# This will boot WildFly in the standalone mode and bind to all interface
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0"]