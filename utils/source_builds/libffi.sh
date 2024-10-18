#!/usr/bin/env bash
set -e
unset CC
unset CXX

version=3.4.6
pushd $(dirname $0)/workdir
if [[ ! -d libffi-$version ]]; then
    curl -fLO https://github.com/libffi/libffi/releases/download/v$version/libffi-$version.tar.gz
    tar zxvf libffi-$version.tar.gz
fi
cd libffi-$version
./configure --prefix=$HOME/.local
make install
popd
