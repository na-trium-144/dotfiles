#!/usr/bin/env bash
set -e
unset CC
unset CXX

# aarch64のubuntuでcargoをaptで入れると古いので、公式のインストールスクリプトにした
#  https://doc.rust-lang.org/cargo/getting-started/installation.html
if uname | grep MINGW64 >/dev/null; then
    type cargo || pacman -S --noconfirm mingw-w64-ucrt-x86_64-rust
else
    curl https://sh.rustup.rs -sSf | sh -s -- -y
fi
cargo install fd-find git-delta hexyl

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
unset flags

pushd $(dirname $0)/json-tui
if uname | grep MINGW64 >/dev/null; then
    flags='-DCMAKE_CXX_FLAGS="-Wa,-mbig-obj"'
fi
cmake -Bbuild -DCMAKE_INSTALL_PREFIX=$HOME/.local $flags
cmake --build build --target install
popd
