#! /bin/sh
#
# install.sh
#
# Distributed under terms of the MIT license.
#
set -ex

sync_file() {
  docker exec  -u ${USER} -it ${CONTAINER} mkdir -p /home/${USER}/.cache/docker/$(dirname $1)/
  docker cp -L  $1 ${CONTAINER}:/home/${USER}/.cache/docker/$(dirname $1)/
}

docker exec -u ${USER} \
  -it ${CONTAINER} sudo apt update
docker exec -u ${USER} \
  -it ${CONTAINER} sudo apt install -y ninja-build gettext cmake unzip curl
docker exec -u ${USER} \
  -it ${CONTAINER} mkdir -p /home/${USER}/.cache/docker

cd ${HOME}
sync_file .dotfiles/nvim
sync_file .local/bin/nvim.bin
sync_file .local/bin/nvim.appimage
sync_file .local/bin/node
sync_file .local/lib/nvim
sync_file .local/share/nvim
sync_file .tmux.conf
sync_file .tmux.conf.local
