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

curl -L https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz -o /tmp/nvim-linux-x86_64.tar.gz

tar -C ${HOME}/.local --strip-components 1 -xzf /tmp/nvim-linux-x86_64.tar.gz
