#!/bin/bash
set -ex

INSTALL_DIR="/usr/local"
if [ "$EUID" -ne 0 ]; then
  echo "Normal user, install to home directory"
  INSTALL_DIR="$HOME/.local"
  mkdir -p $INSTALL_DIR
fi
wget -qO- https://github.com/SagerNet/sing-box/releases/download/v1.10.0-beta.5/sing-box-1.10.0-beta.5-linux-amd64.tar.gz \
  | tar xvz -C ${INSTALL_DIR}/bin sing-box

if [ "$EUID" -ne 0 ]; then
  exit 0
fi

mkdir -p /etc/sing-box
mkdir -p /var/lib/sing-box

FILE=/lib/systemd/system/sing-box.service
cat <<EOM >$FILE
[Unit]
Description=sing-box service
Documentation=https://sing-box.sagernet.org
After=network.target nss-lookup.target network-online.target

[Service]
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_SYS_PTRACE CAP_DAC_READ_SEARCH
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_SYS_PTRACE CAP_DAC_READ_SEARCH
ExecStart=/usr/local/bin/sing-box -D /var/lib/sing-box -C /etc/sing-box run
ExecReload=/bin/kill -HUP $MAINPID
Restart=on-failure
RestartSec=10s
LimitNOFILE=infinity

[Install]
WantedBy=multi-user.target
EOM

FILE=/etc/sing-box/config.json
cat <<EOM >$FILE
{
  "log": {
    "level": "info"
  },
  "inbounds": [
    {
      "type": "shadowsocks",
      "tag": "ss-in",
      "listen": "0.0.0.0",
      "listen_port": 8080,
      "sniff": true,
      "method": "aes-128-gcm",
      "password": "18868105619"
    },
    {
      "type": "http",
      "tag": "http-in",
      "listen": "0.0.0.0",
      "listen_port": 6152
    },
    {
      "type": "socks",
      "tag": "socks-in",
      "listen": "0.0.0.0",
      "listen_port": 6153
    },
    {
      "type": "mixed",
      "tag": "mixed-in",
      "listen": "0.0.0.0",
      "listen_port": 6154
    }
  ],
  "outbounds": [
    {
      "type": "direct",
      "tag": "direct"
    },
    {
      "type": "block",
      "tag": "block"
    },
    {
      "type": "dns",
      "tag": "dns-out"
    }
  ],
  "route": {
    "rules": [
    ],
    "final": "direct",
    "auto_detect_interface": true
  },
  "experimental": {
    "clash_api": {
      "external_controller": "0.0.0.0:9090",
      "external_ui": "/etc/mihomo/ui",
      "secret": "",
      "default_mode": "rule"
    }
  }
}
EOM


sudo systemctl enable sing-box
sudo systemctl start sing-box
