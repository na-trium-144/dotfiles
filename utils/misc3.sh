#!/bin/sh
if type apt-get; then
	sudo apt install cppcheck tidy
elif type brew; then
	brew install cppcheck
fi
pip3 install black pylint cmakelint clang-format mypy flake8
cd ~/.config/sublime-text/Packages/User/formatter.assets/javascript && npm install
