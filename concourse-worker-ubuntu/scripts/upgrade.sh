#!/bin/bash

# Bring the source AMI fully up to date, kernel included, so the worker
# image gets security fixes as soon as Ubuntu publishes them instead of
# waiting for Canonical to republish its AMIs. The reboot that loads the
# new kernel is triggered by the next provisioner in aws.json.

set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

# cloud-init and unattended-upgrades run apt on first boot; wait for them
# so we don't race for the dpkg lock.
cloud-init status --wait >/dev/null || true
APT_OPTS=(-o DPkg::Lock::Timeout=600 -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confold)

sudo -E apt-get "${APT_OPTS[@]}" update
sudo -E apt-get "${APT_OPTS[@]}" -y dist-upgrade

echo "Running kernel: $(uname -r)"
echo "Installed kernels:"
ls /boot/vmlinuz-*
