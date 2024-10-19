#!/usr/bin/env bash
set -e

if uname | grep MINGW64 >/dev/null; then
    export NVM_HOME="C:\ProgramData\nvm"
    export NVM_SYMLINK="C:\Program Files\nodejs"
    if ! type nvm >/dev/null; then
        type node >/dev/null && sudo choco uninstall nodejs nodejs.install
        sudo choco install -y nvm
        export PATH="$(cygpath -u "$NVM_HOME"):$(cygpath -u "$NVM_SYMLINK"):$PATH"
    fi
    for ver in $(cygpath -u "$NVM_HOME")/v*; do nvm uninstall $(echo $(basename $ver) | sed s/v//) || true; done
    nvm install lts
    nvm use lts
    export PATH="$(cygpath -u "$NVM_HOME"):$(cygpath -u "$NVM_SYMLINK"):$PATH"
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
