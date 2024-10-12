#!/bin/sh

#set -e

xset s off || (>&2 echo "Failed xset 1"; exit 1)
xset -dpms || (>&2 echo "Failed xset 2"; exit 1)

