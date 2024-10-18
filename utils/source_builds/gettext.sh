#!/usr/bin/env bash
set -e
unset CC
unset CXX

version=0.19.8
pushd $(dirname $0)/workdir
if [[ ! -d gettext-$version ]]; then
    curl -fLO https://ftp.gnu.org/pub/gnu/gettext/gettext-$version.tar.gz
    tar zxvf gettext-$version.tar.gz
fi
cd gettext-$version
./configure --prefix=$HOME/.local
make install
popd
