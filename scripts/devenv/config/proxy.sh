
function set_proxy() {

  export proxy_address=192.168.0.0
  export proxy_http_port=6152
  export proxy_socks_port=6153
  export proxy_skip_address=*.local,192.168.0.0/24
  export socks_proxy=http://${proxy_address}:${proxy_socks_port}
  export http_proxy=http://${proxy_address}:${proxy_http_port}

  export https_proxy=${http_proxy}
  export HTTPS_PROXY=${http_proxy}
  export HTTP_PROXY=${http_proxy}
  export SOCKS_PROXY=${socks_proxy}
  export no_proxy=${proxy_skip_address}
  export NO_PROXY=${proxy_skip_address}
  alias apt='apt -o Acquire::http::Proxy=${http_proxy} -o Acquire::https::Proxy=${https_proxy}'
}

function unset_proxy() {
  unset http_proxy
  unset socks_proxy
  unset no_proxy

  unset https_proxy
  unset HTTP_PROXY
  unset HTTPS_PROXY
  unset SOCKS_PROXY
  unset NO_PROXY
  alias apt='apt'
}
