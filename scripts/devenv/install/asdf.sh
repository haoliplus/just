#!/bin/bash
set -ex

git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0

echo "source ${HOME}/.asdf/asdf.sh" >> ~/.zshrc
echo "source ${HOME}/.asdf/completions/asdf.bash" >> ~/.zshrc

source ${HOME}/.asdf/asdf.sh

# asdf plugin add just
# asdf plugin add ag
# asdf plugin add fd
# asdf plugin add jq
# asdf plugin add fx
# asdf plugin add fzf
# asdf plugin add ansible

# asdf plugin add python
asdf plugin add python https://github.com/danhper/asdf-python.git
# asdf plugin add go
asdf plugin add golang https://github.com/asdf-community/asdf-golang.git
# asdf plugin add node.js
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git

asdf install golang 1.21.11
asdf install python 3.12.0
asdf install nodejs latest
