#!/bin/sh

h=/home/matthieu
rm -rf $h/Desktop $h/Documents $h/Music $h/Pictures $h/Public $h/Templates $h/Videos && echo "Cleared home." || >&2 echo "Failed home cleanup."


