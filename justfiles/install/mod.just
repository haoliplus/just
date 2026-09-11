# 列出安装模块的命令
help:
  just --list -f {{justfile_directory()}}/justfiles/install/mod.just
# 调用安装脚本安装 acme
[confirm]
acme:
  bash {{justfile_directory()}}/scripts/devenv/install/acme.sh
# 调用安装脚本安装 AList
[confirm]
alist:
  bash {{justfile_directory()}}/scripts/devenv/install/alist.sh
# 调用安装脚本安装 asdf 多语言版本管理器
[confirm]
asdf:
  bash {{justfile_directory()}}/scripts/devenv/install/asdf.sh
# 调用安装脚本安装 基础开发依赖
[confirm]
basic:
  bash {{justfile_directory()}}/scripts/devenv/install/basic.sh
# 调用安装脚本安装 Caddy Web 服务器
[confirm]
caddy:
  bash {{justfile_directory()}}/scripts/devenv/install/caddy.sh
# 调用安装脚本安装 Docker
[confirm]
docker:
  bash {{justfile_directory()}}/scripts/devenv/install/docker.sh
# 调用安装脚本安装 dufs 文件服务器
[confirm]
dufs:
  bash {{justfile_directory()}}/scripts/devenv/install/dufs.sh
# 调用安装脚本安装 fx JSON 处理工具
[confirm]
fx:
  bash {{justfile_directory()}}/scripts/devenv/install/fx.sh
# 调用安装脚本安装 Lua、LuaRocks 和 LuaSocket
[confirm]
luarock:
  bash {{justfile_directory()}}/scripts/devenv/install/luarock.sh
# 调用安装脚本安装 mise 开发工具版本管理器
[confirm]
mise:
  bash {{justfile_directory()}}/scripts/devenv/install/mise.sh
# 调用安装脚本安装 Neovim
[confirm]
nvim:
  bash {{justfile_directory()}}/scripts/devenv/install/nvim.sh
# 调用安装脚本安装 Python pip
[confirm]
pip:
  bash {{justfile_directory()}}/scripts/devenv/install/pip.sh
# 调用安装脚本安装 rclone 文件同步工具
[confirm]
rclone:
  bash {{justfile_directory()}}/scripts/devenv/install/rclone.sh
# 调用安装脚本安装 sing-box 代理工具
[confirm]
singbox:
  bash {{justfile_directory()}}/scripts/devenv/install/singbox.sh
# 调用安装脚本安装 Tailscale 组网工具
[confirm]
tailscale:
  bash {{justfile_directory()}}/scripts/devenv/install/tailscale.sh
# 调用安装脚本安装 Zsh、Oh My Zsh 及个人 dotfiles
[confirm]
zsh:
  bash {{justfile_directory()}}/scripts/devenv/install/zsh.sh
