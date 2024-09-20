
 # 
# apt -o acquire::http::proxy="http://yourproxyaddress:proxyport"
 # sudo vi /etc/apt/apt.conf.d/proxy.conf
echo "Using apt -o acquire::http::proxy=\"http://yourproxyaddress:proxyport\""

echo "Exit(Y/n)?"
read REPLY
REPLY=${REPLY:-"Y"}

if [[ "$REPLY" == "Y" ]]; then
  exit 0
fi

echo "Set proxy for apt"

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
if [[ -z "$PROXY_SOCKS_PORT" ]]; then
  echo -n "PROXY_SOCKS_PORT(7891):"
  read PROXY_SOCKS_PORT
  PROXY_SOCKS_PORT=${PROXY_SOCKS_PORT:-"7891"}
fi

# long string
CONTENT=$(cat <<EOF
Acquire::http::Proxy "http://${PROXY_ADDRESS}:${PROXY_HTTP_PORT}/";
Acquire::https::Proxy "http://${PROXY_ADDRESS}:${PROXY_HTTP_PORT}/";
EOF
)

sudo mkdir -p /etc/apt/apt.conf.d
echo "$CONTENT" | sudo tee /etc/apt/apt.conf.d/proxy.conf
