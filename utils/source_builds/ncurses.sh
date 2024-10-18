#!/usr/bin/env bash
set -e
unset CC
unset CXX

version=6.3
pushd $(dirname $0)/workdir
if [[ ! -d ncurses-$version ]]; then
    curl -fLO https://invisible-island.net/datafiles/release/ncurses.tar.gz
    tar zxvf ncurses.tar.gz
fi
cd ncurses-$version
./configure --prefix=$HOME/.local \
	--enable-widec --disable-overwrite \
	--with-shared --without-normal --without-debug \
	--with-cxx-shared --without-cxx-normal --without-cxx-debug
make install
popd
