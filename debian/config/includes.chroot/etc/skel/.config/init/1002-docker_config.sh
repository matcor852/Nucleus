#!/bin/sh

sudo usermod -aG docker "$USER"
newgrp docker
sudo systemctl stop docker
sudo systemctl disable docker

