#!/bin/sh

set -e

sudo systemctl stop postgresql
sudo systemctl disable postgresql

