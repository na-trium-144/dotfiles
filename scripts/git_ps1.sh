#!/usr/bin/env bash
[[ -e /etc/bash_completion.d/git-prompt ]] && source /etc/bash_completion.d/git-prompt
[[ -e ~/.git-prompt.sh ]] && source ~/.git-prompt.sh

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM="verbose"

__git_ps1 | sed "s/(\\(.*\\))/(\\1 @$(git config user.name))/"
