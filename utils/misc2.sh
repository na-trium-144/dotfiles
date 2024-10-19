#!/usr/bin/env bash
set -e

bash ./nvm.sh
bash ./pyenv.sh

#completion
[ -e ~/.bash_completion ] && rm ~/.bash_completion
poetry completions bash >> ~/.bash_completion
chezmoi completion bash >> ~/.bash_completion
npm completion bash >> ~/.bash_completion || true
