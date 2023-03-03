#!/bin/bash

# set -e

COMPONENT=catalogue
APPUSER=roboshop
source components/common.sh

echo -n "configuring repo:"
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash -  &>> $LOGFILE
stat $?
 
echo -n "installing nodejs:" 
yum install nodejs -y  &>> $LOGFILE
stat $?

id $APPUSER   &>> $LOGFILE
if [ $? -ne 0 ]; then
echo -n "creating app user:" 
useradd $APPUSER
stat $?
fi

echo -n "downloading component:" 
curl -s -L -o /tmp/catalogue.zip "https://github.com/stans-robot-project/catalogue/archive/main.zip"
stat $?

echo -n "moving component to dirctory:"
cd /home/$APPUSER
unzip -o /tmp/catalogue.zip  &>> $LOGFILE
rm -rf $COMPONENT
mv $COMPONENT-main $COMPONENT
stat $?

echo -n "installing nodejs dependencies:"
cd $COMPONENT
npm install &>> $LOGFILE
stat $?
