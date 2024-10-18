#!/usr/bin/env bash
if [[ -d $HOME/.brew/bin ]]; then
    for cmd in \
        brew \
        micro peco mc tmux fzf
    do
        alias $cmd="$HOME/.brew/bin/$cmd"
    done
    alias brew-activate='eval "$($HOME/.brew/bin/brew shellenv)"'
fi
