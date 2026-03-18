# Hybrid CLI Stack

This repo is best suited to a layered CLI strategy rather than picking one language for everything.

## Goals

- Keep the default user path simple
- Minimize global runtime assumptions
- Let tools grow in complexity without a rewrite
- Preserve a stable shell-facing entrypoint

## Recommended Layering

### 1. Shell as the outer contract

Use `bash` or POSIX shell for:

- entrypoint scripts
- environment detection
- path resolution
- handing off to richer runtimes

Why:

- almost every machine already has a shell
- startup cost is low
- it is the best place to express fallback behavior

### 2. `just` as the operator interface

Use `just` for:

- discoverable commands
- development workflows
- build and release tasks
- common local automation

Do not put core application logic in `just`.

### 3. Python via `uv` for core logic

Use Python when:

- parsing gets non-trivial
- structured data is involved
- HTTP, JSON, YAML, TOML, or templates show up
- you want maintainable testable logic quickly

Prefer `uv run` over assuming a pre-created virtualenv.

### 4. Rust for hard dependencies or hot paths

Use Rust selectively:

- ship a single binary for a critical helper
- remove dependency on a slow or fragile shell pipeline
- handle performance-sensitive or system-level tasks

Keep Rust helpers narrow. The shell or Python layer should still define product behavior.

## Dependency Policy

Default path:

- shell required
- `just` recommended
- `uv` optional if Python logic is used
- Rust toolchain optional unless building the helper

Good pattern:

1. Shell wrapper checks whether a Rust helper exists
2. If not, it falls back to `uv run python ...`
3. If neither path is available, it prints a concrete install hint

That gives good out-of-box behavior without hard-coding the whole stack as mandatory.

## Repository Shape

Suggested structure:

```text
.
├── justfile
├── bin/
├── scripts/
├── pyproject.toml
├── src/<tool_name>/
├── rust/
└── tests/
```

Recommended ownership:

- `bin/`: stable executable entrypoints
- `scripts/`: shell helpers
- `src/`: Python application logic
- `rust/`: optional native helper

## Practical Rule

If a task can stay readable in shell, keep it in shell.
If shell starts fighting your data model, move it into Python.
If Python becomes the distribution problem or a bottleneck, isolate the critical part in Rust.
