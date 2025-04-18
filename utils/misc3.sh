#!/usr/bin/env bash
set -e
shopt -s expand_aliases
source $(dirname $0)/../scripts/init_env.sh
source $_chezmoi_root/scripts/brew_local_aliases.sh
source $_chezmoi_root/scripts/load_nvm.sh
source $_chezmoi_root/scripts/load_pyenv.sh

# clangdはインストールしない
if type brew; then
	brew install cppcheck ruby shellcheck
elif type apt-get; then
	type sudo && sudo=sudo
	$sudo apt-get install -y cppcheck tidy ruby shellcheck
fi
pipx install black
pipx install cmakelint
pipx install clang-format
pipx install flake8
pipx install remarshal
pipx uninstall mypy || true
pipx uninstall pylint || true
pip install -U mypy pylint
# clang-tidy はarm64のlinuxでエラー
pipx upgrade-all

nvm use --lts
cd ~/.config/sublime-text/Packages/User/formatter.assets/javascript && npm install
