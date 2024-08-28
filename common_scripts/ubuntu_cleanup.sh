#!/usr/bin/env bash

# Clean up yum caches to reduce the image size
sudo apt-get -y autoremove --purge
sudo apt-get -y clean
sudo apt-get -y autoclean

# Clean up files to reduce confusion during debug
sudo rm -rf \
    /etc/hostname \
    /etc/machine-id \
    /etc/ssh/ssh_host* \
    /home/ubuntu/.bash_history \
    /root/.bash_history \
    /home/ubuntu/.ssh/authorized_keys \
    /root/.ssh/authorized_keys \
    /var/lib/cloud/data \
    /var/lib/cloud/instance \
    /var/lib/cloud/instances \
    /var/lib/cloud/sem \
    /var/log/cloud-init-output.log \
    /var/log/cloud-init.log \
    /var/log/secure \
    /var/log/wtmp \
    /var/log/lastlog

sudo touch /etc/machine-id
sudo touch /var/log/lastlog
