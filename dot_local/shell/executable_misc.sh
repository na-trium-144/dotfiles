#!/bin/sh
# pip, cargo > apt, pacman, brew > install script
if type apt-get; then
	sudo apt-get install -y cargo micro peco mc tmux fzf
elif type pacman; then
	sudo pacman -S cargo micro peco mc tmux fzf
elif type brew; then
	brew install rust micro peco mc tmux fzf
fi
cargo install fd-find git-delta hexyl
curl https://pyenv.run | bash
pip3 install pipenv
[ -d ~/.local/extrakto ] || git clone https://github.com/laktak/extrakto ~/.local/extrakto
