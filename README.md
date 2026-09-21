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

## AI Agent Profiles

配置模板和生成器位于 `~/.config/dotfiles/ai-agents/`；全局 just 只负责参数透传，不克隆仓库。将本目录迁入 dotfiles 并软链接到 `~/.config/just` 后，命令保持不变。

```bash
just -g generate-codex-profile fabu
just -g generate-codex-profile fabu --check
just -g generate-pi-profile lite
just -g generate-pi-profile lite --check
```

Codex `--check` 验证合并，不写入 config.toml。Pi `--check` 验证预设和本机配置，报告将更新的文件数，不生成文件、不安装依赖；必须显式指定 lite 或 full。需要指定 Full 检查时使用 `just -g generate-pi-profile full --check`。

其他参数也原样传递（包括带空格的路径）：

```bash
just -g generate-codex-profile fabu --target /tmp/codex-demo/config.toml
just -g generate-pi-profile lite --target /tmp/pi-demo --no-install
```

相对 `--target` 路径以运行 just 时的工作目录为基准。Codex 需要 uv；Pi 入口通过现有 mise 使用 Node LTS，避免误用系统 Node 20；其余依赖和备份规则遵循各生成器的 README。

指定目录生成配置供检查（相对当前工作目录，已存在则合并并备份改动）：

```bash
just -g generate-pi-profile lite --local ./.pi
just -g generate-codex-profile fabu --local ./.codex
# 上述命令均可追加 --check，只检查、不写入
```

Pi 的 `--local DIR` 生成配置与插件源码，不安装依赖或外部包。Codex 的 `--local DIR` 输出该目录下的 `config.toml`。
