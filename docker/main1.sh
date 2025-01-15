set -e
sudo chown -R $USER:$USER $HOME/.local $HOME/.cargo || true
sh -c "$(curl -fsLS https://chezmoi.io/get)" -- -b .local/bin init --apply na-trium-144
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
if ! type fd && ! type delta && ! type hexyl; then .local/share/chezmoi/utils/cargo.sh; fi
if ! type doxygen; then .local/share/chezmoi/utils/source_builds/doxygen.sh; fi
if ! type json-tui; then .local/share/chezmoi/utils/source_builds/json-tui.sh; fi

# .local/share/chezmoi/utils/sublime.sh || true

.local/bin/chezmoi update --force

if type apt-get; then sudo apt-get clean; fi
if type brew; then brew cleanup -s; rm -rf $(brew --cache); fi
if type pacman; then sudo pacman -Scc --noconfirm; fi
rm -rf .cargo/registry
rm -rf .rustup
# rm -rf .nvm/.cache
# .cargo/bin/fd -HI pycache | xargs rm -rf
rm -rf .local/share/chezmoi/utils/source_builds/workdir
