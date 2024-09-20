#!/bin/bash
set -ex
sudo -v ; curl https://rclone.org/install.sh | sudo bash

# rclone config password myremote fieldname mypassword
echo "rclone config password myremote fieldname mypassword"

FILE=/etc/rclone/rclone.conf
cat <<EOM >$FILE

[nasshare]
type = webdav
url = https://nas.example.com:56006
vendor = other
user = public
pass = e-j0i2pkt17zCY3QfenvJs
EOM
