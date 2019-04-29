#!/bin/bash
set -e

sudo sh -c 'echo "install sctp /bin/false" > /etc/modprobe.d/sctp.conf'
