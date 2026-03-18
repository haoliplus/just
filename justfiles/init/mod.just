help:
  just --list -f {{justfile_directory()}}/init/mod.just

init-help:
  @echo "Available init commands:"
  @echo "  just -g hybrid-cli <name> [target-dir]"
  @echo "  Scaffold a hybrid CLI using bash + just + uv + optional rust helper."
# install oh-my-zsh and my .dotfiles
zsh:
  sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  git clone git@github.com:haoliplus/dotfiles.git ${HOME}/.dotfiles
  echo "source ${HOME}/.dotfiles/config/zshrc.sh" >> ${HOME}/.zshrc
nvim:
  git clone git@github.com:haoliplus/nvim-config.git ${HOME}/.config/nvim
tmux:
  git clone git@github.com:haoliplus/tmux.git ${HOME}/.config/tmux
  echo "source-file ${HOME}/.config/tmux/tmux.conf" >> ${HOME}/.tmux.conf
python:
  uv init --app demo

[no-cd]
golang:
  go mod init example.com/dev/demo
  go get -u github.com/spf13/cobra
  mkdir cmd
  cp {{justfile_directory()}}/templates/golang/demo/main.go ./
  cp {{justfile_directory()}}/templates/golang/demo/cmd/root.go ./cmd/

[no-cd]
hybrid-cli name dir='':
  bash {{justfile_directory()}}/../../scripts/init/hybrid-cli.sh {{name}} {{ if dir != '' { dir } else { name } }}
