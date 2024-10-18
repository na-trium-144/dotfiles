#!/usr/bin/env bash
set -e
[[ -e $HOME/.local/lib/libglib-2.0.so ]] || $(dirname $0)/glib.sh
[[ -e $HOME/.local/lib/libncursesw.so ]] || $(dirname $0)/ncurses.sh

unset CC
unset CXX
export LDFLAGS="-L$HOME/.local/lib"
export CFLAGS="-I$HOME/.local/include"
export CPPFLAGS="-I$HOME/.local/include"

# if type apt-get >/dev/null; then
# type sudo && sudo=sudo
# $sudo apt-get install -y libglib2.0-dev libslang2-dev

version=4.8.32
pushd $(dirname $0)/workdir
if [[ ! -d mc-$version ]]; then
    curl -fLO http://ftp.midnight-commander.org/mc-$version.tar.xz
    tar Jxvf mc-$version.tar.xz
fi
cd mc-$version
./configure --prefix=$HOME/.local \
	--with-screen=ncurses \
	--with-ncurses-includes=$HOME/.local/include \
	--with-ncurses-libs=$HOME/.local/lib/libncursesw.so
make install
popd
