if [[ "${_uname}" = MINGW64_NT ]]; then
    export PATH="${_winhome}/.local/bin:$PATH"
    export PATH="${_winhome}/.pyenv/pyenv-win/bin:${_winhome}/.pyenv/pyenv-win/shims:$PATH"
else
    export PATH="${HOME}/.pyenv/bin:$PATH"
    if type pyenv >/dev/null 2>&1; then
        eval "$(pyenv init --path)"
        # eval "$(pyenv virtualenv-init -)"
    fi
fi
