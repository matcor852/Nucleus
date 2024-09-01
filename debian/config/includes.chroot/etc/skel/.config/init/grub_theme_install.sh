#!/bin/sh

set -e

cd /etc/xenlism-grub-4k-Debian
sudo ./install.sh

sudo sed -i "s/^#GRUB_DISABLE_OS_PROBER=.*$/GRUB_DISABLE_OS_PROBER=false/" /etc/default/grub
sudo sed -i "s/^#GRUB_GFXMODE=.*$/GRUB_GFXMODE=$(xrandr | grep "*" | awk '{ print $1 }' | head -n 1)/" /etc/default/grub
sudo update-grub

