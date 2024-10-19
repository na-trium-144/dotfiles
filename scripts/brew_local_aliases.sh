#!/usr/bin/env bash
if [[ -d $HOME/.brew/bin ]]; then
	alias brew="$HOME/.brew/bin/brew"
    alias brew-activate='eval "$($HOME/.brew/bin/brew shellenv)"'
fi
