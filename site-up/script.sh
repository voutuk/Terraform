#!/bin/bash
set -e

sudo apt update -y
sudo NEEDRESTART_MODE=a apt install apache2 python3-pip awscli -y
sudo rm /var/www/html/index.html
sudo aws s3 cp s3://voutuk/site/sign-in/ /var/www/html/ --recursive