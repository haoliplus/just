#!/bin/bash
set -ex
INSTALL_DIR="/usr/local"
if [ "$EUID" -ne 0 ]; then
  echo "Normal user, install to home directory"
  INSTALL_DIR="$HOME/.local"
  mkdir -p $INSTALL_DIR
fi

VERSION=14.1.0
wget -qO- https://github.com/BurntSushi/ripgrep/releases/download/${VERSION}/ripgrep-${VERSION}-x86_64-unknown-linux-musl.tar.gz \
  | tar -xvz --wildcards --strip-components 1 -C ${INSTALL_DIR}/bin "*/rg"
