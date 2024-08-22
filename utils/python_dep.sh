#!/bin/sh
set -e
# https://devguide.python.org/getting-started/setup-building/index.html#linux
if type brew; then
    brew install tcl-tk readline ncurses
elif type apt-get; then
    type sudo && sudo=sudo
    $sudo apt-get install -y build-essential gdb lcov pkg-config \
      libbz2-dev libffi-dev libgdbm-dev libgdbm-compat-dev liblzma-dev \
      libncurses5-dev libreadline6-dev libsqlite3-dev libssl-dev \
      lzma lzma-dev tk-dev uuid-dev zlib1g-dev
fi
