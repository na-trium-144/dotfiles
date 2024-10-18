#!/usr/bin/env bash
set -e
unset CC
unset CXX

version=2.3.0
pushd $(dirname $0)/workdir
if [[ ! -d pkgconf-$version ]]; then
    curl -fLO https://distfiles.ariadne.space/pkgconf/pkgconf-$version.tar.xz
    tar Jxvf pkgconf-$version.tar.xz
fi
cd pkgconf-$version
./configure --prefix=$HOME/.local \
    --with-system-libdir=/lib:/usr/lib \
    --with-system-includedir=/usr/include
make install
ln -sf pkgconf $HOME/.local/bin/pkg-config
popd
