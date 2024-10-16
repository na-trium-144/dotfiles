#!/usr/bin/env bash
set -e
unset CC
unset CXX
unset flags

if uname | grep MINGW64 >/dev/null; then
    # for doxygen
    type flex || pacman -S --noconfirm flex
    type bison || pacman -S --noconfirm bison
elif type brew; then
    brew install bison m4
    export PATH="$(brew --prefix bison)/bin:$(brew --prefix m4)/bin:$PATH"
fi
pushd $(dirname $0)/doxygen
cmake -Bbuild -DCMAKE_INSTALL_PREFIX=$HOME/.local $flags
cmake --build build --target install
popd
