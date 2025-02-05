doc target='':
  [ -z {{target}} ] && ls {{justfile_directory()}}/docs | sed 's/.md//g' || glow "{{justfile_directory()}}/docs/{{target}}.md"

