#!/bin/bash

# Fail the build if the instance didn't boot the newest installed kernel,
# which would mean the reboot after upgrade.sh didn't load it.

set -euo pipefail

running="$(uname -r)"
newest="$(ls /boot/vmlinuz-* | sed 's|^/boot/vmlinuz-||' | sort -V | tail -n1)"

echo "Running kernel: ${running}"
echo "Newest installed kernel: ${newest}"

if [ "${running}" != "${newest}" ]; then
  echo "ERROR: running kernel ${running} is not the newest installed kernel ${newest}" >&2
  exit 1
fi
