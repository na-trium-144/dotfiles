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
    # no local brew alias here
    # https://devguide.python.org/getting-started/setup-building/index.html#linux
    # https://github.com/pyenv/pyenv/wiki#suggested-build-environment
    if type brew; then
        brew install tcl-tk readline ncurses
    elif type pacman; then
        sudo pacman -S --noconfirm --needed base-devel openssl zlib xz tk
    elif type apt-get; then
        type sudo && sudo=sudo
        $sudo apt-get install -y build-essential gdb lcov pkg-config \
          libbz2-dev libffi-dev libgdbm-dev libgdbm-compat-dev liblzma-dev \
          libncurses5-dev libreadline6-dev libsqlite3-dev libssl-dev \
          lzma lzma-dev tk-dev uuid-dev zlib1g-dev \
          || true
        # sudoが使えない環境は、無視
    fi
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

