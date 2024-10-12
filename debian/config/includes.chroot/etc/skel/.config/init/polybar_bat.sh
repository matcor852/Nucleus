#!/bin/sh

ADAPTER=$(ls -1 /sys/class/power_supply/ | sort | head -n 1)
BAT=$(ls -1 /sys/class/power_supply/ | sort | tail -n 1)

sed -i "s/^battery =.*$/battery = $BAT/" ~/.config/polybar/config.ini || (>&2 echo "Failed sed 1"; exit 1)
sed -i "s/^adapter =.*$/adapter = $ADAPTER/" ~/.config/polybar/config.ini || (>&2 echo "Failed sed 2"; exit 1)

mountpoint /home > /dev/null 2>&1
if [ "$?" -ne 0 ]; then
    sed -i "s/^mount-1 = \/home.*$//" ~/.config/polybar/config.ini || (>&2 echo "Failed sed 3"; exit 1)
fi

