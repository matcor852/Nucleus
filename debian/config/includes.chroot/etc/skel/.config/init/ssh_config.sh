#!/bin/sh

set -e

ssh-keygen -a 100 -t ed25519 -f ~/.ssh/id_ed25519 -N ''
xsel -b < ~/.ssh/id_ed25519.pub
echo -e "\n\033[0;32mSSH public key saved to clipboard.\033[0m"

