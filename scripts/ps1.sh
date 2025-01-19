echo ${_hostname} | grep kou- >/dev/null 2>&1 || export __is_vm=1

function __dirs_state(){
    local _dirs_c=$(($(dirs -p | wc -l) - 1))
    [[ $_dirs_c != 0 ]] && echo "^${_dirs_c}"
}
if [ -d /dev/shm ]; then
    _tmp=/dev/shm
elif [ -d /tmp ]; then
    _tmp=/tmp
else
    _tmp="$HOME"
fi

function __prompt_time_file(){ echo ${__prompt_time_file:-$_tmp/.kou-tp$$}; }
for f in $_tmp/.kou-tp*; do
    ps -p $(echo $f | sed 's/^.*[^0-9]\([0-9]*\)$/\1/') >/dev/null 2>&1 || rm $f &
    disown $!
done
rm -f $_tmp/.kou-d* >/dev/null 2>&1 &
disown $!

timeout 3 bash $(dirname "${BASH_SOURCE[0]}")/dot_state.sh

_code=
_time=
function __start_timer() {
    local _prompt_time_file=$(__prompt_time_file)
    [[ -s $_prompt_time_file ]] || date +%s >$_prompt_time_file
}
function __set_code(){
    local _code_num=$?
    _code=
    [[ $_code_num = 0 ]] || _code=" ${_code_num} "
    local _time_s=0
    local _prompt_time_file=$(__prompt_time_file)
    [[ -s $_prompt_time_file ]] && _time_s=$(($(date +%s) - $(cat $_prompt_time_file)))
    _time=
    (( $_time_s > 5 )) && _time=" ${_time_s}s "
}
function __clear_timer(){
    true >$(__prompt_time_file)
}
__git_ps1_timeout=2
function __git_ps1_async(){
    if [[ "$__git_ps1_timeout" != "0" ]]; then
        timeout $__git_ps1_timeout bash $(dirname "${BASH_SOURCE[0]}")/git_ps1.sh
    fi
}
function __check_brew_local(){
    if [[ $HOMEBREW_PREFIX = $HOME/.brew ]]; then
        echo -n "🍺 "
    fi
}
__count_ps=$(($(pstree -aTp $(ps -o sid= $$) | wc -l) - 4))
if [[ $__count_ps == 0 ]]; then
    __count_ps=
else
    __count_ps="\$$__count_ps"
fi
export PROMPT_COMMAND="__set_code" # 他のps1のコマンドより先に実行しないといけない
trap '__start_timer' DEBUG # コマンド実行前に実行

FACE=
[[ "${_hostname}" = "kou-RockLM" ]] && FACE='ε=ヾ(・∀ ・)ﾉ'
[[ "${_hostname}" = "kou-Rock11" ]] && FACE='d(* ¯∇¯) '
[[ "${_hostname}" = "kou-Ace" ]] && FACE='(σ ･∀ ･)σ '
[[ "${_hostname}" = "kou-Surf" ]] && FACE='(9 ･ω･)9 '
[[ "${_hostname}" = "kou-MAir.local" ]] && FACE='･_･)φ_'
# 31=red, 32=green, 33=yellow, 34=blue, 35=magenta, 36=cyan
PS1_TIT='\[\e]0;${debian_chroot:+($debian_chroot)}\W '${FACE}'\a\]'
PS1_CHROOT='${debian_chroot:+($debian_chroot)}'
PS1_PRE='\[\033[0;107m\]$(__check_brew_local)'
PS1_HOST='\[\033[1;107;31m\]\h'
PS1_DISPLAY='\[\033[0;107;31m\]${DISPLAY//*\//\/}'
PS1_PS='\[\033[0;107;35m\]${__count_ps}'
PS1_SEPARATOR='\[\033[0;107m\]:'
PS1_DIR='\[\033[1;107;36m\]\w'
PS1_DIRS='\[\033[0;107;36m\]$(__dirs_state)'
PS1_GIT='\[\033[0;107;32m\]$(__git_ps1_async) '
PS1_FACE='\[\033[0;107;33m\]'${FACE}
PS1_NUM='\[\033[0;107;31m\] ${_code}${_time}$(__clear_timer)\[\033[0;107;32m\]#\#'
PS1_END='\[\033[0;97m\]\[\033[0m\] '
if [[ "${_hostname}" = "kou-RPi3" ]]; then
    FACE='kou- '
    PS1_TIT='\[\e]0;${debian_chroot:+($debian_chroot)}\W '${FACE}'\a\]'
    PS1_HOST='\[\033[1;107;31m\]'${FACE}
fi
if [[ -n "$MC_SID" ]]; then
    PS1_PRE='\[\033[0;107m\][mc]'"$PS1_PRE"
    # PS1_END='\[\033[0m\] '
    # PS1_DIR='\[\033[1;107;36m\]\W'
fi
PS1="$PS1_TIT$PS1_CHROOT$PS1_PRE$PS1_HOST$PS1_DISPLAY$PS1_PS$PS1_SEPARATOR$PS1_DIR$PS1_DIRS$PS1_GIT$PS1_FACE$PS1_NUM$PS1_END"
