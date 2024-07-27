#!/bin/sh

set -e

url='https://discord.com/api/download?platform=linux&format=deb'
curl -L -o /tmp/discord.deb "$url"
sudo apt install -y /tmp/discord.deb

sudo systemctl enable --now discord_renew.service
echo -e "\033[0;32mInstalled Discord and updater.\033[0m"


