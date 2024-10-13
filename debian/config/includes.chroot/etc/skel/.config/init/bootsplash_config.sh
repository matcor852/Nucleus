#!/bin/sh

#set -e

sudo sed -i "s/^GRUB_CMDLINE_LINUX_DEFAULT=.*$/GRUB_CMDLINE_LINUX_DEFAULT=\"quiet splash\"/" /etc/default/grub || (>&2 echo "Failed sed 1"; exit 1)
sudo plymouth-set-default-theme -R flame || (>&2 echo "Failed setting theme"; exit 1)
sudo dpkg -r desktop-base

