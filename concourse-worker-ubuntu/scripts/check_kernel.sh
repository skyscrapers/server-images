#!/bin/bash

# Fail the build if the instance didn't boot the newest installed kernel,
# which would mean the reboot after upgrade.sh didn't load it, or if that
# kernel is older than the minimum below.
#
# The minimum is the first ABI that carries the fix for the last kernel CVE
# we patched for, per jammy AWS kernel line (`uname -r` is
# <base>-<abi>-aws). Raise it on the next kernel CVE so the build can't
# ship a vulnerable kernel.
#
# CVE-2026-98432 (skyscrapers/platform#2853): linux-aws 5.15.0-1120.127,
# linux-aws-6.8 6.8.0-1069.74~22.04.1.
min_abi() {
  case "$1" in
    5.15.0) echo 1120 ;;
    6.8.0) echo 1069 ;;
  esac
}

set -euo pipefail

running="$(uname -r)"
newest="$(ls /boot/vmlinuz-* | sed 's|^/boot/vmlinuz-||' | sort -V | tail -n1)"

echo "Running kernel: ${running}"
echo "Newest installed kernel: ${newest}"

if [ "${running}" != "${newest}" ]; then
  echo "ERROR: running kernel ${running} is not the newest installed kernel ${newest}" >&2
  exit 1
fi

if [[ ! "${running}" =~ ^([0-9]+\.[0-9]+\.[0-9]+)-([0-9]+)-aws$ ]]; then
  echo "ERROR: unexpected kernel ${running}, expected <base>-<abi>-aws" >&2
  exit 1
fi
base="${BASH_REMATCH[1]}"
abi="${BASH_REMATCH[2]}"
min="$(min_abi "${base}")"

if [ -z "${min}" ]; then
  echo "ERROR: no minimum ABI known for kernel line ${base}, add it to min_abi" >&2
  exit 1
fi

if [ "${abi}" -lt "${min}" ]; then
  echo "ERROR: kernel ${running} is older than the minimum ${base}-${min}-aws" >&2
  exit 1
fi

echo "Kernel ${running} meets the minimum ${base}-${min}-aws"
