#!/bin/bash

set -ex
if [[ "$OS" == 'Linux' ]]; then
  sudo apt install build-essential libssl-dev zlib1g-dev \
  libbz2-dev libreadline-dev libsqlite3-dev \
  libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
  sudo apt install curl git wget

elif [[ "$OS" == 'Darwin' ]]; then
  echo "down"
fi


