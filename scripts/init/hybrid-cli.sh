#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 || $# -gt 2 ]]; then
  echo "Usage: $0 <name> [target-dir]" >&2
  exit 1
fi

name="$1"
target_dir="${2:-$name}"
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "$script_dir/../.." && pwd)"
template_dir="$repo_root/templates/hybrid-cli"

if [[ ! "$name" =~ ^[a-zA-Z][a-zA-Z0-9_-]*$ ]]; then
  echo "Invalid name: $name" >&2
  echo "Use letters, digits, '_' or '-', and start with a letter." >&2
  exit 1
fi

module_name="${name//-/_}"

if [[ -e "$target_dir" ]]; then
  if [[ -n "$(find "$target_dir" -mindepth 1 -maxdepth 1 2>/dev/null)" ]]; then
    echo "Target directory is not empty: $target_dir" >&2
    exit 1
  fi
else
  mkdir -p "$target_dir"
fi

while IFS= read -r -d '' src; do
  rel="${src#$template_dir/}"
  dest_rel="${rel//__MODULE_NAME__/$module_name}"
  dest_rel="${dest_rel//__APP_NAME__/$name}"
  dest="$target_dir/$dest_rel"

  mkdir -p "$(dirname "$dest")"
  sed \
    -e "s/__APP_NAME__/$name/g" \
    -e "s/__MODULE_NAME__/$module_name/g" \
    "$src" > "$dest"

  if [[ "$dest" == */bin/* || "$dest" == *.sh ]]; then
    chmod +x "$dest"
  fi
done < <(find "$template_dir" -type f -print0)

echo "Created hybrid CLI scaffold at: $target_dir"
echo "Next steps:"
echo "  cd $target_dir"
echo "  just --list"
echo "  ./bin/$name --help"
