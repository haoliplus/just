#! /bin/sh
#
# install.sh
#
# Distributed under terms of the MIT license.
#
set -ex

echo -n "SSH_ALIAS(root): "
read SSH_ALIAS
SSH_ALIAS=${SSH_ALIAS:-"guest"}
echo -n "PORT(22): "
read PORT
PORT=${PORT:-"22"}

sync_file() {
  rsync -e "ssh -p ${PORT}" --copy-links -aP ${HOME}/$1 ${SSH_ALIAS}:~/$(dirname $1)
}


cd ${HOME}
ssh ${SSH_ALIAS} -p ${PORT} "mkdir -p ~/.local/bin; mkdir -p ~/.local/lib; mkdir -p ~/.local/share;mkdir -p ~/.dotfiles;mkdir -p ~/.config"
sync_file .config/nvim
# sync_file .local/bin/nvim.bin
# sync_file .local/bin/nvim.appimage
sync_file .local/bin/node
sync_file .local/lib/nvim
sync_file .local/share/nvim

ssh ${SSH_ALIAS} -p ${PORT} 'echo "source ${HOME}/.config/nvim/tools/.custom_env.sh"  >> ${HOME}/.zshrc'
ssh ${SSH_ALIAS} -p ${PORT} 'echo "source ${HOME}/.config/nvim/tools/.custom_env.sh"  >> ${HOME}/.bashrc'


ssh ${SSH_ALIAS} -p ${PORT} '${HOME}/.local/bin/nvim.bin --version &> /dev/null && ln -sfn ${HOME}/.local/bin/nvim.bin ${HOME}/.local/bin/nvim || ln -s ${HOME}/.local/bin/nvim.appimage ${HOME}/.local/bin/nvim'
