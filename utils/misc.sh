#!/bin/sh
# pip, cargo > apt, pacman, brew > install script
if type apt-get; then
	sudo apt-get install -y micro peco mc tmux fzf
elif type pacman; then
	# pacmanはインストール済みのも再インストールしてしまうので、いちいち確認する
	type hostname || sudo pacman -S inetutils
	type micro || sudo pacman -S micro
	type peco || sudo pacman -S peco
	type mc || sudo pacman -S mc
	type tmux || sudo pacman -S tmux
	type fzf || sudo pacman -S fzf
elif type brew; then
	brew install micro peco mc tmux fzf
fi
# aarch64のubuntuでcargoをaptで入れると古いので、公式のインストールスクリプトにした
#  https://doc.rust-lang.org/cargo/getting-started/installation.html
type cargo || curl https://sh.rustup.rs -sSf | sh
cargo install fd-find git-delta hexyl
type pyenv || curl https://pyenv.run | bash
pip3 install pipenv
if ! [ -d ~/.tmux/plugins/tpm ]; then
	mkdir -p ~/.tmux/plugins
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
npm install -g git-user-switch
