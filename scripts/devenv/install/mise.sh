#!/bin/bash

if [ -d ${HOME}/.config/mise ]; then
  echo "mise is already installed"
  exit 0
fi
curl https://mise.run | sh
