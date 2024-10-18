#!/usr/bin/env bash
set -e
unset CC
unset CXX
unset flags

pushd $(dirname $0)/workdir
if [[ ! -d json-tui ]]; then
    git clone --depth 1 https://github.com/na-trium-144/json-tui
fi
cd json-tui
if uname | grep MINGW64 >/dev/null; then
    flags='-DCMAKE_CXX_FLAGS="-Wa,-mbig-obj"'
fi
cmake -Bbuild -DCMAKE_INSTALL_PREFIX=$HOME/.local $flags
cmake --build build --target install
popd
