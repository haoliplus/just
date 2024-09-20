#!/bin/bash
set -ex
INSTALL_DIR="/usr/local"
if [ "$EUID" -ne 0 ]; then
  echo "Normal user, install to home directory"
  INSTALL_DIR="$HOME/.local"
  mkdir -p $INSTALL_DIR
fi

if command -v just &> /dev/null; then
  echo "just already installed."
  exit 1
else
  echo "Install just"
fi

# if already installed just
just --version && echo "just is already installed" && exit 0


# In case
wget https://alist.aidoki.cn/d/public/bin/just -O ${INSTALL_DIR}/bin/just

echo "Downloading latest just? (y/n)"
read -r ans
if [ "$ans" != "y" ]; then
  echo "Skipping download"
  exit 0
else
  # create ~/bin
  JUST_VERSION=1.34.0
  JUST_FNAME=just-${JUST_VERSION}-x86_64-unknown-linux-musl
  wget -qO- https://github.com/casey/just/releases/download/${JUST_VERSION}/${JUST_FNAME}.tar.gz  \
    | tar xvz -C ${INSTALL_DIR}/bin just || echo "Failed to download latest just"

  wget https://alist.aidoki.cn/d/public/s/justfile.just -O ${HOME}/.justfile
fi

# just should now be executable
just --version
