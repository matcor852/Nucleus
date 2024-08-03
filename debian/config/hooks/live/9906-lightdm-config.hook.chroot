#!/bin/sh

set -e

sed -i "s/^.*greeter-hide-users=.*$/greeter-hide-users=false/" /etc/lightdm/lightdm.conf
sed -i "s/^.*greeter-setup-script=.*$/greeter-setup-script=\/usr\/bin\/numlockx on/" /etc/lightdm/lightdm.conf

echo "Updated LightDM config."

