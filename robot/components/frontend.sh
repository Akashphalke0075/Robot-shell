#!/bin/bash

set -e

USERID=$(id -u)

if [ $USERID -ne 0 ]; then
echo -e "\e[31m you must run as root user \e[0m"
exit 1
fi


echo "installing nginx"
yum install nginx -y  &>> /tmp/frontend.log


echo "downloading component:"
curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"



echo "performing cleanup:"
rm -rf /usr/share/nginx/html/*


cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>> /tmp/frontend.log
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.md

echo "setting up proxy:"
mv localhost.conf /etc/nginx/default.d/roboshop.conf

echo "starting nginx:"
systemctl enable nginx &>> /tmp/frontend.log
systemctl start nginx &>> /tmp/frontend.log