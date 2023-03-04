#!/bin/bash

set -e

COMPONENT=catalogue
APPUSER=roboshop
source components/common.sh

echo -n "\e[32m downoading dependencies \e[0m"
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash -  &>> $LOGFILE
stat $?

echo -n "\e[32m installing nodejs \e[0m"
yum install nodejs -y  &>> $LOGFILE
stat $?

echo -n "\e[32m adding user \e[0m"
useradd $APPUSER
stat $?

echo -n "\e[32m downloading compo \e[0m"
$ curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip" &>> $LOGFILE
stat $?

echo -n "\e[32m switching and unzipping compo \e[0m"
$ cd /home/$APPUSER
$ unzip -o /tmp/$COMPONENT.zip  &>> $LOGFILE
stat $?

echo -n "\e[32m renaming file \e[0m"
$ mv $COMPONENT-main $COMPONENT
$ cd /home/$APPUSER/$COMPONENT
stat $?

echo -n "\e[32m installing npm \e[0m"
$ npm install  &>> $LOGFILE
stat $?