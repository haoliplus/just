help:
  just --list -f {{justfile_directory()}}/install/mod.just
# install acme
[confirm]
acme:
  bash {{justfile_directory()}}/scripts/devenv/install/acme.sh
# install alist
[confirm]
alist:
  bash {{justfile_directory()}}/scripts/devenv/install/alist.sh
[confirm]
asdf:
  bash {{justfile_directory()}}/scripts/devenv/install/asdf.sh
[confirm]
basic:
  bash {{justfile_directory()}}/scripts/devenv/install/basic.sh
[confirm]
caddy:
  bash {{justfile_directory()}}/scripts/devenv/install/caddy.sh
[confirm]
cargo:
  bash {{justfile_directory()}}/scripts/devenv/install/cargo.shh
[confirm]
docker:
  bash {{justfile_directory()}}/scripts/devenv/install/docker.sh
[confirm]
dufs:
  bash {{justfile_directory()}}/scripts/devenv/install/dufs.sh
[confirm]
fd:
  bash {{justfile_directory()}}/scripts/devenv/install/fd.sh
[confirm]
fx:
  bash {{justfile_directory()}}/scripts/devenv/install/fx.sh
[confirm]
golang:
  bash {{justfile_directory()}}/scripts/devenv/install/golang.sh
[confirm]
just:
  bash {{justfile_directory()}}/scripts/devenv/install/just.sh
[confirm]
luarock:
  bash {{justfile_directory()}}/scripts/devenv/install/luarock.sh
[confirm]
mise:
  bash {{justfile_directory()}}/scripts/devenv/install/mise.sh
[confirm]
nodejs:
  bash {{justfile_directory()}}/scripts/devenv/install/nodejs.sh
[confirm]
nvim:
  bash {{justfile_directory()}}/scripts/devenv/install/nvim.sh
[confirm]
pip:
  bash {{justfile_directory()}}/scripts/devenv/install/pip.sh
[confirm]
rclone:
  bash {{justfile_directory()}}/scripts/devenv/install/rclone.sh
[confirm]
rg:
  bash {{justfile_directory()}}/scripts/devenv/install/rg.sh
[confirm]
singbox:
  bash {{justfile_directory()}}/scripts/devenv/install/singbox.sh
[confirm]
tailscale:
  bash {{justfile_directory()}}/scripts/devenv/install/tailscale.sh
[confirm]
uv:
  bash {{justfile_directory()}}/scripts/devenv/install/uv.sh
[confirm]
yt-dlp:
  bash {{justfile_directory()}}/scripts/devenv/install/yt-dlp.sh
# install zsh
[confirm]
zsh:
  bash {{justfile_directory()}}/scripts/devenv/install/zsh.sh
