#!/usr/bin/env bash
set -e

if type npm >/dev/null; then 
    npm uni -g pnpm || true
fi
if type bun >/dev/null; then 
    bun r -g pnpm || true
fi
if brew list pnpm >/dev/null; then 
    brew uninstall pnpm
fi

if uname | grep MINGW64 >/dev/null; then
    sudo choco install -y pnpm
else
    if ! type pnpm; then
        curl -fsSL https://get.pnpm.io/install.sh | sh -
    fi
fi
