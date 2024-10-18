echo -e -n '\033[0;107m  '
echo -e -n '\033[0;107;32m '
pushd `dirname "${BASH_SOURCE[0]}"` >/dev/null
echo    -n `git log --oneline | wc -l`
if [ -e "$HOME/.utils" ]; then
    echo -e -n '\033[0;107m  '
    echo -e -n '\033[0;107;31m󰍁  '
    echo -e -n '\033[0;107;35m '
    cd "$HOME/.utils"
    echo    -n `git log --oneline | wc -l`
fi
popd >/dev/null
echo -e '\033[K\033[0m'

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM="verbose"

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
function __git_ps1_file(){ echo ${__git_ps1_file:-$_tmp/.kou-git}; }
for f in $_tmp/.kou-tp*; do
	ps -p $(echo $f | sed 's/^.*[^0-9]\([0-9]*\)$/\1/') >/dev/null 2>&1 || rm $f
done
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
        sleep $__git_ps1_timeout & local tp=$!
        local _git_ps1_file=$(__git_ps1_file)
        (__git_ps1 | sed "s/(\\(.*\\))/(\\1 @$(git config user.name))/" >$_git_ps1_file; kill -9 $tp) >/dev/null 2>&1 &
        #local tp2=$!
        wait $tp
        cat $_git_ps1_file
        #kill -2 $tp2 2>/dev/null &
    fi
}
function __check_brew_local(){
    if [[ $HOMEBREW_PREFIX = $HOME/.brew ]]; then
        echo -n "🍺 "
    fi
}
export PROMPT_COMMAND="__set_code" # 他のps1のコマンドより先に実行しないといけない
trap '__start_timer' DEBUG # コマンド実行前に実行

FACE=
[[ "${_hostname}" = "kou-RockLM" ]] && FACE='ε=ヾ(・∀ ・)ﾉ'
[[ "${_hostname}" = "kou-Rock11" ]] && FACE='d(* ¯∇¯) '
[[ "${_hostname}" = "kou-Ace" ]] && FACE='(σ ･∀ ･)σ '
[[ "${_hostname}" = "kou-Surf" ]] && FACE='(9 ･ω･)9 '
[[ "${_hostname}" = "kou-MAir.local" ]] && FACE='･_･)φ_'
PS1_TIT='\[\e]0;${debian_chroot:+($debian_chroot)}\W '${FACE}'\a\]'
PS1_CHROOT='${debian_chroot:+($debian_chroot)}'
PS1_PRE='\[\033[0;107m\]$(__check_brew_local)'
PS1_HOST='\[\033[1;107;31m\]\h'
PS1_DISPLAY='\[\033[0;107;31m\]${DISPLAY//*\//\/}'
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
PS1="$PS1_TIT$PS1_CHROOT$PS1_PRE$PS1_HOST$PS1_DISPLAY$PS1_SEPARATOR$PS1_DIR$PS1_DIRS$PS1_GIT$PS1_FACE$PS1_NUM$PS1_END"
