import? 'justfiles/test.just'
import? 'justfiles/install.just'
import? 'justfiles/init.just'

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

route:
  echo "route add default gw 网关地址"

