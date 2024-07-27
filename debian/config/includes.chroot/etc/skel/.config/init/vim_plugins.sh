#!/bin/sh

curl -fLo ~/.config/vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim > /dev/null
vim -es -u ~/.vimrc -i NONE -c "PlugInstall" -c "qa"
#make -C ~/.config/vim/plugged/vim-hexokinase hexokinase

echo -e "\033[0;32mInstalled vim plugins.\033[0m"

