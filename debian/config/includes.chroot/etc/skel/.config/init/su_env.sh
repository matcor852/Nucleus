#!/bin/sh

set -e

sed -i "s/^# auth       required   pam_wheel.so$/auth       required   pam_wheel.so group=sudo/" /etc/pam.d/su

sudo ln -s /home/matthieu/.vim /root/.vim
sudo ln -s /home/matthieu/.vimrc /root/.vimrc

sudo ln -s /home/matthieu/.zshrc /root/.zshrc
sudo usermod --shell "$(which zsh)" root

