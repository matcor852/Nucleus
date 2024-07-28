#!/bin/bash

set -e

if [ "$EUID" -ne 0 ]; then
    echo "Must run as root."
    exit 1
fi

sudo lb clean
lb config
time sudo lb build

[ -f nucleus-amd64.iso ] || exit 7

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

