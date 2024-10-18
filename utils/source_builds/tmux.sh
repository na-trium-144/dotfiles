#!/usr/bin/env bash
set -e
unset CC
unset CXX
export LDFLAGS="-L$HOME/.local/lib"
export CFLAGS="-I$HOME/.local/include"
export CPPFLAGS="-I$HOME/.local/include"

# if type apt-get >/dev/null; then
# type sudo && sudo=sudo
# $sudo apt-get install -y libevent-dev ncurses-dev bison

version=3.5a
pushd $(dirname $0)/workdir
if [[ ! -d tmux-$version ]]; then
    curl -fLO https://github.com/tmux/tmux/releases/download/$version/tmux-$version.tar.gz
    tar zxvf tmux-$version.tar.gz
fi
cd tmux-$version
./configure --prefix=$HOME/.local
make install
popd
