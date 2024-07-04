#!/bin/sh

git clone https://github.com/zsh-users/zsh-autosuggestions /home/matthieu/.config/oh-my-zsh/custom/plugins/zsh-autosuggestions > /dev/null
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /home/matthieu/.config/oh-my-zsh/custom/plugins/zsh-syntax-highlighting > /dev/null

chsh -s $(which zsh) matthieu

if [ "$(tail -n 1 /home/matthieu/.bashrc)" != "exec zsh" ]; then
    echo -e "\nexec zsh" >> /home/matthieu/.bashrc
fi

echo "Set ZSH default."

