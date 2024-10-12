#!/bin/sh

#set -e

sudo sed -i "s/^#background=.*$/background=\/usr\/share\/wallpapers\/atomic.png/" /etc/lightdm/lightdm-gtk-greeter.conf || (>&2 echo "Failed sed 1"; exit 1)
sudo sed -i "s/^#theme-name=.*$/theme-name=Skeuos-Blue-Dark/" /etc/lightdm/lightdm-gtk-greeter.conf || (>&2 echo "Failed sed 2"; exit 1)
sudo sed -i "s/^#icon-theme-name=.*$/icon-theme-name=Skeuos-Blue-Dark/" /etc/lightdm/lightdm-gtk-greeter.conf || (>&2 echo "Failed sed 3"; exit 1)
sudo sed -i "s/^#xft-antialias=.*$/xft-antialias=true/" /etc/lightdm/lightdm-gtk-greeter.conf || (>&2 echo "Failed sed 4"; exit 1)
sudo sed -i "s/^#indicators=.*$/indicators=~host;~spacer;~clock;~spacer;~session;~power/" /etc/lightdm/lightdm-gtk-greeter.conf || (>&2 echo "Failed sed 5"; exit 1)

