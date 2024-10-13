#!/bin/sh

curl -fLo ~/.config/vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim > /dev/null
vim -es -u ~/.vimrc -i NONE -c "PlugInstall" -c "qa"
exit 0

