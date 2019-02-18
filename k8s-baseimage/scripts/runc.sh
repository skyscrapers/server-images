#!/bin/bash
set -e

# Download the patched runc binary
# Fix for CVE-2019-5736 until we can safely upgrade to Docker 18.06.2
# (We currently run Docker 17.03.2)
# ref: https://github.com/rancher/runc-cve
curl -sLo /usr/bin/docker-runc.patched "${RUNC_RELEASE_URL}"
echo "${RUNC_RELEASE_CHECKSUM}  /usr/bin/docker-runc.patched" | sha256sum -c
chmod +x /usr/bin/docker-runc.patched
