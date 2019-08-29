FROM centos:7
ENV     ZOOKEEPER_CONF_DIR=/etc/zookeeper/conf \
       ZOOKEEPER_HOME=/usr/share/zookeeper/bin \
       ZOOKEEPER_LOG_DIR=/var/log/zookeeper \
       ZOOKEEPER_PID_DIR=/var/run/zookeeper
RUN mkdir -p /grid/hadoop/zookeeper/data
#RUN mkdir -p "$ZOO_DATA_LOG_DIR" "$ZOO_DATA_DIR" "$ZOO_CONF_DIR" "$ZOO_LOG_DIR"
RUN yum -y update &&  yum -y install wget gosu gnupg netcat; \
    yum-config-manager --add-repo http://public-repo-1.hortonworks.com/HDP/centos7/3.x/updates/3.1.0.0/hdp.repo
RUN yum -y install zookeeper && usermod -s /bin/bash zookeeper
RUN chmod 777 /grid/hadoop/zookeeper/data && chmod 777 /etc/zookeeper/conf
EXPOSE 2181 2888 3888 8080
CMD ["/usr/share/zookeeper/bin/zkServer.sh", "start-foreground"]