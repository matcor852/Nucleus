#!/bin/bash

set -e


## Permission check
if [ "$EUID" -ne 0 ]; then
    echo "Must run as root."
    exit 1
fi


## .deb installs
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P config/packages.chroot


## Live build
sudo lb clean
lb config
time sudo lb build


## Check created iso
[ -f nucleus-amd64.iso ] || exit 7


## VM testing
qemu-img create nucleus_test.img 16G
qemu-system-x86_64 -enable-kvm \
    -smp 4 \
    -m 8192 \
    -cpu host \
    -vga virtio \
    -boot order=cd \
    -cdrom nucleus-amd64.iso \
    -display gtk,window-close=off,grab-on-hover=off,zoom-to-fit=off \
    -drive file=nucleus_test.img,format=raw,index=0,media=disk

