#!/usr/bin/env bash
set -e
if ! type apt-get; then
    exit 1
fi
if ! type subl; then
    curl -L https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null
    echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
    sudo apt-get update
    sudo apt-get install -y sublime-text sublime-merge libgl1
fi
hash -r
type subl

if [[ -z $DISPLAY ]]; then
    # https://stackoverflow.com/questions/39085462/xdummy-in-docker-container
    use_xdummy=1
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y xserver-xorg-video-dummy
    cp $HOME/.local/share/chezmoi/scripts/xorg.conf /tmp
    cd /tmp
    # echo "allowed_users = anybody" | sudo tee -a /etc/X11/Xwrapper.config
    sudo Xorg -noreset +extension GLX -config xorg.conf :99 &
    export DISPLAY=:99
fi

function remove_theme() {
    sed -i '/"theme":/d;/"color_scheme":/d' $HOME/.config/sublime-text/Packages/User/Preferences.sublime-settings
}

remove_theme
timeout=2
until [[ -e "$HOME/.config/sublime-text/Installed Packages/0_package_control_loader.sublime-package" ]]; do
    subl
    sleep $timeout
    subl --command install_package_control
    sleep $((timeout * 2))
    pkill sublime 
    sleep $timeout
    timeout=$((timeout + 2))
    echo Installed Packages:
    ls $HOME/.config/sublime-text/Installed\ Packages
done
echo install_package_control done
while [[ -e "$HOME/.config/sublime-text/Installed Packages/0_package_control_loader.sublime-package" ]]; do
    subl
    sleep $((timeout * 2))
    pkill sublime
    sleep $timeout
    ~/.local/bin/chezmoi apply --force
    remove_theme
    timeout=$((timeout + 2))
    echo Installed Packages:
    ls $HOME/.config/sublime-text/Installed\ Packages
done
echo install packages done

~/.local/bin/chezmoi apply --force

if [[ -n $use_xdummy ]]; then
    sudo pkill Xorg
    sudo apt-get autoremove -y xserver-xorg-video-dummy
fi
