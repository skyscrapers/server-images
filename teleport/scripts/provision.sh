#!/bin/bash

set -e

cd /tmp

sudo wget -r --no-parent -A 'epel-release-*.rpm' http://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/
sudo rpm -Uvh dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-*.rpm
sudo yum-config-manager --enable epel

sudo yum update -y

# Install teleport
sudo curl -sL `echo $TELEPORT_DOWNLOAD_URL_FORMAT | sed -e "s/%version%/$TELEPORT_VERSION/g"` > teleport.rpm
sudo yum install -y teleport.rpm

# Install certbot
sudo yum install -y certbot python2-certbot-dns-route53

# Download Cloudwatch logs agent and its dependencies. Setup is for the bootstrap phase
sudo yum install -y awslogs
