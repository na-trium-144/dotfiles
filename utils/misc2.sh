#!/usr/bin/env bash
set -e

bash $(dirname $0)/nvm.sh
bash $(dirname $0)/pyenv.sh

source $_chezmoi_root/scripts/load_nvm.sh

#completion
[ -e ~/.bash_completion ] && rm ~/.bash_completion
poetry completions bash >> ~/.bash_completion
chezmoi completion bash >> ~/.bash_completion
npm completion bash >> ~/.bash_completion || true
