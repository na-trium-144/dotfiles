#!/bin/sh
sudo pacman -S jre-openjdk-headless
sudo groupadd -g 555 gitbucket
sudo useradd -g gitbucket --no-user-group --home-dir /opt/gitbucket --no-create-home --shell /usr/sbin/nologin --system --uid 555 gitbucket
# sudo mkdir /opt/gitbucket
# sudo ln -s /mnt/hd0/gitbucket ./.gitbucket
[ -e /opt/gitbucket ] || sudo ln -s /mnt/hd0/gitbucket /opt/gitbucket
cd /opt/gitbucket
# sudo wget https://github.com/gitbucket/gitbucket/releases/download/4.33.0/gitbucket.war
sudo curl -OL https://github.com/gitbucket/gitbucket/releases/download/4.38.4/gitbucket.war
sudo chown -R gitbucket:gitbucket /opt/gitbucket/
sudo cp ~/.local/share/chezmoi/scripts/gitbucket.service /etc/systemd/system/gitbucket.service
sudo systemctl daemon-reload
sudo systemctl enable gitbucket
sudo systemctl restart gitbucket
