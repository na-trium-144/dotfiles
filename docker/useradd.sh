set -e
useradd -u $BASE_UID -d $BASE_HOME -o -m -s/bin/bash $BASE_USER
echo $BASE_USER:passwd | chpasswd
groupmod -g $BASE_GID $BASE_USER
gpasswd -a $BASE_USER sudo || gpasswd -a $BASE_USER wheel
echo "$BASE_USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
