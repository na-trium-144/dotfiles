#!/bin/sh
set -e

# $1が空じゃなければrustのビルドをスキップ
# pip, cargo > apt, pacman, brew > install script
if type apt-get; then
	type sudo && sudo=sudo
	$sudo apt-get update
	$sudo apt-get install -y micro peco mc tmux fzf git
elif type pacman; then
	# pacmanはインストール済みのも再インストールしてしまうので、いちいち確認する
	type hostname || sudo pacman -S inetutils
	type micro || sudo pacman -S micro
	type peco || sudo pacman -S peco
	type mc || sudo pacman -S mc
	type tmux || sudo pacman -S tmux
	type fzf || sudo pacman -S fzf
elif type brew; then
	brew install micro peco mc tmux fzf coreutils
	# exa
fi
unset CC
unset CXX
if [ -z "$1" ]; then
	# aarch64のubuntuでcargoをaptで入れると古いので、公式のインストールスクリプトにした
	#  https://doc.rust-lang.org/cargo/getting-started/installation.html
	curl https://sh.rustup.rs -sSf | sh -s -- -y
	cargo install fd-find git-delta hexyl
else
	echo "skip rust installation"
fi
$(dirname $0)/tpm.sh
