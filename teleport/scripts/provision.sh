#!/bin/bash

set -e

# Install teleport
cd /tmp
curl -sL `echo $TELEPORT_DOWNLOAD_URL_FORMAT | sed -e "s/%version%/$TELEPORT_VERSION/g"` > teleport.tar.gz
sudo tar -xzf teleport.tar.gz
sudo ./teleport/install

# Install certbot
sudo add-apt-repository -y ppa:certbot/certbot
sudo apt-get update
sudo apt-get install -y certbot python-pip
sudo pip install certbot-dns-route53

# Apt upgrade
sudo apt-get upgrade -y
