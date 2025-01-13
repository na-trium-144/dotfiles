#!/usr/bin/env bash
for git_prompt_path in /usr/share/git/completion/git-prompt.sh /etc/bash_completion.d/git-prompt ~/.git-prompt.sh; do
    if [[ -e $git_prompt_path ]]; then
        source $git_prompt_path
        break
    fi
done

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM="verbose"

__git_ps1 | sed "s/(\\(.*\\))/(\\1 @$(git config user.name))/"
