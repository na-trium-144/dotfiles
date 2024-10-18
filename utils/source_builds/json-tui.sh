#!/usr/bin/env bash
set -e
unset CC
unset CXX
unset flags
shopt -s expand_aliases
source $_chezmoi_root/scripts/brew_local_aliases.sh

mkdir -p $(dirname $0)/workdir
pushd $(dirname $0)/workdir
if [[ ! -d json-tui ]]; then
    git clone --depth 1 https://github.com/na-trium-144/json-tui
fi
cd json-tui
if [[ ${_uname} = MINGW64_NT ]]; then
    flags='-DCMAKE_CXX_FLAGS="-Wa,-mbig-obj"'
fi
cmake -Bbuild -DCMAKE_INSTALL_PREFIX=$HOME/.local $flags
cmake --build build --target install
popd
