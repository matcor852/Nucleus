#!/bin/sh

set -e

cat /proc/cpuinfo | grep "hypervisor" &> /dev/null
if [ "$?" -e 0 ]; then
    echo -e "\nblur-method = \"dual_kawase\"\nblur-size = 9\nbackend = \"glx\"" >> /home/matthieu/.config/picom/picom.conf
fi

echo "Updated picom blur."

