#!/usr/bin/env bash
set -e
unset CC
unset CXX

version=1.3.1
pushd $(dirname $0)/workdir
if [[ ! -d zlib-$version ]]; then
    curl -fLO https://www.zlib.net/zlib-$version.tar.xz
    tar Jxvf zlib-$version.tar.xz
fi
cd zlib-$version
./configure --prefix=$HOME/.local
make install
popd
