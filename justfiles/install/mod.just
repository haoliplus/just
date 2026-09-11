# 列出安装模块的命令
help:
  just --list -f {{justfile_directory()}}/install/mod.just
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
# 调用安装脚本安装 Rust 工具链及 Cargo
[confirm]
cargo:
  bash {{justfile_directory()}}/scripts/devenv/install/cargo.sh
# 调用安装脚本安装 Docker
[confirm]
docker:
  bash {{justfile_directory()}}/scripts/devenv/install/docker.sh
# 调用安装脚本安装 dufs 文件服务器
[confirm]
dufs:
  bash {{justfile_directory()}}/scripts/devenv/install/dufs.sh
# 调用安装脚本安装 fd 文件查找工具
[confirm]
fd:
  bash {{justfile_directory()}}/scripts/devenv/install/fd.sh
# 调用安装脚本安装 fx JSON 处理工具
[confirm]
fx:
  bash {{justfile_directory()}}/scripts/devenv/install/fx.sh
# 调用安装脚本安装 Go 工具链
[confirm]
golang:
  bash {{justfile_directory()}}/scripts/devenv/install/golang.sh
# 调用安装脚本安装 just 命令运行器
[confirm]
just:
  bash {{justfile_directory()}}/scripts/devenv/install/just.sh
# 调用安装脚本安装 Lua、LuaRocks 和 LuaSocket
[confirm]
luarock:
  bash {{justfile_directory()}}/scripts/devenv/install/luarock.sh
# 调用安装脚本安装 mise 开发工具版本管理器
[confirm]
mise:
  bash {{justfile_directory()}}/scripts/devenv/install/mise.sh
# 调用安装脚本安装 Node.js
[confirm]
nodejs:
  bash {{justfile_directory()}}/scripts/devenv/install/nodejs.sh
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
# 调用安装脚本安装 ripgrep 文本搜索工具
[confirm]
rg:
  bash {{justfile_directory()}}/scripts/devenv/install/rg.sh
# 调用安装脚本安装 sing-box 代理工具
[confirm]
singbox:
  bash {{justfile_directory()}}/scripts/devenv/install/singbox.sh
# 调用安装脚本安装 Tailscale 组网工具
[confirm]
tailscale:
  bash {{justfile_directory()}}/scripts/devenv/install/tailscale.sh
# 调用安装脚本安装 uv Python 项目与包管理工具
[confirm]
uv:
  bash {{justfile_directory()}}/scripts/devenv/install/uv.sh
# 调用安装脚本安装 yt-dlp 音视频下载工具
[confirm]
yt-dlp:
  bash {{justfile_directory()}}/scripts/devenv/install/yt-dlp.sh
# 调用安装脚本安装 Zsh、Oh My Zsh 及个人 dotfiles
[confirm]
zsh:
  bash {{justfile_directory()}}/scripts/devenv/install/zsh.sh
