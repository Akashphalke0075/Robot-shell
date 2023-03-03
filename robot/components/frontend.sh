#!/bin/bash

set -e

USERID=$(id -u)

if [ $USERID -ne 0 ]; then
echo -e "\e[31m you must execute as root \e[0m"
exit 1
fi


echo -n "installing nginx"
yum install nginx -y  &>> /tmp/frontend.log
if [ $? -eq 0 ]; then
echo -e "\e[32m success \e[0m"
else
echo -e "\e[31m Failure \e[0m"
fi

echo -n "downloading the component"
curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"
if [ $? -eq 0 ]; then
echo -e "\e[32m success \e[0m"
else
echo -e "\e[31m Failure \e[0m"
fi

echo -n "cleaning up"
rm -rf /usr/share/nginx/html/*  &>> /tmp/frontend.log
cd /usr/share/nginx/html
unzip /tmp/frontend.zip  &>> /tmp/frontend.log
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.md
if [ $? -eq 0 ]; then
echo -e "\e[32m success \e[0m"
else
echo -e "\e[31m Failure \e[0m"
fi

echo "setting up proxy"
mv localhost.conf /etc/nginx/default.d/roboshop.conf
if [ $? -eq 0 ]; then
echo -e "\e[32m success \e[0m"
else
echo -e "\e[31m Failure \e[0m"
fi

echo "starting nginx"
systemctl enable nginx  &>> /tmp/frontend.log
systemctl start nginx  &>> /tmp/frontend.log
if [ $? -eq 0 ]; then
echo -e "\e[32m success \e[0m"
else
echo -e "\e[31m Failure \e[0m"
fi