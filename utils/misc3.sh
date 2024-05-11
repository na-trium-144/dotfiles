#!/bin/sh
# clangdはインストールしない
if type apt-get; then
	sudo apt-get install -y cppcheck tidy ruby
elif type brew; then
	brew install cppcheck ruby
fi
pip3 install black pylint cmakelint clang-format mypy flake8
cd ~/.config/sublime-text/Packages/User/formatter.assets/javascript && npm install
