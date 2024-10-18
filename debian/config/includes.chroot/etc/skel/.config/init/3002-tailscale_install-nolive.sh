#!/bin/sh

#set -e

curl -fsSL https://tailscale.com/install.sh | sudo sh || (>&2 echo "Failed install"; exit 1)
sudo systemctl stop tailscaled
sudo systemctl disable tailscaled

