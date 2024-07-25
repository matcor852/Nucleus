#!/bin/sh

ADAPTER=$(ls -1 /sys/class/power_supply/ | sort | head -n 1)
BAT=$(ls -1 /sys/class/power_supply/ | sort | tail -n 1)

sed -i "s/^battery =.*$/battery = $BAT/" ~/.config/polybar/config.ini
sed -i "s/^adapter =.*$/adapter = $ADAPTER/" ~/.config/polybar/config.ini

