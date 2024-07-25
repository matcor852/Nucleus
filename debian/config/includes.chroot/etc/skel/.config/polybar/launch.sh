#!/bin/bash

killall -q polybar
polybar atome 2>&1 | tee -a /tmp/polybar_atome.log & disown

