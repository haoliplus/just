# mod install '{{justfile_directory()}}/justfiles/'
import? 'justfiles/justfile'
import? 'justfiles/test.just'
import? 'justfiles/doc.just'

help:
  just -g --list
default:
  just --list

