#!/bin/sh

git clone https://github.com/zsh-users/zsh-autosuggestions ~/.config/oh-my-zsh/custom/plugins/zsh-autosuggestions > /dev/null
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.config/oh-my-zsh/custom/plugins/zsh-syntax-highlighting > /dev/null

chsh -s $(which zsh) matthieu || exit 1

if [ "$(tail -n 1 ~/.bashrc)" != "exec zsh" ]; then
    echo -e "\nexec zsh" >> ~/.bashrc || exit 1
fi

echo -e "\033[0;32mSet ZSH default.\033[0m"

