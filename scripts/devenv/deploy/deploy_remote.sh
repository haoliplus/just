#! /bin/bash
set -ex

RUSER=$1
RHOST=$2
echo $RUSER@$RHOST

read -p "Are you sure to deploy on ${RUSER}@${RHOST}?(y/N) " -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo "Exit"
  exit 0
fi


SSH_ALIAS=${SSH_ALIAS:-"${RUSER}@${RHOST}"}
PORT=${PORT:-"22"}

sync_file() {
  rsync -e "ssh -p ${PORT}" --copy-links -aP $1 ${SSH_ALIAS}:~/$(dirname $1)
}


cd ${HOME}
ssh ${SSH_ALIAS} -p ${PORT} "mkdir -p ~/.local/bin; mkdir -p ~/.local/lib; mkdir -p ~/.local/share;mkdir -p ~/.dotfiles"
sync_file .dotfiles
sync_file .oh-my-zsh

sync_file .config/nvim
sync_file .local/bin/nvim.bin
sync_file .local/bin/nvim.appimage
sync_file .local/bin/node
sync_file .local/lib/nvim
sync_file .local/share/nvim

ssh ${SSH_ALIAS} -p ${PORT} 'echo "source ${HOME}/.dotfiles/nvim/tools/.custom_env.sh"  >> ${HOME}/.zshrc'
ssh ${SSH_ALIAS} -p ${PORT} 'echo "source ${HOME}/.dotfiles/nvim/tools/.custom_env.sh"  >> ${HOME}/.bashrc'
ssh ${SSH_ALIAS} -p ${PORT} '${HOME}/.local/bin/nvim.bin --version &> /dev/null && ln -sfn ${HOME}/.local/bin/nvim.bin ${HOME}/.local/bin/nvim || ln -s ${HOME}/.local/bin/nvim.appimage ${HOME}/.local/bin/nvim'
