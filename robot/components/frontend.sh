#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]; then
echo -e "\e[31m you must run as root user \e[0m]"
fi
exit 1


yum install nginx -y

curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"




rm -rf /usr/share/nginx/html/*
cd /usr/share/nginx/html
unzip /tmp/frontend.zip
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf

systemctl enable nginx
systemctl start nginx