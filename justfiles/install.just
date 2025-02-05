install target='':
  @[ -z {{target}} ] && ls {{justfile_directory()}}/scripts/devenv/install | sed 's/.sh//g' || bash "{{justfile_directory()}}/scripts/devenv/install/{{target}}.sh"
