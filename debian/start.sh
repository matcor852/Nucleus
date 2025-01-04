#!/bin/bash

set -e

## Permission check
if [ "$EUID" -ne 0 ]; then
    >&2 echo "Must run as root."
    exit 1
fi

options=$(getopt -o "t" --long "test" -- "$@")
eval set -- "$options"

testing=false
for opt; do
    case "$opt" in
        -t|--test)
            testing=true
            shift 1
            ;;
    esac
done


## .deb installs
[ -d config/packages.chroot ] || mkdir config/packages.chroot
wget -nv -O config/packages.chroot/chrome_all.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb


## Live build
sudo lb clean
sudo lb config
time sudo lb build


## Check created iso
if [ ! -f nucleus-amd64.iso ]; then
    >&2 echo -e "\n\tBuild failed.\n"
    exit 7
fi


if $testing; then
    ## VM testing
    dpkg -s qemu-utils | grep -q installed || sudo apt install -y qemu-utils
    dpkg -s qemu-system-x86 | grep -q installed || sudo apt install -y qemu-system-x86
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
fi

