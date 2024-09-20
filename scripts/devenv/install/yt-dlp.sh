#!/bin/bash
set -ex
# check is root
INSTALL_DIR="/usr/local"
if [ "$EUID" -ne 0 ]; then
  echo "Normal user, install to home directory"
  INSTALL_DIR="$HOME/.local"
  mkdir -p $INSTALL_DIR
fi

sudo wget -C https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp_linux \
  -O ${INSTALL_DIR}/bin/yt-dlp
