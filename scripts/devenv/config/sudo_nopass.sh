#!/bin/bash

sudo usermod -aG sudo $USER

echo "${USER}  ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/${USER}
