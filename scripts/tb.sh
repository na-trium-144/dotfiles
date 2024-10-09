#!/usr/bin/env bash

_uname=$(uname) # Darwin, Linux, MINGW64_NT_*
if [[ $# > 0 ]]; then
	if [[ "$1" = "-" ]]; then
		input="$(cat)"
	else
		input="$@"
	fi
	[[ "${_uname}" = "Linux" ]] && echo -n "$input" | xclip -selection clipboard -i
	[[ "${_uname}" = "Darwin" ]] && echo -n "$input" | pbcopy
	[[ "${_uname}" = "MINGW64_NT" ]] && echo -n "$input" | sh -c "iconv -f utf-8 -t cp932 | clip"
	echo -n "$input" | tmux load-buffer -
else
	tmux save-buffer -
fi
