#!/bin/bash

COMMAND="glow"

if command -v ${COMMAND} &> /dev/null; then
  echo "${COMMAND} already installed."
  exit 0
else
  echo "Install ${COMMAND}"
fi

go install github.com/charmbracelet/glow@latest
