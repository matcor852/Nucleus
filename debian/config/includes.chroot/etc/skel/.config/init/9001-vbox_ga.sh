#!/bin/sh

set -e

# exit if not running inside virtualbox
sudo dmidecode | grep -qi virtualbox || exit 0

sudo apt install build-essential dkms linux-headers-$(uname -r)

# get virtualbox version to match guest additions; dmidecode type 11 : OEM strings
ga_version="$(sudo dmidecode --type 11 | sed -nE 's/.*vboxVer_([0-9.]+).*/\1/p' | head -1)"

wget -nv -O /tmp/VBoxGuestAdditions.iso https://download.virtualbox.org/virtualbox/"$ga_version"/VBoxGuestAdditions_"$ga_version".iso

mp='/mnt_ga'
[ -d "$mp" ] || sudo mkdir "$mp"
mountpoint -q "$mp" && sudo umount -f "$mp"
sudo mount /tmp/VBoxGuestAdditions.iso "$mp"
cd "$mp"
sudo ./VBoxLinuxAdditions.run --nox11 || true
sudo rcvboxadd quicksetup all
sudo rcvboxadd reload
cd
sudo umount -qf "$mp" || sudo umount -l "$mp"
sudo rm -r "$mp"

