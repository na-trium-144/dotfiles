#!/bin/sh
sudo sed s/required/sufficient/g -i /etc/pam.d/chsh
echo `which bash` | sudo tee /etc/shells
sudo chsh -s `which bash` `whoami`
# https://askubuntu.com/questions/812420/chsh-always-asking-a-password-and-get-pam-authentication-failure
