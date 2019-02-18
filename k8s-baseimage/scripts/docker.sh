#!/bin/bash
set -e

# Install Docker

sudo apt-get update
sudo apt-get install -y bridge-utils libapparmor1 libltdl7 perl

curl -sLo /tmp/docker-ce.deb "http://download.docker.com/linux/debian/dists/stretch/pool/stable/amd64/docker-ce_${DOCKER_RELEASE}_amd64.deb"

echo "${DOCKER_CHECKSUM}  /tmp/docker-ce.deb" | sha256sum -c

sudo dpkg -i /tmp/docker-ce.deb

# Fix for CVE-2019-5736
# Download a patched runc binary for our Docker version (17.03.2)
# TODO: Remove once we upgrade to a patched Docker version (like 18.06.2)
if [[ -n "${RUNC_RELEASE}" ]]; then
  sudo curl -sLo /usr/bin/docker-runc "https://github.com/rancher/runc-cve/releases/download/${RUNC_RELEASE}"
  echo "${RUNC_CHECKSUM}  /usr/bin/docker-runc" | sha256sum -c
  sudo chmod +x /usr/bin/docker-runc
fi
