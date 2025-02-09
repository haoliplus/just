#!/usr/bin/env sh

######################################################################
# @file        : inst_zsh
# @created     : Friday Mar 17, 2023 01:37:21 CST
#
# @description : 
######################################################################

LOCAL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

CMD="apt install"
if [[ ${UID} -ne 0 ]]; then
  CMD="sudo apt install"
fi

if [ -z "$(command -v zsh)" ]; then
  echo "Installing zsh..."
  ${CMD} zsh
fi

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone git@github.com:haoliplus/dotfiles.git ${HOME}/.dotfiles

echo "source ${HOME}/.dotfiles/config/zshrc.sh >> ${HOME}/.zshrc"
