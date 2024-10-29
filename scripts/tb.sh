#!/usr/bin/env bash

if [[ $# > 0 ]]; then
	if [[ "$1" = "-" ]]; then
		input="$(cat)"
	else
		input="$@"
	fi
	if [[ "${_uname}" = "Linux" ]]; then
		echo -n "$input" | xclip -selection clipboard -i
	elif [[ "${_uname}" = "Darwin" ]]; then
		echo -n "$input" | pbcopy
	elif [[ "${_uname}" = "MINGW64_NT" ]]; then
		echo -n "$input" | sh -c "iconv -f utf-8 -t cp932 | clip"
	else
		echo "_uname is not set"
	fi
	echo -n "$input" | tmux load-buffer -
else
	tmux save-buffer -
fi
