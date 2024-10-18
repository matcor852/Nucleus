#!/bin/bash

# Check root access
if [ "$EUID" -ne 0 ]; then
    >&2 echo "Must run as root."
    exit 1
fi

if [ "$USER" = 'root' ]; then
    >&2 echo "Must pass '--preserve-env=USER' to cmd, see README.md"
    exit 1
fi
##

# Check for internet access
wget -q --spider http://google.com
[ "$?" -ne 0 ] && echo "No internet access." && exit 2
##


HOME=/home/"$USER"
spin='◐◓◑◒'
running_live=true; grep -q "$(basename $(df ~ | tail -1 | awk '{printf $1;}'))" /proc/partitions && running_live=false

# init scripts in .config/init/*.sh
for init_script in $(ls ~/.config/init/*.sh | sort -g); do
    $running_live && [[ "$init_script" =~ .*nolive.sh ]] && rm "$init_script" && continue
    echo -e "\n\n================================ $(basename $init_script .sh) ================================\n" >> setup.log
    bash "$init_script" >> setup.log 2>&1 &
    pid=$!
    i=0
    while kill -0 $pid 2>/dev/null
    do
        i=$(( (i+1) %${#spin} ))
        printf "\r$(basename $init_script .sh): ${spin:$i:1} "
        sleep .2
    done
    wait "$pid"
    exc="$?"
    echo -en "\r$(basename $init_script .sh): "
    if [ "$exc" -ne 0 ]; then
        echo -e "\033[0;31mKO\033[0m"
    else
        echo -e "\033[0;32mOK\033[0m"
        rm "$init_script"
    fi
done
##

if [ -z "$(ls -A ~/.config/init)" ]; then
    rm -rf ~/.config/init
    rm README.md
    rm -- "$0"
    rm setup.log
    sed -i "s/\[ -f finalize.sh \] && sudo --preserve-env=USER .\/finalize.sh && exec zsh//" .bashrc
fi


# User update
if ! $running_live; then
    read -r -p "Update username & password ? [y/N] " -n 1; echo
    if [[ "$REPLY" =~ ^[yY]$ ]]; then

        # Get new credentials
        read -p "New username (replacing '$USER'): " newu
        reg_newu="^[a-z][-a-z0-9]*$"
        while [[ ! "$newu" =~ $reg_newu ]] || getent passwd "$newu" >/dev/null 2>&1; do
            >&2 echo "Invalid username, already exists or do not match $reg_newu"
            read -p "New username: " newu
        done
        fn=$(getent passwd "$USER" | cut -d : -f 5 | cut -d , -f 1)
        read -p "New fullname (replacing '$fn'): " newfn
        while [ -z "$newfn" ]; do
            >&2 echo "Invalid empty fullname"
            read -p "New fullname: " newfn
        done

        read -p "Email address (used in git config for ex.): " newmail
        while [ -z "$newmail" ]; do
            >&2 echo "Invalid empty email"
            read -p "Email address: " newmail
        done

        read -s -p "New password: " newpass; echo
        read -s -p "Repeat new password: " newpass_again; echo
        while [ "$newpass" != "$newpass_again" ] || [ -z "$newpass" ]; do
            >&2 echo "Passwords do not match or empty"
            read -s -p "New password: " newpass; echo
            read -s -p "Repeat new password: " newpass_again; echo
        done

        read -r -p "Update root password as well ? [y/N] " -n 1 update_root; echo
        ##

        # Propagate
        sed -i "s/email = .*$/email = $newmail/" .gitconfig
        sed -i "s/name = .*$/name = $newfn/" .gitconfig
        sed -i "s/$USER/$newu/g" .config/rofi/config.rasi
        sed -i "s/$USER/$newu/g" .zshrc
        sed -i "s/$USER/$newu/g" .cwd 2>/dev/null

        sudo sed -i "s/$USER/$newu/g" /etc/systemd/system/discord_renew.service
        sudo chfn -f "$newfn" "$USER"
        sudo su -c "\
            sed -i \"s/$USER/$newu/g\" /etc/group \
            && sed -i \"s/$USER/$newu/g\" /etc/shadow \
            && sed -i \"s/$USER/$newu/g\" /etc/passwd \
            && mv /home/\"$USER\"/ /home/\"$newu\" \
            && echo \"$newu    ALL=(ALL:ALL) ALL\" > /etc/sudoers.d/\"$newu\" \
            && ([[ \"$update_root\" =~ ^[yY]$ ]] && echo -e \"$newu:$newpass\nroot:$newpass\" || echo \"$newu:$newpass\") | chpasswd"
        ##
        
        sudo find / -xtype l -lname "*$USER*" -exec bash -c 'ln -nsf "$(readlink "$0" | sed s/$1/$2/g)" "$(echo "$0" | sed s/$1/$2/g)"' {} "$USER" "$newu" \; >/dev/null 2>&1

        sudo reboot
    fi
fi
##

i3-msg restart > /dev/null 2>&1
# sudo tailscale up --ssh

