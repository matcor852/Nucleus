#!/bin/sh

set -e

url='https://discord.com/api/download?platform=linux&format=deb'
curl -L -o /tmp/discord.deb "$url"
sudo apt-get install -y /tmp/discord.deb


