# CLI Toolkit

This repo is a `just`-based toolbox for bootstrapping and organizing command line utilities.

The direction is:

- `bash` for startup, portability, and glue logic
- `justfile` for task discovery and workflow entrypoints
- `python + uv` for medium-complexity business logic
- `rust` for places where a static binary or performance matters

## Install

```bash
wget -qO- https://just.systems/install.sh | bash -s -- --to /usr/local/bin
git clone git@github.com:haoliplus/just.git "${HOME}/.local/just"
just -f "${HOME}/.local/just/justfile" install-global
```

## Usage

常用工具由 `~/.config/mise` 管理：fd、Go、just、Node.js、ripgrep、Rust/Cargo、uv 和 yt-dlp 的旧安装命令及脚本已移除。Neovim 配置仓库由 mise bootstrap 克隆，`init nvim` 已移除；Neovim 程序安装入口 `install nvim` 仍保留。

just 保留日常工作命令，以及尚未由 mise 配置完整覆盖的服务器安装和配置初始化入口。空的 check、doc、config 模块已移除。使用 `just --list --list-submodules` 查看剩余命令；精简依据和执行记录见 [命令精简检查](docs/command-cleanup-review.md)。

```bash
just -g --list
just -g init-help
just -g generate img 1080 1200 "prompt for image generation"
just -g generate audio alloy "text to generate audio"
```

If the repo is not linked into `~/.config/just`, use:

```bash
just -f /Users/lihao/.local/just/justfile --list
```

## Hybrid CLI Template

This repo now includes a hybrid CLI scaffold aimed at reducing environment coupling:

- shell wrapper stays as the stable entrypoint
- Python is executed via `uv run` when available
- Rust helper is optional and can be compiled only when needed

Generate a new project:

```bash
just -g hybrid-cli mytool
just -g hybrid-cli mytool ./path/to/mytool
```

See [docs/cli-stack.md](/Users/lihao/.local/just/docs/cli-stack.md) for the design rules behind the template.

For AI generation commands, see [docs/generate.md](/Users/lihao/.config/just/docs/generate.md).
