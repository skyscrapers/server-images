#!/bin/bash
set -e

if $AWS_INSPECTOR_ENABLED; then
  # Download + install AWS Inspector
  curl -L https://inspector-agent.amazonaws.com/linux/latest/install -o /tmp/inspector_install
  cd /tmp
  sudo bash inspector_install
fi
