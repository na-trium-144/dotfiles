#!/bin/sh
set -e
unset CC
unset CXX
export PATH="$HOME/.cargo/bin:$_winhome/.cargo/bin:$PATH"

if uname | grep MINGW64 >/dev/null; then
    type cargo || pacman -S --noconfirm mingw-w64-ucrt-x86_64-rust
else
    # aarch64のubuntuでcargoをaptで入れると古いので、公式のインストールスクリプトにした
    #  https://doc.rust-lang.org/cargo/getting-started/installation.html
    curl https://sh.rustup.rs -sSf | sh -s -- -y
fi
cargo install fd-find git-delta hexyl
cargo install --git https://github.com/na-trium-144/git-checkoutui
