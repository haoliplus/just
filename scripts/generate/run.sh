#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
python_script="$script_dir/openai_generate.py"

if [[ $# -lt 1 ]]; then
  echo "Usage:" >&2
  echo "  just generate img <width> <height> <prompt>" >&2
  echo "  just generate audio <voice> <text>" >&2
  exit 1
fi

command="$1"
shift

case "$command" in
  img)
    if [[ $# -lt 3 ]]; then
      echo "Usage: just generate img <width> <height> <prompt>" >&2
      exit 1
    fi
    width="$1"
    height="$2"
    shift 2
    uv run "$python_script" image --width "$width" --height "$height" --prompt "$*"
    ;;
  audio)
    if [[ $# -lt 2 ]]; then
      echo "Usage: just generate audio <voice> <text>" >&2
      exit 1
    fi
    voice="$1"
    shift
    uv run "$python_script" audio --voice "$voice" --text "$*"
    ;;
  help|-h|--help)
    echo "Usage:"
    echo "  just generate img <width> <height> <prompt>"
    echo "  just generate audio <voice> <text>"
    ;;
  *)
    echo "Unknown generate subcommand: $command" >&2
    exit 1
    ;;
esac
