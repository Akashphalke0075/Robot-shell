#!/bin/bash

set -e

USERID=$(id -u)

if [ $USERID -ne 0 ]; then
echo -e "\e[31m you must execute as root \e[0m"
exit 1
fi


echo "installing nginx"
yum install nginx -y


echo "downloading the component"
curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"

echo "cleaning up"
rm -rf /usr/share/nginx/html/*
cd /usr/share/nginx/html
unzip /tmp/frontend.zip
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf

echo "starting nginx"
systemctl enable nginx
systemctl start nginx