#!/usr/bin/env bash
set -e
unset CC
unset CXX
unset flags

pushd $(dirname $0)/json-tui
if uname | grep MINGW64 >/dev/null; then
    flags='-DCMAKE_CXX_FLAGS="-Wa,-mbig-obj"'
fi
cmake -Bbuild -DCMAKE_INSTALL_PREFIX=$HOME/.local $flags
cmake --build build --target install
popd
