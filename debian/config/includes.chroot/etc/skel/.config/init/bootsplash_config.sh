#!/bin/sh

#set -e

sudo sed -i "s/^GRUB_CMDLINE_LINUX_DEFAULT=.*$/GRUB_CMDLINE_LINUX_DEFAULT=\"quiet splash\"/" /etc/default/grub || (>&2 echo "Failed sed 1"; exit 1)
sudo update-alternatives --install /usr/share/plymouth/themes/default.plymouth default.plymouth /usr/share/plymouth/themes/flame/flame.plymouth 100 || (>&2 echo "Failed install"; exit 1)
echo 1 | sudo update-alternatives --config default.plymouth || (>&2 echo "Failed config"; exit 1)
sudo update-initramfs -u || (>&2 echo "Failed update"; exit 1)

