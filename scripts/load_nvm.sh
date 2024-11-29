if uname | grep MINGW64 >/dev/null; then
    export NVM_HOME="C:\ProgramData\nvm"
    export NVM_SYMLINK="C:\Program Files\nodejs"
    export PATH="$(cygpath -u "$NVM_HOME"):$(cygpath -u "$NVM_SYMLINK"):$PATH"
else
    [[ -d "$HOME/.nvm" ]] && export NVM_DIR="$HOME/.nvm"
    [[ -d "$XDG_CONFIG_HOME/nvm" ]] && export NVM_DIR="$XDG_CONFIG_HOME/nvm"
    [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"  # This loads nvm
    [[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi
