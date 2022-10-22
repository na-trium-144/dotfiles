#!/bin/sh
if type apt-get; then
	sudo apt-get install -y cargo micro peco mc tmux
elif type pacman; then
	sudo pacman -S cargo micro peco mc tmux
elif type brew; then
	brew install rust micro peco mc tmux
fi
cargo install fd-find git-delta hexyl
curl https://pyenv.run | bash
pip3 install pipenv
