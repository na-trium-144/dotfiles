#!/usr/bin/env bash
set -e
shopt -s expand_aliases
source $_chezmoi_root/scripts/brew_local_aliases.sh

# $1が空じゃなければrustのビルドをスキップ
# pip, cargo > apt, pacman, brew > install script

if type brew; then
	brew install micro peco mc tmux fzf
	if [[ ${_uname} = Darwin ]]; then
		brew install coreutils
	fi
	# exa
elif type apt-get; then
	type sudo && sudo=sudo
	$sudo apt-get update
	$sudo apt-get install -y git curl build-essential cmake
	$sudo apt-get install -y mc || true
	$sudo apt-get install -y tmux || true
	$sudo apt-get install -y peco || true
	$sudo apt-get install -y fzf || true
elif type pacman; then
	if [[ ${_uname} = MINGW64_NT ]]; then
		# windows
		type git || pacman -S --noconfirm git
		type mc || pacman -S --noconfirm mc
		type tmux || pacman -S --noconfirm tmux
		type winpty || pacman -S --noconfirm winpty
	else
		# arch? 最近動作確認してないので動くか知らない
		type hostname || sudo pacman -S inetutils
		type micro || sudo pacman -S micro
		type peco || sudo pacman -S peco
		type mc || sudo pacman -S mc
		type tmux || sudo pacman -S tmux
		type fzf || sudo pacman -S fzf
	fi
fi

if [ -z "$1" ]; then
	bash $(dirname $0)/cargo.sh
	bash $(dirname $0)/source_builds/doxygen.sh
	bash $(dirname $0)/source_builds/json-tui.sh
else
	echo "skip source_builds"
fi
bash $(dirname $0)/tpm.sh
