#!/bin/bash

curl -LsSf https://astral.sh/uv/install.sh | sh
if [ -f $HOME/.zshrc ]; then
  echo "source $HOME/.cargo/env" >> $HOME/.zshrc
elif [ -f $HOME/.bashrc ]; then
  echo "source $HOME/.cargo/env" >> $HOME/.bashrc
fi
