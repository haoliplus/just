#!/bin/bash

COMMAND="mise"

if command -v ${COMMAND} &> /dev/null; then
  echo "${COMMAND} already installed."
  exit 0
else
  echo "Install ${COMMAND}"
fi
curl https://mise.run | sh
