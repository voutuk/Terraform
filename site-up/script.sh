# /bin/bash

sudo apt update -y
sudo NEEDRESTART_MODE=a apt install apache2 python3-pip awscli -y
sudo aws s3 cp s3://voutuk/site/ /var/www/html --recursive