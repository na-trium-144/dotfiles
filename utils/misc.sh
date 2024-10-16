#!/usr/bin/env bash
set -e

# $1が空じゃなければrustのビルドをスキップ
# pip, cargo > apt, pacman, brew > install script
if type apt-get; then
	type sudo && sudo=sudo
	# sudoが使えるかチェック
	if [[ `$sudo id -u` = 0 ]]; then
		$sudo apt-get update
		$sudo apt-get install -y git curl build-essential cmake
		$sudo apt-get install -y mc || true
		$sudo apt-get install -y tmux || true
		$sudo apt-get install -y peco || true
		$sudo apt-get install -y fzf || true
	else
		echo "sudo unavailable, skipping apt installs"
	fi
elif type pacman; then
	if uname | grep MINGW64 >/dev/null; then
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
elif type brew; then
	brew install micro peco mc tmux fzf coreutils
	# exa
fi

if [ -z "$1" ]; then
	bash $(dirname $0)/cargo.sh
	bash $(dirname $0)/source_builds/doxygen.sh
	bash $(dirname $0)/source_builds/json-tui.sh
else
	echo "skip source_builds"
fi
bash $(dirname $0)/tpm.sh
