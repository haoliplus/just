#!/usr/bin/env sh

######################################################################
# @file        : inst_pyenv
# @created     : Friday Mar 17, 2023 01:35:47 CST
#
# @description : 
######################################################################

LOCAL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
xz-utils tk-dev libffi-dev liblzma-dev  git libgdbm-dev
# python-openssl


curl https://pyenv.run | bash
