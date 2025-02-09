#!/bin/sh
#
# install.sh
#
# Distributed under terms of the MIT license.
#
set -x

rm -rf ${HOME}/.local/bin/nvim
rm -rf ${HOME}/.local/lib/nvim
rm -rf ${HOME}/.local/share/nvim

if [ "$(uname)" = "Darwin" ]; then
  TARGET="nvim-macos-arm64.tar.gz"
else
  TARGET="nvim-linux-x86_64.tar.gz"
fi

curl -L https://github.com/neovim/neovim/releases/latest/download/${TARGET} -o /tmp/${TARGET}


tar -C ${HOME}/.local --strip-components 1 -xzf /tmp/${TARGET}
