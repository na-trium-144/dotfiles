set -e
if [[ -e /tmp/artifacts ]]; then
    sudo cp -rLv /tmp/artifacts/.* $HOME/
    sudo rm -rf /tmp/artifacts
fi
sudo chown -R $USER:$USER $HOME/.local $HOME/.cargo || true
if [[ -z $CHEZMOI_BRANCH ]]; then
    CHEZMOI_BRANCH=main
fi
sh -c "$(curl -fsLS https://chezmoi.io/get)" -- -b .local/bin init --apply na-trium-144 --branch $CHEZMOI_BRANCH
.local/share/chezmoi/utils/misc.sh
# .local/share/chezmoi/utils/misc2.sh
# .local/share/chezmoi/utils/misc3.sh
.local/share/chezmoi/utils/tpm.sh
.local/share/chezmoi/utils/chsh_docker.sh

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
# doxygenがpythonを使う
source .local/share/chezmoi/scripts/init_env.sh
# source .local/share/chezmoi/scripts/load_pyenv.sh

if type apt-get; then .local/share/chezmoi/utils/sublime.sh; fi

.local/bin/chezmoi apply --force

if type apt-get; then sudo apt-get clean; fi
if type brew; then brew cleanup -s; rm -rf $(brew --cache); fi
if type pacman; then sudo pacman -Scc --noconfirm; fi
rm -rf .cargo/registry
rm -rf .rustup
# rm -rf .nvm/.cache
# .cargo/bin/fd -HI pycache | xargs rm -rf
rm -rf .local/share/chezmoi/utils/source_builds/workdir
