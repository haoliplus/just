#!/bin/bash
set -ex

# check is root
INSTALL_DIR="/usr/local"
if [ "$EUID" -ne 0 ]; then
  echo "Normal user, install to home directory"
  INSTALL_DIR="$HOME/.local"
  mkdir -p $INSTALL_DIR
fi

alist version >/dev/null 2>&1 && echo "alist ready installed." && exit 0


wget -qO- https://github.com/alist-org/alist/releases/download/beta/alist-linux-amd64.tar.gz \
  | tar zxv -C ${INSTALL_DIR}/bin alist
