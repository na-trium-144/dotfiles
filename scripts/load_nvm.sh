if uname | grep MINGW64 >/dev/null; then
    :
else
    [[ -d "$HOME/.nvm" ]] && export NVM_DIR="$(realpath $HOME/.nvm)"
    [[ -d "$XDG_CONFIG_HOME/nvm" ]] && export NVM_DIR="$(realpath $XDG_CONFIG_HOME/nvm)"
    [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"  # This loads nvm
    [[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi
