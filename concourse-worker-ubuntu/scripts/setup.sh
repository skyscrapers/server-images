#!/bin/bash

set -e

# Enable compression in logrotate
sudo sed -i 's/#compress/compress/g' /etc/logrotate.conf

# Install kubectl
curl -fsSL https://pkgs.k8s.io/core:/stable:/v${K8S_VERSION}/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
sudo chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v${K8S_VERSION}/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo chmod 644 /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl
kubectl version --client

# Install packages
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg unzip jq btrfs-progs

# Install awscliv2
curl -sLfo ./awscliv2.zip https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip
unzip ./awscliv2.zip
sudo ./aws/install
aws --version
rm -rf ./aws ./awscliv2.zip

# Install CloudWatch Agent
curl -sLfo ./amazon-cloudwatch-agent.deb https://amazoncloudwatch-agent.s3.amazonaws.com/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
sudo dpkg -i -E ./amazon-cloudwatch-agent.deb
rm -f ./amazon-cloudwatch-agent.deb

# Install concourse
curl -sLfo ./concourse.tgz https://github.com/concourse/concourse/releases/download/v${CONCOURSE_VERSION}/concourse-${CONCOURSE_VERSION}-linux-amd64.tgz
sudo tar -xzf ./concourse.tgz -C /usr/local
rm -f ./concourse.tgz
