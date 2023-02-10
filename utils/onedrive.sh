#!/bin/sh
#see https://github.com/abraunegg/onedrive/blob/master/docs/INSTALL.md
sudo apt install build-essential libcurl4-openssl-dev libsqlite3-dev pkg-config git curl libnotify-dev
curl -fsS https://dlang.org/install.sh | bash -s dmd
source ~/dlang/dmd-*/activate
cd ~/.local
git clone https://github.com/abraunegg/onedrive.git
cd onedrive
./configure --enable-notifications
make clean; make;
sudo make install
onedrive
onedrive --synchronize
systemctl --user enable onedrive
systemctl --user start onedrive
