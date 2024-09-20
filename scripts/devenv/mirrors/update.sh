#!/bin/bash
# Replace software source by chinese source

# PIP
echo "Replace PIP source(Y/N)?"
read PIP
if [ $PIP == "Y" ]; then
    mkdir ~/.pip
    echo "[global]" > ~/.pip/pip.conf
    echo "index-url = https://pypi.tuna.tsinghua.edu.cn/simple" >> ~/.pip/pip.conf
    echo "Replace PIP source successfully!"
fi

## APT
echo "Replace APT source(Y/N)?"
read APT
if [ $APT == "Y" ]; then
  # Debian
  if [ -f /etc/debian_version ]; then
    sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
    sudo sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
    sudo sed -i 's/security.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
    sudo sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list
    sudo sed -i 's/security.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list
    sudo apt-get update
    echo "Replace APT source successfully!"
fi

## APK
echo "Replace APK source(Y/N)?"
read APK
if [ $APK == "Y" ]; then
    sudo cp /etc/apk/repositories /etc/apk/repositories.bak
    sudo sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories
    sudo apk update
    echo "Replace APK source successfully!"
fi
