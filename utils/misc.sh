#!/usr/bin/env bash
set -e
shopt -s expand_aliases
source $(dirname $0)/../scripts/init_env.sh
source $_chezmoi_root/scripts/brew_local_aliases.sh

# $1が空じゃなければrustのビルドをスキップ
# pip, cargo > apt, pacman, brew > install script

if type brew; then
	if [[ ${_uname} = Darwin ]]; then
		brew install micro mc tmux fzf
		brew install coreutils
	else
		brew install gcc || brew install gcc
		brew link -f binutils  # brewのgccを使う場合にはbrewのPATHを通した上でこれ
		brew install micro mc tmux fzf git curl
		# なんかいくつかrbファイルを手動でダウンロードしていじらなきゃいけなかったやつがある...
		# openssl@3, dbus → テスト削除
		# mc→ LDFLAGS=-m
		# krb5→ LDFLAGS=-lresolv

		# すくなくともtmuxはaliasではなくパス上にないとバグる https://github.com/tmux-plugins/tpm/issues/189
	    for cmd in micro mc tmux fzf git curl; do
	        if [[ -e "$HOME/.brew/bin/$cmd" ]]; then ln -sf $HOME/.brew/bin/$cmd $HOME/.local/bin/; fi
	    done
	fi
	# exa
elif type apt-get; then
	type sudo && sudo=sudo
	$sudo apt-get update
	$sudo apt-get install -y git curl build-essential cmake
	$sudo apt-get install -y micro || true
	$sudo apt-get install -y mc || true
	$sudo apt-get install -y tmux || true
	# $sudo apt-get install -y peco || true
	$sudo apt-get install -y fzf || true
elif type pacman; then
	if [[ ${_uname} = MINGW64_NT ]]; then
		# windows
		type git || pacman -S --noconfirm git
		type mc || pacman -S --noconfirm mc
		type tmux || pacman -S --noconfirm tmux
		type winpty || pacman -S --noconfirm winpty
		type pacboy || pacman -S --noconfirm pactoys
		if [[ $(which micro) != /usr/bin/micro ]]; then
			type micro && sudo choco uninstall micro
			pacboy -S --noconfirm micro:p
			# なんで/usr/binなんだろう?
		fi
		type fzf || pacboy -S --noconfirm fzf:p
		[[ $(which cmake) = /ucrt64/bin/cmake ]] || pacboy -S --noconfirm cmake:p
		[[ $(which ninja) = /ucrt64/bin/ninja ]] || pacboy -S --noconfirm ninja:p
		[[ $(which gcc) = /ucrt64/bin/gcc ]] || pacboy -S --noconfirm gcc:p
	else
		# arch
		type hostname || sudo pacman -S --noconfirm inetutils
		type git || sudo pacman -S --noconfirm git
		type curl || sudo pacman -S --noconfirm curl
		type micro || sudo pacman -S --noconfirm micro
		# type peco || sudo pacman -S --noconfirm peco
		type mc || sudo pacman -S --noconfirm mc
		type tmux || sudo pacman -S --noconfirm tmux
		type fzf || sudo pacman -S --noconfirm fzf
	fi
fi
