#!/bin/sh

git clone https://github.com/zsh-users/zsh-autosuggestions ~/.config/oh-my-zsh/custom/plugins/zsh-autosuggestions > /dev/null
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.config/oh-my-zsh/custom/plugins/zsh-syntax-highlighting > /dev/null

chsh -s $(which zsh) "$USER" || (>&2 echo "Failed shell change"; exit 1)

if [ "$(tail -n 1 ~/.bashrc)" != "exec zsh" ]; then
    echo -e "\nexec zsh" >> ~/.bashrc || (>&2 echo "Failed bash plug"; exit 1)
fi

