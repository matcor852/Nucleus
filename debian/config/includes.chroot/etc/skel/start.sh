#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Must run as root." 1>&2
    exit 1
fi

# Check for internet access
wget -q --spider http://google.com
[ "$?" -ne 0 ] && echo "No internet access." && exit 2

HOME=/home/matthieu

# init scripts in .config/init/*.sh
for init_script in .config/init/*.sh; do
    bash "$init_script"
done

# SSH config
ssh-keygen -a 100 -t ed25519 -f ~/.ssh/id_ed25519 -N ''
xsel -b < ~/.ssh/id_ed25519.pub
echo -e "\033[0;32mSSH public key saved to clipboard.\033[0m"

# Init cleanup
rm -rf ~/.config/init
rm README.md
rm -- "$0"

