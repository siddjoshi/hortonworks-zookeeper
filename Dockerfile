FROM centos:7
#ENV    ZOOKEEPER_CONF_DIR=/usr/hdp/3.1.0.0-78/zookeeper/conf \
#        ZOOKEEPER_HOME=/usr/hdp/3.1.0.0-78/zookeeper \
ENV    ZOOKEEPER_LOG_DIR=/usr/hdp/3.1.0.0-78/zookeeper/logs \
       #ZOOKEEPER_PID_DIR=/var/run/zookeeper/zookeeper_server.pid \
       ZOOKEEPER_DATA_DIR=/etc/zookeeper/data \
       ZOOKEEPER_USER=zookeeper \
       ZOOKEEPER_GROUP=zookeeper \
       LOG_DIR=/usr/hdp/3.1.0.0-78/zookeeper/logs \
       ZK_USER=zookeeper \
       ZK_DATA_DIR=/etc/zookeeper/data \
       ZK_DATA_LOG_DIR=/etc/zookeeper/data \ 
       ZK_LOG_DIR=/usr/hdp/3.1.0.0-78/zookeeper/logs 
       ##JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-1.7.0.231-2.6.19.1.el7_6.x86_64
       #JAVA_HOME=/usr/java/default
      
RUN groupadd zookeeper; \
    useradd zookeeper -g zookeeper 

RUN mkdir -p ${ZOOKEEPER_LOG_DIR} ${ZOOKEEPER_PID_DIR} ${ZOOKEEPER_DATA_DIR}

###
RUN mkdir -p /logs; \
    mkdir -p $ZOOKEEPER_LOG_DIR; \
    chown -R $ZOOKEEPER_USER:$ZOOKEEPER_GROUP $ZOOKEEPER_LOG_DIR; \
    chmod -R 755 $ZOOKEEPER_LOG_DIR; \
    #mkdir -p $ZOOKEEPER_PID_DIR; \
    #chown -R $ZOOKEEPER_USER:$ZOOKEEPER_GROUP $ZOOKEEPER_PID_DIR; \
    #chmod -R 755 $ZOOKEEPER_PID_DIR; \
    mkdir -p $ZOOKEEPER_DATA_DIR; \
    chmod -R 755 $ZOOKEEPER_DATA_DIR; \
    chown -R $ZOOKEEPER_USER:$ZOOKEEPER_GROUP $ZOOKEEPER_DATA_DIR; \
    mkdir -p /var/lib/zookeeper; \
    chown -R $ZOOKEEPER_USER:$ZOOKEEPER_GROUP /var/lib/zookeeper; 
    #mkdir -p ${ZOOKEEPER_HOME}; \
    #chown -R $ZOOKEEPER_USER:$ZOOKEEPER_GROUP ${ZOOKEEPER_HOME}; \
    #chmod -R 755 ${ZOOKEEPER_HOME}

#    mkdir -p ${ZOOKEEPER_HOME}}; \
#    chown -R $ZOOKEEPER_USER:$ZOOKEEPER_GROUP $ZOOKEEPER_HOME
###


#RUN mkdir -p "$ZOO_DATA_LOG_DIR" "$ZOO_DATA_DIR" "$ZOO_CONF_DIR" "$ZOO_LOG_DIR"
RUN yum -y update &&  yum -y install wget gosu gnupg netcat; \
    yum-config-manager --add-repo http://public-repo-1.hortonworks.com/HDP/centos7/3.x/updates/3.1.0.0/hdp.repo

RUN yum install -y java-1.7.0-openjdk java-1.7.0-openjdk-devel

##RUN mkdir /usr/java && ln -s /usr/hdp/current/jvm/java-1.7.0-openjdk-1.7.0.51.x86_64 /usr/java/default 
RUN mkdir /usr/java && ln -s /usr/lib/jvm/java-1.7.0-openjdk-1.7.0.231-2.6.19.1.el7_6.x86_64 /usr/java/default 

RUN export JAVA_HOME=/usr/java/default && export PATH=$JAVA_HOME/bin:$PATH 

RUN yum -y install zookeeper-server
RUN usermod -s /bin/bash zookeeper
RUN mkdir -p /tmp/setup
COPY start-zookeeper.sh /tmp/setup/start-zookeeper.sh
#RUN chmod +x /usr/bin/start-zookeeper.sh
RUN chmod +x /tmp/setup/start-zookeeper.sh && chmod -R 777 /tmp/setup && chown -R $ZOOKEEPER_USER:$ZOOKEEPER_GROUP /tmp/setup
RUN chmod -R 777 /usr/hdp/3.1.0.0-78/zookeeper
RUN chmod 777 /usr/hdp/3.1.0.0-78/zookeeper/conf/zoo.cfg
##RUN chmod -R 777 ${ZOOKEEPER_HOME} && chown -R zookeeper:zookeeper ${ZOOKEEPER_HOME}
##COPY zoo.cfg /usr/hdp/current/zookeeper-server/conf/zoo.cfg
##COPY zookeeper-env.sh /usr/hdp/current/zookeeper-server/conf/zookeeper-env.sh


##COPY zookeeper-env.sh /usr/hdp/current/zookeeper-server/conf/zookeeper-env.sh


##RUN chmod +x /tmp/setup/start-zookeeper.sh
##RUN mkdir -p /zookeeper/conf && chown -R $ZOOKEEPER_USER:$ZOOKEEPER_GROUP /zookeeper/conf && chmod -R 755 /zookeeper/conf
##RUN mkdir -p /usr/hdp/3.1.0.0-78/zookeeper/conf && chmod -R 755 /usr/hdp/3.1.0.0-78/zookeeper/conf && chown -R $ZOOKEEPER_USER:$ZOOKEEPER_GROUP /usr/hdp/3.1.0.0-78/zookeeper/conf
##RUN ln -s /usr/hdp/current/zookeeper-server/bin/zkServer.sh /usr/bin/zkServer.sh


##RUN mkdir -p /usr/hdp/3.1.0.0-78/zookeeper/bin/bin
##RUN ln -s /usr/lib/jvm/java-1.7.0-openjdk-1.7.0.231-2.6.19.1.el7_6.x86_64/bin/java /usr/hdp/3.1.0.0-78/zookeeper/bin/bin/java


##USER zookeeper 
##RUN mkdir -p /var/lib/zookeeper
#RUN chmod 777 /zook && chmod 777 /etc/zookeeper/conf && chmod 777 /usr/hdp && chmod 777 /var/lib/zookeeper

##RUN chown zookeeper:zookeeper /var/lib/zookeeper && chmod -R 777  /var/lib/zookeeper
RUN chmod -R 777  /var/lib

EXPOSE 2181 2888 3888 8080
CMD ["/usr/hdp/current/zookeeper-server/bin/zkServer.sh", "start-foreground"]