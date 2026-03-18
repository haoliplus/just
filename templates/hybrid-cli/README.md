# __APP_NAME__

Hybrid CLI scaffold:

- `bin/__APP_NAME__` is the stable entrypoint
- Python logic lives under `src/__MODULE_NAME__/`
- `rust/` contains an optional native helper

## Requirements

- `bash`
- `uv` for Python execution
- optional: Rust toolchain for the helper binary

## Usage

```bash
./bin/__APP_NAME__ --help
just run -- --help
```

## Build helper

```bash
just build-helper
```
