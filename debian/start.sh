#!/bin/bash

set -e

if [ "$EUID" -ne 0 ]; then
    echo "Must run as root."
    exit 1
fi

sudo lb clean
lb config
time sudo lb build || exit 7

sudo qemu-img create /home/matthieu/Data/nucleus_test.img 16G
sudo qemu-system-x86_64 -enable-kvm \
    -smp 4 \
    -m 8192 \
    -cpu host \
    -vga virtio \
    -boot order=cd \
    -cdrom nucleus-amd64.iso \
    -hda /home/matthieu/Data/nucleus_test.img \
    -display gtk,window-close=off,grab-on-hover=off,zoom-to-fit=off

