# 列出初始化模块的命令
help:
  just --list -f {{justfile_directory()}}/init/mod.just

# 显示混合 CLI 项目的初始化用法
init-help:
  @echo "Available init commands:"
  @echo "  just -g hybrid-cli <name> [target-dir]"
  @echo "  Scaffold a hybrid CLI using bash + just + uv + optional rust helper."
# 安装 Oh My Zsh，克隆个人 dotfiles 并追加 zsh 配置
zsh:
  sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  git clone git@github.com:haoliplus/dotfiles.git ${HOME}/.dotfiles
  echo "source ${HOME}/.dotfiles/config/zshrc.sh" >> ${HOME}/.zshrc
# 克隆个人 Neovim 配置到 ~/.config/nvim
nvim:
  git clone git@github.com:haoliplus/nvim-config.git ${HOME}/.config/nvim
# 克隆个人 tmux 配置并追加配置引用
tmux:
  git clone git@github.com:haoliplus/tmux.git ${HOME}/.config/tmux
  echo "source-file ${HOME}/.config/tmux/tmux.conf" >> ${HOME}/.tmux.conf
# 使用 uv 在 demo 目录初始化 Python 应用
python:
  uv init --app demo

# 在当前目录初始化 Go 模块，添加 Cobra 并复制示例代码
[no-cd]
golang:
  go mod init example.com/dev/demo
  go get -u github.com/spf13/cobra
  mkdir cmd
  cp {{justfile_directory()}}/templates/golang/demo/main.go ./
  cp {{justfile_directory()}}/templates/golang/demo/cmd/root.go ./cmd/

# 生成混合 CLI 项目；name 为项目名，dir 为目标目录（默认同名）
[no-cd]
hybrid-cli name dir='':
  bash {{justfile_directory()}}/../../scripts/init/hybrid-cli.sh {{name}} {{ if dir != '' { dir } else { name } }}
