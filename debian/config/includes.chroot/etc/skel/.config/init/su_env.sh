#!/bin/sh

#set -e

sed -i "s/^# auth       required   pam_wheel.so$/auth       required   pam_wheel.so group=sudo/" /etc/pam.d/su || (>&2 echo "Failed sed 1"; exit 1)

sudo ln -s /home/nucleuser/.vim /root/.vim || (>&2 echo "Failed ln 1"; exit 1)
sudo ln -s /home/nucleuser/.vimrc /root/.vimrc || (>&2 echo "Failed ln 2"; exit 1)

sudo ln -s /home/nucleuser/.zshrc /root/.zshrc || (>&2 echo "Failed ln 3"; exit 1)
sudo usermod --shell "$(which zsh)" root || (>&2 echo "Failed root shell change"; exit 1)

