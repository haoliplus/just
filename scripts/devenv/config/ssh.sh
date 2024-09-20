
CONTENT=$(cat <<EOF
ServerAliveInterval 60
ServerAliveCountMax 99999
ForwardAgent yes

Host *
  SendEnv LANG LC_*
  HashKnownHosts yes
  # GSSAPIAuthentication yes
  # GSSAPIDelegateCredentials no

Host PVEJUMP
  HostName 192.168.50.17
  User root
  Port 22
  ForwardX11 no
  AddKeysToAgent yes
  IdentityFile ~/.ssh/id_ed25519

Host example
  HostName 192.168.10.10
  User example
  Port 22
  ForwardX11 no
  AddKeysToAgent yes
  # reinstall netcat-openbsd
  # ProxyCommand nc -X connect -x 192.168.50.197:22 %h %p
  ProxyCommand ssh -W %h:%p PVEJUMP
  IdentityFile ~/.ssh/id_ed25519
)

echo "$CONTENT" | tee -a ~/.ssh/config
