#!/usr/bin/bash
s='\033[0;107m  '
s=$s'\033[0;107;32m '
pushd `dirname "${BASH_SOURCE[0]}"` >/dev/null
s=$s`git log --oneline | wc -l`
if [ -e "$HOME/.utils" ]; then
    s=$s'\033[0;107m  '
    s=$s'\033[0;107;31m󰍁  '
    s=$s'\033[0;107;35m '
    cd "$HOME/.utils"
    s=$s`git log --oneline | wc -l`
fi
popd >/dev/null
s=$s'\033[K\033[0m'
echo -e $s
