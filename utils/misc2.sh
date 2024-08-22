#!/usr/bin/env bash
set -e
unset CC
unset CXX
py_version=3.12.5

type pyenv || curl https://pyenv.run | bash
$(dirname $0)/python_dep.sh
eval "$(pyenv init --path)"
pyenv update
[ -e $HOME/.pyenv/versions/$py_version ] || pyenv install $py_version
pyenv global $py_version

pip install pipx
pipx install poetry
# curl -sSL https://install.python-poetry.org | python3 -
# curl -sSL https://install.python-poetry.org | python3 - --uninstall

unset NVM_DIR
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh" # This loads nvm
nvm install --lts
nvm use --lts
nvm alias default 'lts/*'
for ver in $(ls "$NVM_DIR/versions/node/"); do nvm uninstall "$ver" || true; done
npm install -g git-user-switch

#completion
[ -e ~/.bash_completion ] && rm ~/.bash_completion
poetry completions bash >> ~/.bash_completion
chezmoi completion bash >> ~/.bash_completion
npm completion bash >> ~/.bash_completion
