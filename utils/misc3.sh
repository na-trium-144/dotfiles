#!/usr/bin/env bash
set -e

# clangdはインストールしない
if type apt-get; then
	type sudo && sudo=sudo
	$sudo apt-get install -y cppcheck tidy ruby shellcheck
elif type brew; then
	brew install cppcheck ruby shellcheck
fi
pipx install black pylint cmakelint clang-format clang-tidy mypy flake8

[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh" # This loads nvm
nvm use --lts
cd ~/.config/sublime-text/Packages/User/formatter.assets/javascript && npm install
