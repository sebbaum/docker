# Run servers

## Nexus
```bash
docker run -d \
 --name sb-nexus \
 --restart=always \
 -p 7880:8081 \
 -v /home/sebbaum/server_files/sonatype/:/opt/sonatype/ \
 sonatype/nexus
```

## Jenkins
```bash
docker run -itd \
 --restart=always \
 --name sb-jenkins \
 -p 50080:8080 \
 -v /home/sebbaum/server_files/jenkins_files:/var/jenkins_home \
 sebbaum/jenkins:latest
```

## Sonarqube
### Mysql
```bash
docker run --restart=always \
 --name mysql-sonar \
 -p 63306:3306 \
 -v /home/sebbaum/server_files/mysql_sonar/:/var/lib/mysql \
 -e MYSQL_ROOT_PASSWORD=root \
 -d \
 mysql:5.5.45
```

### Sonarqube server
```bash
docker run -d \
 --name sb-sonarqube \
 --link mysql-sonar:db \
 --restart=always \
 -v /home/sebbaum/server_files/sonarqube:/opt/sonarqube \
 -p 60080:9000 \
 -e SONARQUBE_JDBC_USERNAME=sonar \
 -e SONARQUBE_JDBC_PASSWORD=sonar \
 -e SONARQUBE_JDBC_URL="jdbc:mysql://10.0.0.1:63306/sonar?useUnicode=true&characterEncoding=utf8&rewriteBatchedStatements=true&useConfigs=maxPerformance" \
 sonarqube:5.1.1
```
