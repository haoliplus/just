# 列出检查模块的命令
help:
  just --list -f {{justfile_directory()}}/justfiles/check/mod.just

# 输出添加 Neovim 的占位提示
link:
  echo "Add nvim"

# 输出添加默认路由的命令示例
route:
  echo "route add default gw 网关地址"

