help:
  just --list -f {{justfile_directory()}}/init/mod.just
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
