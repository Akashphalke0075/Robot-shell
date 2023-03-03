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

echo -n "updating mongod cinfig:"
sudo sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
stat $?


echo -n "starting mongodb:" 
systemctl enable mongod  &>> $LOGFILE
systemctl start mongod  &>> $LOGFILE
stat $?


echo -n "downloading schema:" 
curl -s -L -o /tmp/mongodb.zip "https://github.com/stans-robot-project/mongodb/archive/main.zip"
stat $?


echo -n "injecting schema:" 
cd /tmp
unzip mongodb.zip  &>> $LOGFILE
cd mongodb-main
mongo < catalogue.js &>> $LOGFILE
mongo < users.js &>> $LOGFILE
stat $?