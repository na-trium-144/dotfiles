#!/usr/bin/env bash
set -e
unset CC
unset CXX
unset flags

if type apt-get >/dev/null; then
    type sudo && sudo=sudo
    if [[ `$sudo id -u` = 0 ]]; then
        $sudo apt-get install -y libevent-dev ncurses-dev bison
    else
        echo "sudo unavailable, skipping apt installs"
    fi
fi

version=3.5a
pushd $(dirname $0)/workdir
curl -fLO https://github.com/tmux/tmux/releases/download/$version/tmux-$version.tar.gz
tar zxvf tmux-$version.tar.gz
cd tmux-$version
./configure --prefix=$HOME/.local
make install
popd
