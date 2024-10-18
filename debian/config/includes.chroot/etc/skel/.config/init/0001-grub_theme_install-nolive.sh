#!/bin/sh

#set -e

cd /etc/xenlism-grub-4k-Debian
sudo ./install.sh || (>&2 echo "Failed install"; exit 1)

sudo sed -i "s/^#GRUB_DISABLE_OS_PROBER=.*$/GRUB_DISABLE_OS_PROBER=false/" /etc/default/grub || (>&2 echo "Failed sed 1"; exit 1)
sudo sed -i "s/^#GRUB_GFXMODE=.*$/GRUB_GFXMODE=$(xrandr | grep "*" | awk '{ print $1 }' | head -n 1)/" /etc/default/grub || (>&2 echo "Failed sed 2"; exit 1)
sudo update-grub || (>&2 echo "Failed update"; exit 1)

