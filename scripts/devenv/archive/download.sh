#! /bin/sh
#
# download.sh
#
# Distributed under terms of the MIT license.
#

set -x

mkdir -p ${HOME}/.local/share
mkdir -p ${HOME}/.local/bin
mkdir -p ${HOME}/.local/lib
mkdir -p ${HOME}/.local/opt
mkdir -p ${HOME}/.local/include

CACHE_DIR=$(mktemp -d)
NODE_VERSION="v16.13.1"
NVIM_VERSION="v0.6.1"

smv() {
  rm -rf "$2.old"
  mv "$2" "$2.old" >/dev/null
  mv "$1" "$2"
}

if [[ "$OS" == 'Linux' ]]; then
  curl -L https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim-linux64.tar.gz | tar -xz -C ${CACHE_DIR}
  smv ${CACHE_DIR}/nvim-linux64/bin/nvim ${HOME}/.local/bin/nvim
  smv ${CACHE_DIR}/nvim-linux64/lib/nvim ${HOME}/.local/lib/nvim
  smv ${CACHE_DIR}/nvim-linux64/share/nvim ${HOME}/.local/share/nvim
  sh -c 'curl -fLo ${HOME}/.local/share/nvim/runtime/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

  curl -L https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.xz | tar -xJ -C ${CACHE_DIR}
  smv ${CACHE_DIR}/node-${NODE_VERSION}-linux-x64 ${HOME}/.local/opt/node-${NODE_VERSION}-linux-x64
  rm -rf ${HOME}/.local/bin/node && ln -s ${HOME}/.local/opt/node-${NODE_VERSION}-linux-x64/bin/node ${HOME}/.local/bin/node
  rm -rf ${HOME}/.local/bin/npm && ln -s ${HOME}/.local/opt/node-${NODE_VERSION}-linux-x64/bin/npm ${HOME}/.local/bin/npm
  curl -L https://github.com/sharkdp/fd/releases/download/v8.3.1/fd-v8.3.1-x86_64-unknown-linux-gnu.tar.gz | tar -xz -C ${CACHE_DIR}
  smv ${CACHE_DIR}/fd-v8.3.1-x86_64-unknown-linux-gnu/fd ${HOME}/.local/bin/fd
  python3 -m pip install -i https://pypi.douban.com/simple pynvim
elif [[ "$OS" == 'Darwin' ]]; then
  curl -L https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim-macos.tar.gz | tar -xz -C ${CACHE_DIR}
  smv ${CACHE_DIR}/nvim-osx64/bin/nvim ${HOME}/.local/bin/nvim
  smv ${CACHE_DIR}/nvim-osx64/lib/nvim ${HOME}/.local/lib/nvim
  smv ${CACHE_DIR}/nvim-osx64/share/nvim ${HOME}/.local/share/nvim
  sh -c 'curl -fLo ${HOME}/.local/share/nvim/runtime/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

  curl -L https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-darwin-x64.tar.gz | tar -xz -C ${CACHE_DIR}
  smv ${CACHE_DIR}/node-${NODE_VERSION}-linux-x64 ${HOME}/.local/opt/node-${NODE_VERSION}-linux-x64
  rm -rf ${HOME}/.local/bin/node && ln -s ${HOME}/.local/opt/node-${NODE_VERSION}-darwin-x64/bin/node ${HOME}/.local/bin/node
  rm -rf ${HOME}/.local/bin/npm && ln -s ${HOME}/.local/opt/node-${NODE_VERSION}-darwin-x64/bin/npm ${HOME}/.local/bin/npm
fi
