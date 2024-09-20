#!/usr/bin/env bash
set -e
# https://github.com/sharkdp/fd/releases
# pip install -i https://pypi.douban.com/simple "python-language-server[pycodestyle]" jsbeautifier
command_exists() {
	command -v "$@" >/dev/null 2>&1
}
DOTROOT="${DOTROOT:-${HOME}/.dotfiles}"

sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

mkdir -p ${HOME}/.local
mkdir -p ${HOME}/.config
mkdir -p ${HOME}/.cache

create_link() {
  rm -rf "$2.old"
  mv "$2" "$2.old" >/dev/null || true
  ln -s "$1" "$2" && return 0
}

create_link "${DOTROOT}/config/.zshrc" "${HOME}/.zshrc"

source ${DOTROOT}/nvim/tools/install.sh

arch_name="$(uname -m)"
if [ "${arch_name}" = "x86_64" ]; then
  echo ""
elif [ "${arch_name}" = "arm64" ]; then
  echo ""
else
  echo "Unknown architecture: ${arch_name}"
fi

sudo apt install -y silversearcher-ag fd-find

if ! command_exists python3; then
  echo "python3 is not installed"
fi
# source ${HOME}/.zshrc
