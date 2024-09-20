#!/usr/bin/env sh

######################################################################
# @file        : inst_zsh
# @created     : Friday Mar 17, 2023 01:37:21 CST
#
# @description : 
######################################################################

LOCAL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ "$EUID" -ne 0 ]; then
  echo "Root required, please run as root"
  exit 1
fi

sudo apt install zsh
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
