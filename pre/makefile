install:
	mkdir -p ~/.local/bin
	curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | bash -s -- --to ~/.local/bin
	export PATH="$PATH:$HOME/bin"
	just --help
