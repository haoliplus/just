install target='':
  @[ -z {{target}} ] && ls {{justfile_directory()}}/scripts/devenv/install | sed 's/.sh//g' || echo "{{target}}.sh"
