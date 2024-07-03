#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Must run as root."
    exit 1
fi

sudo lb clean
lb config
sudo lb build
qemu-system-x86_64 -enable-kvm -cpu host -m 2048 -smp 4 -drive media=cdrom,format=raw,file=live-image-amd64.iso -boot d

