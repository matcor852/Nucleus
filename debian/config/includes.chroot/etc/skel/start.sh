#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Must run as root." 1>&2
    exit 1
fi

# Check for internet access
wget -q --spider http://google.com
[ "$?" -ne 0 ] && echo "No internet access." && exit 2

HOME=/home/nucleuser
spin='◐◓◑◒'

# init scripts in .config/init/*.sh
for init_script in ~/.config/init/*.sh; do
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

if [ -z "$(ls -A ~/.config/init)" ]; then
    rm -rf ~/.config/init
    rm README.md
    rm -- "$0"
    # rm setup.log
fi

i3-msg restart > /dev/null 2>&1
# sudo tailscale up --ssh

