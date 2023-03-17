#!/bin/sh
type pyenv || curl https://pyenv.run | bash
pip3 install pipenv
type poetry || curl -sSL https://install.python-poetry.org | python3 -
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
nvm install --lts
npm install -g git-user-switch

#completion
[ -e ~/.bash_completion ] && rm ~/.bash_completion
poetry completions bash >> ~/.bash_completion
chezmoi completion bash >> ~/.bash_completion
npm completion bash >> ~/.bash_completion
