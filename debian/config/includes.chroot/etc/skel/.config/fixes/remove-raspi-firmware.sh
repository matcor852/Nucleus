#!/bin/bash

set -e

echo "Are you getting errors about:"
echo "    - raspi-firmware: missing /boot/firmware, did you forget to mount it ?"
echo "    - Package linux-image-* is not configured yet"
read -r -p "while trying to run apt upgrade ? [y/N] " -n 1; echo
[[ "$REPLY" =~ ^[yY]$ ]] || exit 0

read -r -p "Are you really sure ? [y/N] " -n 1; echo
[[ "$REPLY" =~ ^[yY]$ ]] || exit 0

sudo rm /etc/{initramfs/post-update.d/,kernel/{postinst.d/,postrm.d/}}z50-raspi-firmware
sudo apt purge raspi-firmware
sudo rm -rf /boot/firmware

