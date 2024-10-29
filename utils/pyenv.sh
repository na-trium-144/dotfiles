#!/usr/bin/env bash
set -e
unset CC
unset CXX
py_version=3.12.6

if uname | grep MINGW64 >/dev/null; then
    if ! type pyenv >/dev/null; then
        type python3.10 >/dev/null && sudo choco uninstall python310
    fi
    # pyenv-win
    powershell 'Invoke-WebRequest -UseBasicParsing -Uri "https://raw.githubusercontent.com/pyenv-win/pyenv-win/master/pyenv-win/install-pyenv-win.ps1" -OutFile "./install-pyenv-win.ps1"; Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process; .\install-pyenv-win.ps1'
    rm install-pyenv-win.ps1
else
    type pyenv || curl https://pyenv.run | bash
    $(dirname $0)/python_dep.sh || true
fi
source $_chezmoi_root/scripts/load_pyenv.sh
pyenv update

if [ -e $HOME/.pyenv/versions/3.12.5 ]; then
    pipx uninstall-all
    if uname | grep MINGW64 >/dev/null; then
        rm -rf $_winhome/pipx  # pipxのvenv,shared libraries を消す
    else
        rm -rf $HOME/.local/share/pipx
    fi
    pyenv uninstall 3.12.5
fi

[ -e $HOME/.pyenv/versions/$py_version ] || pyenv install $py_version
pyenv global $py_version

pip install pipx
pipx install poetry
# curl -sSL https://install.python-poetry.org | python3 -
# curl -sSL https://install.python-poetry.org | python3 - --uninstall

