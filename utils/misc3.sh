#!/bin/sh
sudo apt install cppcheck tidy || brew install cppcheck
pip3 install black pylint cmakelint clang-format mypy flake8
cd ~/.config/sublime-text/Packages/User/formatter.assets/javascript && npm install
