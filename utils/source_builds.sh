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

pushd $(dirname $0)/doxygen
cmake -Bbuild -DCMAKE_INSTALL_PREFIX=$HOME/.local
cmake --build build --target install
popd

pushd $(dirname $0)/json-tui
cmake -Bbuild -DCMAKE_INSTALL_PREFIX=$HOME/.local
cmake --build build --target install
popd
