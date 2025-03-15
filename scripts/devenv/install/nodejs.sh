#!/bin/bash
set -ex
INSTALL_DIR="/usr/local"
if [ "$EUID" -ne 0 ]; then
  echo "Normal user, install to home directory"
  INSTALL_DIR="$HOME/.local"
  mkdir -p $INSTALL_DIR
fi

node -v && echo "Already installed $(node -v)" && exit 0

rm -rf ${INSTALL_DIR}/lib/node_modules
rm -rf ${INSTALL_DIR}/include/node
rm -rf ${INSTALL_DIR}/bin/node
rm -rf ${INSTALL_DIR}/bin/npm
rm -rf ${INSTALL_DIR}/bin/npx
rm -rf ${INSTALL_DIR}/bin/corepack

wget -qO- https://nodejs.org/dist/v22.8.0/node-v22.8.0-linux-x64.tar.xz \
  | tar xvJ -C ${INSTALL_DIR} --strip-components=1
