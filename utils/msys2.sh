#!/bin/sh
# pacman -S unzip <- chezmoi入れる前に必要
# set HOME=C:\Users\hoge <- msys2の起動時に必要
type git || pacman -S --noconfirm git
type mc || pacman -S --noconfirm mc
type tmux || pacman -S --noconfirm tmux
type fzf || pacman -S --noconfirm mingw-w64-ucrt-x86_64-fzf
type winpty || pacman -S --noconfirm winpty
type fd || pacman -S --noconfirm mingw-w64-ucrt-x86_64-fd
if type choco; then
	unset TEMP
	unset TMP
	type micro || choco install micro
	type peco || choco install peco
fi
if ! [ -d ~/.tmux/plugins/tpm ]; then
	mkdir -p ~/.tmux/plugins
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -o ~/.git-prompt.sh
