type nano 1>/dev/null 2>&1 && alias snano="sudo $(which nano) -f $HOME/.nanorc"
type micro 1>/dev/null 2>&1 && alias smicro="sudo MICRO_CONFIG_HOME=$HOME/.config/micro $(which micro)"
type git 1>/dev/null 2>&1 && alias sgit="sudo PATH=\"${PATH}\" HOME=\"$HOME\" $(which git)"

[[ -e /opt/sublime_merge/sublime_merge ]] && alias subm="/opt/sublime_merge/sublime_merge"

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
fdpeco() {
	pushd "${2:-.}" >/dev/null
    dir="$(fd -Lt d -d 5 | sed 's,^\(.*\)/$,\1$,' | peco | sed 's,^\(.*\)\$$,\1/,')"
    popd >/dev/null
    [ -n "$dir" ] && $1 "${2:-.}/$dir"
    unset dir
}
alias cdpeco="fdpeco cd"
alias cdp="fdpeco cd"
alias pdpeco="fdpeco pushd"
alias pdp="fdpeco pushd"

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
	tmux new-window -c '#{pane_current_path}' "bash -c \" $* ; echo; read -p 'press enter to exit'\""
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


