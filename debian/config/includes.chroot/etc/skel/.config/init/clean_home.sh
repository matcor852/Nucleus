#!/bin/sh

rm -rf ~/Desktop ~/Documents ~/Music ~/Pictures ~/Public ~/Templates ~/Videos && echo "Cleared home." || >&2 echo "Failed home cleanup."

