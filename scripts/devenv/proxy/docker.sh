# cat /etc/docker/daemon.json
# {
#   "proxies": {
#     "http-proxy": "http://192.168.50.50:7890",
#     "https-proxy": "http://192.168.50.50:7890",
#     "no-proxy": "*.test.example.com,.example.org,127.0.0.0/8"
#   }
# }
#
 # cat /etc/systemd/system/docker.service.d/http_proxy.conf
 # [Service]
 # Environment="HTTP_PROXY=http://
 # Environment="HTTPS_PROXY=http://
 # Environment="NO_PROXY=localhost,
 #
echo "Set proxy for docker"

if [[ -z "$PROXY_ADDRESS" ]]; then
  echo -n "PROXY_ADDRESS(127.0.0.1):"
  read PROXY_ADDRESS
  PROXY_ADDRESS=${PROXY_ADDRESS:-"127.0.0.1"}
fi
if [[ -z "$PROXY_HTTP_PORT" ]]; then
  echo -n "PROXY_HTTP_PORT(7890):"
  read PROXY_HTTP_PORT
  PROXY_HTTP_PORT=${PROXY_HTTP_PORT:-"7890"}
fi

# long string
CONTENT=$(cat <<EOF
[Service]
Environment="HTTP_PROXY=http://${PROXY_ADDRESS}:${PROXY_HTTP_PORT}"
Environment="HTTPS_PROXY=http://${PROXY_ADDRESS}:${PROXY_HTTP_PORT}"
Environment="NO_PROXY=localhost,127.0.0.1,.local,192.168.0.0/16,172.0.0.0/8,100.0.0.0/8,10.0.0.0/8"
EOF
)

sudo mkdir -p /etc/systemd/system/docker.service.d/
echo "$CONTENT" | sudo tee /etc/systemd/system/docker.service.d/http_proxy.conf
sudo systemctl daemon-reload
sudo systemctl restart docker
docker info
