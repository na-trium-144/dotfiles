#!/usr/bin/env bash
set -e

# $1が空じゃなければrustのビルドをスキップ
# pip, cargo > apt, pacman, brew > install script
if type apt-get; then
	type sudo && sudo=sudo
	$sudo apt-get update
	$sudo apt-get install -y micro peco mc tmux fzf git
elif type pacman; then
	if uname | grep MINGW64 >/dev/null; then
		# windows
		type git || pacman -S --noconfirm git
		type mc || pacman -S --noconfirm mc
		type tmux || pacman -S --noconfirm tmux
		type winpty || pacman -S --noconfirm winpty
		type fd || pacman -S --noconfirm mingw-w64-ucrt-x86_64-fd
	else
		# arch? 最近動作確認してないので動くか知らない
		type hostname || sudo pacman -S inetutils
		type micro || sudo pacman -S micro
		type peco || sudo pacman -S peco
		type mc || sudo pacman -S mc
		type tmux || sudo pacman -S tmux
		type fzf || sudo pacman -S fzf
	fi
elif type brew; then
	brew install micro peco mc tmux fzf coreutils
	# exa
fi
if [ -z "$1" ]; then
	bash $(dirname $0)/source_builds.sh
else
	echo "skip source_builds.sh"
fi
bash $(dirname $0)/tpm.sh
