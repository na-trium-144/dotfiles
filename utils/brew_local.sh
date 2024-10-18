#!/usr/bin/env bash

git clone https://github.com/Homebrew/brew $HOME/.brew
eval "$($HOME/.brew/bin/brew shellenv)"
brew update --force
# chmod -R go-w "$(brew --prefix)/share/zsh"
