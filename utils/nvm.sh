#!/usr/bin/env bash
set -e

if uname | grep MINGW64 >/dev/null; then
    source $_chezmoi_root/scripts/load_nvm.sh
    if ! type nvm >/dev/null; then
        type node >/dev/null && sudo choco uninstall nodejs nodejs.install
        sudo choco install -y nvm
    fi
    source $_chezmoi_root/scripts/load_nvm.sh
    for ver in $(cygpath -u "$NVM_HOME")/v*; do nvm uninstall $(echo $(basename $ver) | sed s/v//) || true; done
    nvm install lts
    nvm use lts
    source $_chezmoi_root/scripts/load_nvm.sh
else
    unset NVM_DIR
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
    source $_chezmoi_root/scripts/load_nvm.sh
    nvm install --lts
    nvm use --lts
    nvm alias default 'lts/*'
    for ver in $(ls "$NVM_DIR/versions/node/"); do nvm uninstall "$ver" || true; done
fi
npm install -g git-user-switch
