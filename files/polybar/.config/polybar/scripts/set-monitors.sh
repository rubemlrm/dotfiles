#!/usr/bin/env bash

killall -q polybar

if [[ "$HOSTNAME" == "DojoLaptop" ]]; then
    export NETWORK_CARD="wlp0s20f3"
 	MONITOR="eDP-1" polybar -q main -c "$HOME/.config/polybar/config.ini" &
fi

if [[ "$HOSTNAME" == "DojoDesktop" ]]; then
    MONITOR="DP-0" polybar -q main -c "$HOME/.config/polybar/config.ini" &
    MONITOR="DP-2" polybar -q main -c "$HOME/.config/polybar/config.ini" &
else
    MONITOR="DP-2" polybar -q main -c "$HOME/.config/polybar/config.ini" &
fi
