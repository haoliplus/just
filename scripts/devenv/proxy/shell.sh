set_proxy () {
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
  # export proxy_address=192.168.
  export proxy_address=${PROXY_ADDRESS}
  export HTTPS_PROXY=http://${proxy_address}:${PROXY_HTTP_PORT}
  export HTTP_PROXY=${HTTPS_PROXY}
  export https_proxy=${HTTPS_PROXY}
  export http_proxy=${HTTPS_PROXY}
  export socks_proxy=http://${proxy_address}:${PROXY_SOCKS_PORT}
  export SOCKS_PROXY=${socks_proxy}
  export no_proxy=*.local,192.168.0.0/16,10.0.0.0/8,100.0.0.0/8
  export NO_PROXY=${no_proxy}
}
