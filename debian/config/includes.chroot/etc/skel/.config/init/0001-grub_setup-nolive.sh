#!/bin/sh

cd /etc/xenlism-grub-4k-Debian
sudo ./install.sh || (>&2 echo "Failed install"; exit 1)

sudo mkdir -p /boot/themes
sudo cp -pr /usr/share/grub/themes/Xenlism-Debian /boot/themes
sudo ln -s Xenlism-Debian /boot/themes/live

sudo sed -i "s/^GRUB_THEME=.*$/GRUB_THEME=\/boot\/themes\/live\/theme.txt/" /etc/default/grub
sudo sed -i "s/^GRUB_DEFAULT=.*$/GRUB_DEFAULT=saved\nGRUB_SAVEDEFAULT=true/" /etc/default/grub
sudo sed -i "s/^#GRUB_DISABLE_OS_PROBER=.*$/GRUB_DISABLE_OS_PROBER=false/" /etc/default/grub || (>&2 echo "Failed sed 1"; exit 1)
sudo sed -i "s/^#GRUB_GFXMODE=.*$/GRUB_GFXMODE=$(xrandr | grep "*" | awk '{ print $1 }' | head -n 1)/" /etc/default/grub || (>&2 echo "Failed sed 2"; exit 1)
sudo sed -i "s/^GRUB_CMDLINE_LINUX_DEFAULT=.*$/GRUB_CMDLINE_LINUX_DEFAULT=\"quiet splash\"/" /etc/default/grub || (>&2 echo "Failed sed 1"; exit 1)
sudo update-grub || (>&2 echo "Failed grub update"; exit 1)
sudo plymouth-set-default-theme -R flame || (>&2 echo "Failed setting theme"; exit 1)
sudo dpkg -r desktop-base

