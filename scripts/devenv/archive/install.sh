#! /bin/sh
#
# install.sh
#
# Distributed under terms of the MIT license.
#
set -x

smv() {
  rm -rf "$2.old"
  mv "$2" "$2.old" >/dev/null 2>&1 || true
  mv "$1" "$2"
}
create_link() {
  rm -rf "$2.old"
  mv "$2" "$2.old" >/dev/null 2>&1 || true
  ln -s "$1" "$2" && return 0
}
export CURRENT_OS=$(uname)
export OS=$(uname)

if [[ "$OS" == 'Linux' ]]; then
  NVIM_NAME="nvim-linux64"
  # NVIM_NAME="nvim.appimage"
  NODE_NAME="linux-x64"
elif [[ "$OS" == 'Darwin' ]]; then
  NVIM_NAME="nvim-macos"
  NODE_NAME="darwin-arm64"
fi

TMP_DIR=$(mktemp -d)
NODE_VERSION="v16.13.1"
# NVIM_VERSION="v0.6.1"
# NVIM_VERSION>=v0.8.0 requires glibc
# NVIM_VERSION="stable"
DOTROOT=${DOTROOT:-"${HOME}/.dotfiles"}

if [[ -d "${DOTROOT}/nvim" ]] ; then
  VIM_CONFIG_DIR="${DOTROOT}/nvim"
  LOCAL_DIR="${HOME}/.local"
  NVIM_VERSION="v0.8.3"
else
  PERSISTENT_DIR="${HOME}/.cache"
  VIM_CONFIG_DIR="${PERSISTENT_DIR}/.nvim"
  LOCAL_DIR="${PERSISTENT_DIR}/.local"
  NVIM_VERSION="v0.7.2"
fi

SHARE_DIR="${LOCAL_DIR}/share"
BIN_DIR="${LOCAL_DIR}/bin"
LIB_DIR="${LOCAL_DIR}/lib"
OPT_DIR="${LOCAL_DIR}/opt"
INCLUDE_DIR="${LOCAL_DIR}/include"
CACHE_DIR="${LOCAL_DIR}/.cache"

NODE_DIR="node-${NODE_VERSION}-${NODE_NAME}"

NVIM_DOWNLOAD_URL="https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/${NVIM_NAME}.tar.gz"
NVIM_APPIMAGE_DOWNLOAD_URL="https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim.appimage"
PLUG_VIM_URL="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
# https://registry.npmmirror.com/-/binary/node/${NODE_VERSION}/node-${NODE_VERSION}-${NODE_NAME}.tar.xz
# https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-${NODE_NAME}.tar.xz
NODE_DOWNLOAD_URL="https://registry.npmmirror.com/-/binary/node/${NODE_VERSION}/${NODE_DIR}.tar.xz"
NVIM_CONFIG_URL="https://github.com/haoliplus/nvim-config/archive/refs/heads/master.zip"
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# curl https://pyenv.run | bash


if [[ ! -d "${DOTROOT}/nvim" ]] && [[ ! -d ${VIM_CONFIG_DIR} ]] ; then
  wget -c ${NVIM_CONFIG_URL}  -O ${TMP_DIR}/master.zip \
    && unzip ${TMP_DIR}/master.zip -d ${TMP_DIR} \
    && smv "${TMP_DIR}/nvim-config-master" "${VIM_CONFIG_DIR}"
fi

mkdir -p ${SHARE_DIR}
mkdir -p ${BIN_DIR}
mkdir -p ${LIB_DIR}
mkdir -p ${OPT_DIR}
mkdir -p ${INCLUDE_DIR}
mkdir -p ${CACHE_DIR}/temp_dirs/undodir


if [[ ! -f ${LOCAL_DIR}/bin/nvim ]]; then
  # curl -L ${NVIM_DOWNLOAD_URL} | tar -xz -C ${TMP_DIR} 
  wget -O ${LOCAL_DIR}/bin/nvim.appimage -c ${NVIM_APPIMAGE_DOWNLOAD_URL}
  chmod +x ${LOCAL_DIR}/bin/nvim.appimage

  wget -O - -c ${NVIM_DOWNLOAD_URL} | tar -xz -C ${TMP_DIR}
  smv ${TMP_DIR}/${NVIM_NAME}/bin/nvim ${LOCAL_DIR}/bin/nvim.bin
  smv ${TMP_DIR}/${NVIM_NAME}/lib/nvim ${LOCAL_DIR}/lib/nvim
  smv ${TMP_DIR}/${NVIM_NAME}/share/nvim ${LOCAL_DIR}/share/nvim
