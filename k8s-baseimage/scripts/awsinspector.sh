#!/bin/bash
set -e

# Download + install AWS Inspector
curl -L https://inspector-agent.amazonaws.com/linux/latest/install -o /tmp/inspector_install
cd /tmp
sudo bash awsinspectorinstall
