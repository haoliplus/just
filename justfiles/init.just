
init target='':
  @[ -z {{target}} ] && just --justfile {{justfile()}} --list  || just --justfile {{justfile()}} {{target}}

python:
  echo "Python"
  # apt install python3 python3-pip
  # brew install python3
  # apk add python3 py3-pip

ssh:
  echo "SSH"
  # apt install openssh-client
  # brew install openssh
  # apk add openssh

git:
  echo "Git"
  # apt install git
  # brew install git
  # apk add git

