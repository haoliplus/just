# mod install '{{justfile_directory()}}/justfiles/'
import? 'justfiles/justfile'

help:
  just -g --list

install-global:
  mkdir -p ~/.config
  ln -sfn {{justfile_directory()}} ~/.config/just
  @echo "linked {{justfile_directory()}} -> ~/.config/just"

init-help:
  just -f {{justfile_directory()}}/justfiles/init/mod.just init-help

hybrid-cli name dir='':
  just -f {{justfile_directory()}}/justfiles/init/mod.just hybrid-cli {{name}} {{ if dir != '' { dir } else { name } }}

[positional-arguments]
generate *args:
  bash {{justfile_directory()}}/scripts/generate/run.sh "$@"

default:
  just --list
