#!/bin/bash
set -e

# Increase inotify max_user_instances and max_user_watches
# https://github.com/skyscrapers/engineering/issues/333
cat <<EOF | sudo tee -a /etc/sysctl.d/99-fs-inotify.conf
fs.inotify.max_user_instances=8192
fs.inotify.max_user_watches=524288
EOF
