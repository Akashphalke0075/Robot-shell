#!/bin/bash

USER=$(id -u)
if [ $user -ne 0 ]; then
echo "you need to have sudo access"

yum install nginx -y

curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"

rm -rf /usr/share/nginx/html/*
cd /usr/share/nginx/html
unzip /tmp/frontend.zip
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
