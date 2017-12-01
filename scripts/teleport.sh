#!/bin/bash
set -e

curl -L "https://github.com/gravitational/teleport/releases/download/v$TELEPORT_VERSION/teleport-v$TELEPORT_VERSION-linux-amd64-bin.tar.gz" > /tmp/vault.zip

cd /tmp
sudo tar -xzf teleport.tar.gz

sudo /tmp/teleport/install

sudo systemctl daemon-reload
