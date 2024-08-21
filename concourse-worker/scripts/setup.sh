#!/bin/bash

set -e

# Enable compression in logrotate
sudo sed -i 's/#compress/compress/g' /etc/logrotate.conf

# Install concourse
curl -s -L -f -o ./concourse.tgz https://github.com/concourse/concourse/releases/download/v${CONCOURSE_VERSION}/concourse-${CONCOURSE_VERSION}-linux-amd64.tgz
sudo tar -xzf ./concourse.tgz -C /usr/local

# Setup kubectl repo
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/v${K8S_VERSION}/rpm/
enabled=1
gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable:/v${K8S_VERSION}/rpm/repodata/repomd.xml.key
EOF

# Install packages
sudo yum update -y
sudo yum install -y unzip jq btrfs-progs kubectl amazon-cloudwatch-agent
sudo yum remove -y awscli

# Install awscliv2
curl -s -L -f -o ./awscliv2.zip https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip
unzip ./awscliv2.zip
sudo ./aws/install
