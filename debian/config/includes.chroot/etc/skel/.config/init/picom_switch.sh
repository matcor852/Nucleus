#!/bin/sh

#set -e

cat /proc/cpuinfo | grep "hypervisor" &> /dev/null
if [ "$?" -ne 0 ]; then
    echo -e "\nblur-method = \"dual_kawase\"\nblur-size = 9\nbackend = \"glx\"" >> ~/.config/picom/picom.conf
fi


