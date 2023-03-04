#!/bin/bash

set -e
COMPONENT=catalogue
APPUSER=roboshop
source components/common.sh

echo -n "32m downoading dependencies:"
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash -  &>> $LOGFILE
stat $?

echo -n "installing nodejs:"
yum install nodejs -y  &>> $LOGFILE
stat $?

id $APPUSER  &>> $LOGFILE
if [ $? -ne 0 ]; then
echo -n "adding user:"
useradd $APPUSER
stat $?
fi

echo -n "downloading compo:"
curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip" &>> $LOGFILE
stat $?

echo -n "switching and unzipping compo:"
cd /home/$APPUSER
unzip -o /tmp/$COMPONENT.zip  &>> $LOGFILE
stat $?

echo -n "performing cleanup:"
rm -rf $COMPONENT 
mv $COMPONENT-main $COMPONENT
cd /home/$APPUSER/$COMPONENT
stat $?

echo -n "installing npm:"
npm install  &>> $LOGFILE
stat $?

echo -n "changing permission to $APPUSER:"
chown -R $APPUSER:$APPUSER /home/roboshop/$COMPONENT
stat $?