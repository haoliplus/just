#!/bin/bash

set -ex
CMD="apt install"
if [[ ${UID} -ne 0 ]]; then
  CMD="sudo apt install"
fi

if [[ "$(uname)" == 'Linux' ]]; then
  ${CMD} build-essential libssl-dev zlib1g-dev \
  libbz2-dev libreadline-dev libsqlite3-dev \
  libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
  ${CMD} curl git wget

elif [[ "$(uname)" == 'Darwin' ]]; then
  echo "down"
fi


