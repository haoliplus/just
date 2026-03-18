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
