#!/bin/bash

set -e

COMPONENT=mongodb

source components/common.sh

echo -n "configuring repo:"
curl -s -o /etc/yum.repos.d/${COMPONENT}.repo https://raw.githubusercontent.com/stans-robot-project/${COMPONENT}/main/mongo.repo
stat $?

echo -n "installing ${COMPONENT}:"
yum install -y mongodb-org  &>> $LOGFILE
stat $?




# systemctl enable mongod
# systemctl start mongod




# curl -s -L -o /tmp/mongodb.zip "https://github.com/stans-robot-project/mongodb/archive/main.zip"

# cd /tmp
# unzip mongodb.zip
# cd mongodb-main
# mongo < catalogue.js
# mongo < users.js