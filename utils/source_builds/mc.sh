#!/usr/bin/env bash
set -e
unset CC
unset CXX
unset flags

if type apt-get >/dev/null; then
    type sudo && sudo=sudo
    if [[ `$sudo id -u` = 0 ]]; then
        $sudo apt-get install -y libglib2.0-dev libslang2-dev
    else
        echo "sudo unavailable, skipping apt installs"
    fi
fi

version=4.8.32
pushd $(dirname $0)/workdir
curl -fLO http://ftp.midnight-commander.org/mc-$version.tar.xz
tar Jxvf mc-$version.tar.xz
cd mc-$version
./configure --prefix=$HOME/.local
make install
popd
