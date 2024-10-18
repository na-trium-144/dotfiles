#!/usr/bin/env bash
if [[ -d $HOME/.brew/bin ]]; then
    for cmd in \
        brew \
        micro peco mc tmux fzf
    do
        [[ -e "$HOME/.brew/bin/$cmd" ]] && alias $cmd="$HOME/.brew/bin/$cmd"
    done
    alias brew-activate='eval "$($HOME/.brew/bin/brew shellenv)"'
fi
