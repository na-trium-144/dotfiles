#!/bin/sh
# pip, cargo > apt, pacman, brew > install script
if type apt-get; then
	sudo apt-get install -y micro peco mc tmux fzf
elif type pacman; then
	# pacmanはインストール済みのも再インストールしてしまうので、いちいち確認する
	type hostname || sudo pacman -S inetutils
	type micro || sudo pacman -S micro
	type peco || sudo pacman -S peco
	type mc || sudo pacman -S mc
	type tmux || sudo pacman -S tmux
	type fzf || sudo pacman -S fzf
elif type brew; then
	brew install micro peco mc tmux fzf
fi
# aarch64のubuntuでcargoをaptで入れると古いので、公式のインストールスクリプトにした
#  https://doc.rust-lang.org/cargo/getting-started/installation.html
type cargo || curl https://sh.rustup.rs -sSf | sh
cargo install fd-find git-delta hexyl
type pyenv || curl https://pyenv.run | bash
pip3 install pipenv
type poetry || curl -sSL https://install.python-poetry.org | python3 -
if ! [ -d ~/.tmux/plugins/tpm ]; then
	mkdir -p ~/.tmux/plugins
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
nvm install --lts
npm install -g git-user-switch

#completion
rm ~/.bash_completion
poetry completions bash >> ~/.bash_completion
chezmoi completion bash >> ~/.bash_completion
npm completion bash >> ~/.bash_completion
