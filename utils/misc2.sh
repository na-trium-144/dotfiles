#!/usr/bin/env bash
set -e
unset CC
unset CXX
py_version=3.12.5

if uname | grep MINGW64 >/dev/null; then
    if ! type pyenv >/dev/null; then
        type python3.10 >/dev/null && sudo choco uninstall python310
    fi
    # pyenv-win
    powershell 'Invoke-WebRequest -UseBasicParsing -Uri "https://raw.githubusercontent.com/pyenv-win/pyenv-win/master/pyenv-win/install-pyenv-win.ps1" -OutFile "./install-pyenv-win.ps1"; Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process; .\install-pyenv-win.ps1'
    rm install-pyenv-win.ps1
    if ! type pyenv >/dev/null; then
        echo "pyenv-win not found in path, please update path and rerun misc2.sh"
        exit 1
    fi
else
    type pyenv || curl https://pyenv.run | bash
    $(dirname $0)/python_dep.sh
    eval "$(pyenv init --path)"
fi
pyenv update
[ -e $HOME/.pyenv/versions/$py_version ] || pyenv install $py_version
pyenv global $py_version

pip install pipx
pipx install poetry
# curl -sSL https://install.python-poetry.org | python3 -
# curl -sSL https://install.python-poetry.org | python3 - --uninstall

if uname | grep MINGW64 >/dev/null; then
    if ! type nvm >/dev/null; then
        type node >/dev/null && sudo choco uninstall nodejs nodejs.install
        sudo choco install -y nvm
    fi
    for ver in $(cygpath -u "$NVM_HOME")/v*; do nvm uninstall $(echo $(basename $ver) | sed s/v//) || true; done
    nvm install lts
    nvm use lts
else
    unset NVM_DIR
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh" # This loads nvm
    nvm install --lts
    nvm use --lts
    nvm alias default 'lts/*'
    for ver in $(ls "$NVM_DIR/versions/node/"); do nvm uninstall "$ver" || true; done
fi
npm install -g git-user-switch

#completion
[ -e ~/.bash_completion ] && rm ~/.bash_completion
poetry completions bash >> ~/.bash_completion
chezmoi completion bash >> ~/.bash_completion
npm completion bash >> ~/.bash_completion
