#!/bin/bash
set -e

# Download + install teleport
curl -L "https://get.gravitational.com/teleport-v$TELEPORT_VERSION-linux-amd64-bin.tar.gz" > /tmp/teleport.tar.gz
cd /tmp
sudo tar -xzf teleport.tar.gz
sudo /tmp/teleport/install
