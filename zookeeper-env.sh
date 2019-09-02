# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
export JAVA_HOME=${JAVA_HOME}
export ZOO_LOG_DIR=${LOG_DIR}
export ZOOKEEPER_HOME=/usr/hdp/current/zookeeper-server
export ZOOKEEPER_LOG_DIR=/usr/hdp/3.1.0.0-78/zookeeper/logs
export ZOOKEEPER_PID_DIR=/var/run/zookeeper/zookeeper_server.pid
export SERVER_JVMFLAGS=-Xmx1024m
export JAVA=$JAVA_HOME/bin/java
CLASSPATH=$CLASSPATH:$ZOOKEEPER_HOME/*