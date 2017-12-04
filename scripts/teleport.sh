#!/bin/bash
set -e

# Copy from temp location to definitive location (Packer can only copy to locations where `admin` has access)
sudo mv /tmp/teleport.yaml /etc/teleport.yaml
sudo mv /tmp/teleport.service /lib/systemd/system/teleport.service

# Download + install teleport
curl -L "https://github.com/gravitational/teleport/releases/download/v$TELEPORT_VERSION/teleport-v$TELEPORT_VERSION-linux-amd64-bin.tar.gz" > /tmp/teleport.tar.gz
cd /tmp
sudo tar -xzf teleport.tar.gz
sudo /tmp/teleport/install

# Reload systemd to activate teleport service
sudo systemctl daemon-reload
