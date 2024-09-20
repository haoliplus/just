#!/bin/bash
set -ex
INSTALL_DIR="/usr/local"
if [ "$EUID" -ne 0 ]; then
  echo "Normal user, install to home directory"
  INSTALL_DIR="$HOME/.local"
  mkdir -p $INSTALL_DIR
fi

wget -c https://github.com/antonmedv/fx/releases/download/35.0.0/fx_linux_amd64 -O ${INSTALL_DIR}/bin/fx
chmod +x ${INSTALL_DIR}/bin/fx

# wget -qO- https://github.com/casey/just/releases/download/1.34.0/just-1.34.0-x86_64-unknown-linux-musl.tar.gz  | tar xvz -C /tmp
#
# cp /tmp/just ${HOME}/.local/bin/just
