#!/bin/bash

set -e

# Enable compression in logrotate
sudo sed -i 's/#compress/compress/g' /etc/logrotate.conf

# Install concourse
curl -s -L -f -o ./concourse.tgz https://github.com/concourse/concourse/releases/download/v${CONCOURSE_VERSION}/concourse-${CONCOURSE_VERSION}-linux-amd64.tgz
sudo tar -xzf ./concourse.tgz -C /usr/local

# Install kubectl
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-\$basearch
enabled=1
gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

sudo yum update -y
sudo yum install -y awscli jq btrfs-progs kubectl-${K8S_VERSION}.*
