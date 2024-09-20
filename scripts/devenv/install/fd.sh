#!/bin/bash
set -ex
fd --version >/dev/null 2>&1 && echo "fd ready installed." && exit 0

# check is root
INSTALL_DIR="/usr/local"
if [ "$EUID" -ne 0 ]; then
  echo "Normal user, install to home directory"
  INSTALL_DIR="$HOME/.local"
  mkdir -p $INSTALL_DIR
fi


cd /tmp
wget -qO- https://github.com/sharkdp/fd/releases/download/v10.2.0/fd-v10.2.0-x86_64-unknown-linux-musl.tar.gz \
  | tar -xvz --wildcards --strip-components 1 -C ${INSTALL_DIR}/bin "*/fd"
