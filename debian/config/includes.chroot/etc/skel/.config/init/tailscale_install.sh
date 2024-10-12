#!/bin/sh

#set -e

curl -fsSL https://tailscale.com/install.sh | sudo sh || (>&2 echo "Failed install"; exit 1)

