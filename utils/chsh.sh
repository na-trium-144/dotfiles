#!/bin/sh
echo `which bash` | sudo tee /etc/shells
chsh -s `which bash`
sh $(dirname $0)/git.sh
