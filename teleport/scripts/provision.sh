#!/bin/bash

set -e

cd /tmp

sudo yum update -y

# Install teleport
sudo curl -sL `echo $TELEPORT_DOWNLOAD_URL_FORMAT | sed -e "s/%version%/$TELEPORT_VERSION/g"` > teleport.rpm
sudo yum install -y teleport.rpm

# Download Cloudwatch logs agent and its dependencies. Setup is for the bootstrap phase
sudo yum install -y awslogs

# Add "customer" system user to allow unprivilaged access for ssh tunneling and similar purposes
sudo useradd customer
