#!/bin/bash

set -e

USERID=$(id -u)
COMPONENT=$COMPONENT
LOGFILE=/tmp/$COMPONENT.log


if [ $USERID -ne 0 ]; then
echo -e "\e[31m you must execute as root \e[0m"
exit 1
fi

stat() {
if [ $1 -eq 0 ]; then
echo -e "\e[32m success \e[0m"
else
echo -e "\e[31m Failure \e[0m"
fi

}

echo -n "installing nginx:"
yum install nginx -y  &>> $LOGFILE
stat $?


echo -n "downloading the component:"
curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"
stat $?

echo -n "cleaning up:"
rm -rf /usr/share/nginx/html/*  &>> $LOGFILE
stat $?

cd /usr/share/nginx/html
echo -n "unzipping the file"
unzip /tmp/$COMPONENT.zip  &>> $LOGFILE
stat $?

mv $COMPONENT-main/* .
mv static/* .
rm -rf $COMPONENT-main README.md

echo -n "configuring the reverse proxy:"
mv localhost.conf /etc/nginx/default.d/roboshop.conf
stat $?

echo -n "starting nginx:"
systemctl enable nginx  &>> $LOGFILE
systemctl start nginx  &>> $LOGFILE
stat $?