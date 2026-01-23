type nano 1>/dev/null 2>&1 && alias snano="sudo $(which nano) -f $HOME/.nanorc"
type micro 1>/dev/null 2>&1 && alias smicro="sudo MICRO_CONFIG_HOME=$HOME/.config/micro $(which micro)"
type git 1>/dev/null 2>&1 && alias sgit="sudo PATH=\"${PATH}\" HOME=\"$HOME\" $(which git)"

if type smerge 1>/dev/null 2>&1; then
	alias subm=smerge
else
	[[ -e /opt/sublime_merge/sublime_merge ]] && alias subm="/opt/sublime_merge/sublime_merge"
	[[ -e /c/Program\ Files/Sublime\ Merge/sublime_merge.exe ]] && alias subm="/c/Program\ Files/Sublime\ Merge/sublime_merge.exe"
fi

alias exa="exa --git --group-directories-first --color=auto"

alias no-pyenv='export PATH="$(echo $PATH | sed 's!/[^:]*/.pyenv/[^:]*:!!g')"'

# linuxのコンソール用 絵文字プロンプトを無効にし言語も英語にする
alias cbash="LANG=C bash"

#入力中に上下キーでhistoryから検索
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

#linuxなら標準であるはずだけど
bind '"\e\e[D": backward-word' #alt-left
bind '"\e\e[C": forward-word'  #alt-right

# cdpeco/pdpeco: fdしてpecoしてcdかpushdするコマンド
# fdpeco() {
# 	pushd "${2:-.}" >/dev/null
#     dir="$(fd -Lt d -d 5 | sed 's,^\(.*\)/$,\1$,' | peco | sed 's,^\(.*\)\$$,\1/,')"
#     popd >/dev/null
#     [ -n "$dir" ] && $1 "${2:-.}/$dir"
#     unset dir
# }
# alias cdpeco="fdpeco cd"
# alias cdp="fdpeco cd"
# alias pdpeco="fdpeco pushd"
# alias pdp="fdpeco pushd"

# diffl a b > c でaとbをマージしたものをcに出力
diffl() {
    diff --old-line-format "<%L" --new-line-format ">%L" "$1" "$2"
}
# gitのルートディレクトリにcd
cdroot() {
    dir="$(git rev-parse --show-superproject-working-tree --show-toplevel | head -1)"
    [ -n "$dir" ] && cd "$dir" 
    unset dir
}

alias pd=pushd

# tmuxのバッファにコピー/読み込み
alias tb="bash $(dirname "${BASH_SOURCE[0]}")/tb.sh"

function tw(){
	if [ -z "$1" ]; then
		tmux new-window -c "$(pwd)"
	else
		tmux new-window -c "$(pwd)" "bash -c \" $* ; echo; read -p 'press enter to exit'\""
	fi
}

function pninja() {
	if ninja_version=$(ninja --version 2>/dev/null); then
		if [[ "$(printf '%s\n' "1.12.0" "$ninja_version" | sort -V | head -n1)" = "1.12.0" ]]; then
			NINJA_STATUS=$'\033[1;30;106m%f\033[0;90;106m/%t\033[103;96m\033[30;103m%w\033[90m~%W\033[0;93m\033[0m ' ninja "$@"
		else
			NINJA_STATUS=$'\033[1;30;106m%f\033[0;90;106m/%t\033[0;96m\033[0m ' ninja "$@"
		fi
	else
		# command not found
		ninja "$@"
	fi
}

if [ "${_uname}" = "MINGW64_NT" ]; then
	# workaround https://github.com/microsoft/terminal/issues/5132
	# function tmux(){
	# 	script -q -c "tmux $@" /dev/null
	# }
	alias vsdevcmd22="cmd //k 'C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\Tools\VsDevCmd.bat'"
	alias vsdevcmd19="cmd //k 'C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\Common7\Tools\VsDevCmd.bat'"
	alias syspath='PATH="$ORIGINAL_PATH"'
	
	# lnj a b で mklink /j b a をする
	function lnj() {
		local p2=$(cygpath -w "$2")
		local p1=$(cygpath -w "$1")
		echo "mklink /j \"$p2\" \"$p1\"&& exit" | cmd
	}
	alias open="sh $(dirname "${BASH_SOURCE[0]}")/win_open.sh"
fi


