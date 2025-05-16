#!/usr/bin/env bash
set -e
if ! type apt-get; then
    exit 1
fi
if ! type subl; then
    curl -L https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null
    echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
    sudo apt-get update
    sudo apt-get install -y sublime-text sublime-merge libgl1 fontconfig language-pack-ja-base language-pack-ja
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

timeout=2
pkg_count_prev=0
pkg_count_now=$(ls $HOME/.config/sublime-text/Installed\ Packages -1 | wc -l)
# 本当は現在27のはずだが、なぜかdocker build中どれだけ待ってもそこまでインストールされないので、条件を緩めにしている
until (( pkg_count_now > 16 )) && (( pkg_count_now <= pkg_count_prev )); do
    # Error loading theme のダイアログが出ている間インストールが進まないので、テーマを消す
    sed -i '/"theme":/d;/"color_scheme":/d' $HOME/.config/sublime-text/Packages/User/Preferences.sublime-settings
    subl
    sleep $timeout
    subl --command install_package_control
    sleep $((timeout * 2))
    pkill sublime
    sleep $timeout
    timeout=$((timeout + 2))
    pkg_count_prev=$pkg_count_now
    pkg_count_now=$(ls $HOME/.config/sublime-text/Installed\ Packages -1 | wc -l)
    echo "Installed Packages: $pkg_count_now"
    ls $HOME/.config/sublime-text/Installed\ Packages
    # テーマを戻す
    ~/.local/bin/chezmoi apply --force
done
echo "Install Packages done"

if [[ -n $use_xdummy ]]; then
    sudo pkill Xorg
    sudo apt-get autoremove -y xserver-xorg-video-dummy
fi
