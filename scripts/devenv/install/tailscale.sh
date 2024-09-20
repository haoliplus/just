#!/bin/bash
set -ex
if [ "$EUID" -ne 0 ]; then
  echo "Root required, please run as root"
  exit 1
fi

curl -fsSL https://tailscale.com/install.sh | sh
