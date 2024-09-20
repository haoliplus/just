#!/usr/bin/env sh

######################################################################
# @file        : inst_gvm
# @created     : Friday Mar 17, 2023 01:36:13 CST
#
# @description : 
######################################################################
set -ex

LOCAL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
sudo apt install bison
bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
source ${HOME}/.gvm/scripts/gvm
export GOROOT_BOOTSTRAP=$GOROOT
gvm install go1.4
gvm install go1.18
export GOROOT_BOOTSTRAP=$GOROOT
gvm install go1.20

