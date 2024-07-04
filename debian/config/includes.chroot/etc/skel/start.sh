#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Must run as root." 1>&2
    exit 1
fi

# init scripts in .config/init/*.sh
for init_script in .config/init/*.sh; do
    bash "$init_script"
done

# SSH config
ssh-keygen -a 100 -t ed25519 -f /home/matthieu/.ssh/id_ed25519 -N ''
xsel -b < /home/matthieu/.ssh/id_ed25519.pub
echo "SSH public key saved to clipboard."

# Init cleanup
rm -rf .config/init
rm README.md
rm -- "$0"

