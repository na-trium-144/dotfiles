#!/bin/sh
sudo apt-get install -y cargo micro peco mc tmux || brew install rust micro peco mc tmux
cargo install fd-find git-delta hexyl
curl https://pyenv.run | bash
pip3 install pipenv
