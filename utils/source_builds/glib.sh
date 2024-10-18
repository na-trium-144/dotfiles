#!/usr/bin/env bash
set -e
type pkg-config >/dev/null || bash $(dirname $0)/pkgconf.sh
[[ -e $HOME/.local/lib/libz.so ]] || bash $(dirname $0)/zlib.sh
[[ -e $HOME/.local/lib/libffi.so ]] || bash $(dirname $0)/libffi.sh
[[ -e $HOME/.local/lib/libgettextlib.so ]] || bash $(dirname $0)/gettext.sh

unset CC
unset CXX
export LDFLAGS="-L$HOME/.local/lib"
export CFLAGS="-I$HOME/.local/include"
export CPPFLAGS="-I$HOME/.local/include"

version=2.32.4
pushd $(dirname $0)/workdir
if [[ ! -d glib-$version ]]; then
    curl -fLO https://download.gnome.org/sources/glib/2.32/glib-2.32.4.tar.xz
    tar Jxvf glib-$version.tar.xz
fi
cd glib-$version
./configure --prefix=$HOME/.local
make install
popd
