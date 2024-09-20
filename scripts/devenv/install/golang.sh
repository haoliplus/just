#!/bin/bash
set -ex
# check is root
INSTALL_DIR="/usr/local"
if [ "$EUID" -ne 0 ]; then
  echo "Normal user, install to home directory"
  INSTALL_DIR="$HOME/.local"
  mkdir -p $INSTALL_DIR
fi
sudo rm -rf ${INSTALL_DIR}/go
wget -qO- https://go.dev/dl/go1.23.0.linux-amd64.tar.gz \
  | sudo tar -C ${INSTALL_DIR} -xzv go
sudo ln -s ${INSTALL_DIR}/go/bin/go ${INSTALL_DIR}/bin/go

go version