fi 

PLUG_FILE=${LOCAL_DIR}/share/nvim/runtime/autoload/plug.vim
mkdir -p $(dirname ${PLUG_FILE})
while [ ! -f ${PLUG_FILE} ]
do
  # curl -fLo  ${PLUG_FILE} --create-dirs ${PLUG_VIM_URL}
  wget -O ${PLUG_FILE} -c ${PLUG_VIM_URL}
done

if [[ ! -d ${LOCAL_DIR}/bin/node ]]; then
  # curl -L ${NODE_DOWNLOAD_URL} | tar -xJ -C ${TMP_DIR}
  curl -L ${NODE_DOWNLOAD_URL} | tar -xJ -C ${TMP_DIR}
  smv ${TMP_DIR}/${NODE_DIR} ${LOCAL_DIR}/opt/${NODE_DIR}
  create_link "${LOCAL_DIR}/opt/${NODE_DIR}/bin/node" "${LOCAL_DIR}/bin/node"
  create_link "${LOCAL_DIR}/opt/${NODE_DIR}/bin/npm" "${LOCAL_DIR}/bin/npm"
fi

create_link "${VIM_CONFIG_DIR}/resources/.tmux.conf" "${HOME}/.tmux.conf"
create_link "${VIM_CONFIG_DIR}/resources/.tmux.conf.local" "${HOME}/.tmux.conf.local"

create_link "${VIM_CONFIG_DIR}/resources/.flake8" "${HOME}/.flake8"
create_link "${VIM_CONFIG_DIR}/resources/pycodestyle" "${HOME}/.config/pycodestyle"
create_link "${VIM_CONFIG_DIR}/resources/yapf" "${HOME}/.config/yapf"
create_link "${VIM_CONFIG_DIR}/resources/clang-format" "${HOME}/.clang-format"

if [[ ! -d ${DOTROOT} ]]; then

read -r -d '' VAR <<EOF
LOCAL_DIR="${LOCAL_DIR}"
export VIM_CONFIG_DIR="${VIM_CONFIG_DIR}"
EOF

echo "${VAR}" >> ${HOME}/.zshrc
echo "${VAR}" >> ${HOME}/.bashrc

# The variable will not be replaced 
cat >> ${HOME}/.zshrc << 'endmsg'

export HISTFILE="${HOME}/.cache/.docker_zsh_history"
export PATH="${LOCAL_DIR}/bin:${PATH}"
export PATH="/usr/local/node/bin:${PATH}"
export VIM_RESOURCE_DIR=${VIM_RESOURCE_DIR:-"${LOCAL_DIR}/share/nvim"}

export VIMPLUGDIR="${VIM_RESOURCE_DIR}/plugged"
export VIMRUNTIME="${VIM_RESOURCE_DIR}/runtime"
export MYVIMRC=${MYVIMRC:-"${VIM_CONFIG_DIR}/init.vim"}
export VIMINIT='source $MYVIMRC'
export TERM="xterm-256color"
export LS_COLORS="rs=0:di=01;35:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:"\
"bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:"\
"ow=40;33;01:st=37;44:ex=01;32:*Makefile=20;33:"
alias vim='nvim'
alias vi='nvim'
alias ninstall='nvim +PlugInstall +qall'
ZSH_THEME="ys"
endmsg

# The variable will not be replaced 
cat >> ${HOME}/.bashrc << 'endmsgb'

export HISTFILE="${HOME}/.cache/.docker_bash_history"
export PATH="${LOCAL_DIR}/bin:${PATH}"
export PATH="/usr/local/node/bin:${PATH}"
export VIM_RESOURCE_DIR=${VIM_RESOURCE_DIR:-"${LOCAL_DIR}/share/nvim"}
export VIMPLUGDIR="${VIM_RESOURCE_DIR}/plugged"
export VIMRUNTIME="${VIM_RESOURCE_DIR}/runtime"
export MYVIMRC=${MYVIMRC:-"${VIM_CONFIG_DIR}/init.vim"}
export VIMINIT='source $MYVIMRC'
export TERM="xterm-256color"
export LS_COLORS="rs=0:di=01;35:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:"\
"bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:"\
"ow=40;33;01:st=37;44:ex=01;32:*Makefile=20;33:"
alias vim='nvim'
alias vi='nvim'
alias ninstall='nvim +PlugInstall +qall'
BASH_THEME="ys"
endmsgb

fi

