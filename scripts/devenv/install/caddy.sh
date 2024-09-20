#!/bin/bash

set -ex

# check is root
if [ "$EUID" -ne 0 ]; then
  echo "Root required, please run as root"
  exit 1
fi


caddy version >/dev/null 2>&1 && echo "caddy ready installed." && exit 0

# doc: https://caddyserver.com/docs/running#manual-installation
wget -qO- https://github.com/caddyserver/caddy/releases/download/v2.8.4/caddy_2.8.4_linux_amd64.tar.gz \
  | tar zxv -C /usr/local/bin caddy

groupadd --system caddy
useradd --system \
    --gid caddy \
    --create-home \
    --home-dir /var/lib/caddy \
    --shell /usr/sbin/nologin \
    --comment "Caddy web server" \
    caddy


systemctl daemon-reload
systemctl enable --now caddy

systemctl status caddy


CONTENT=$(cat <<EOF
mkdir /var/www/html
echo "hello world" > /var/www/html/index.html
journalctl -u caddy --no-pager | less +G
systemctl reload caddy
systemctl edit caddy
)


CONTENT=$(cat <<EOF
# caddy.service
#
# For using Caddy with a config file.
#
# Make sure the ExecStart and ExecReload commands are correct
# for your installation.
#
# See https://caddyserver.com/docs/install for instructions.
#
# WARNING: This service does not use the --resume flag, so if you
# use the API to make changes, they will be overwritten by the
# Caddyfile next time the service is restarted. If you intend to
# use Caddy's API to configure it, add the --resume flag to the
# `caddy run` command or use the caddy-api.service file instead.

[Unit]
Description=Caddy
Documentation=https://caddyserver.com/docs/
After=network.target network-online.target
Requires=network-online.target

[Service]
Type=notify
User=caddy
Group=caddy
ExecStart=/usr/bin/caddy run --environ --config /etc/caddy/Caddyfile
ExecReload=/usr/bin/caddy reload --config /etc/caddy/Caddyfile --force
TimeoutStopSec=5s
LimitNOFILE=1048576
PrivateTmp=true
ProtectSystem=full
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE

[Install]
WantedBy=multi-user.target
)
