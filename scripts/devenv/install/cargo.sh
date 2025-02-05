#!/bin/bash

if [ -f ${HOME}/.cargo/bin/cargo ]; then
    echo "cargo already installed"
    exit 0
fi
curl https://sh.rustup.rs -sSf | sh
