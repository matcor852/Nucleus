#!/bin/sh

#set -e

runuser -l "$USER" -c "ssh-keygen -a 100 -t ed25519 -f ~/.ssh/id_ed25519 -N '' -C \"@Nucleus\" <<<y >/dev/null 2>&1" || (>&2 echo "Failed keygen"; exit 1)
xsel -b < ~/.ssh/id_ed25519.pub
echo -e "\n\033[0;32mSSH public key saved to clipboard.\033[0m"

