import? 'justfiles/test.just'
import? 'justfiles/install.just'

help:
  just -g --list
default:
  just --list

link:
  echo "Add nvim"

[linux]
[confirm]
prepare:
  #!/usr/bin/env sh
  echo "Unix"
  # if alpine, elif debian/ubuntu
  if $(grep -q "alpine" /etc/os-release); then
    echo "Alpine"
    # apk update
    # apk upgrade
    # apk add git zsh curl
  elif $(grep -q "debian" /etc/os-release); then
    echo "Debian|Ubuntu"
    sudo apt install curl git
    sudo apt install build-essential libssl-dev zlib1g-dev \
    libbz2-dev libreadline-dev libsqlite3-dev curl \
    libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
    # apt update
    # apt upgrade -y
    # apt install -y git zsh curl
  fi

[macos]
[confirm]
prepare:
  echo "MacOS"
  # brew update
  # brew upgrade
  # brew install git zsh curl

inst_asdf:
  [ -d "${HOME}/.asdf" ] || git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
  echo 'source ${HOME}/.dotfiles/config/zshrc.sh' >> ${HOME}/.zshrc
  echo 'source ${HOME}/.asdf/asdf.sh' >> ${HOME}/.zshrc
  echo 'source ${HOME}/.asdf/completions/asdf.bash' >> ${HOME}/.zshrc
  echo 'source -q ${HOME}/.dotfiles/config/tmux.conf' >> ${HOME}/.tmux.conf

route:
  route add default gw 网关地址

