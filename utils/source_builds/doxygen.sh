#!/usr/bin/env bash
set -e
unset CC
unset CXX
unset flags
shopt -s expand_aliases
source $_chezmoi_root/scripts/brew_local_aliases.sh

if [[ ${_uname} = MINGW64_NT ]]; then
    # for doxygen
    type flex || pacman -S --noconfirm flex
    type bison || pacman -S --noconfirm bison
elif type brew; then
    brew install bison m4
    export PATH="$(brew --prefix bison)/bin:$(brew --prefix m4)/bin:$PATH"
fi
mkdir -p $(dirname $0)/workdir
pushd $(dirname $0)/workdir
if [[ ! -d doxygen ]]; then
    git clone --depth 1 -b Release_1_9_7 https://github.com/doxygen/doxygen.git
fi
cd doxygen
cmake -Bbuild -DCMAKE_INSTALL_PREFIX=$HOME/.local $flags
cmake --build build --target install
popd
