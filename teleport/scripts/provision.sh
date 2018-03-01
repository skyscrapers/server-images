#!/bin/bash

set -e

# Apt upgrade
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get -q -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade

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

# Download Cloudwatch logs agent and its dependencies. Setup is for the bootstrap phase
cd /root
curl https://s3.amazonaws.com/aws-cloudwatch/downloads/latest/awslogs-agent-setup.py -O
curl https://s3.amazonaws.com/aws-cloudwatch/downloads/latest/AgentDependencies.tar.gz -O

# Cleanup
sudo apt-get -y autoremove
