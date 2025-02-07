# mod install '{{justfile_directory()}}/justfiles/'
import? 'justfiles/justfile'

help:
  just -g --list
default:
  just --list
