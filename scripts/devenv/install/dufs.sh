#!/bin/bash
set -ex
# check is root
INSTALL_DIR="/usr/local"
if [ "$EUID" -ne 0 ]; then
  echo "Normal user, install to home directory"
  INSTALL_DIR="$HOME/.local"
  mkdir -p $INSTALL_DIR
fi

dufs version >/dev/null 2>&1 && echo "dufs ready installed." && exit 0

wget -qO- https://github.com/sigoden/dufs/releases/download/v0.42.0/dufs-v0.42.0-x86_64-unknown-linux-musl.tar.gz \
  | tar -xvz -C ${INSTALL_DIR}/bin dufs
