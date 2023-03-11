#!/usr/bin/env bash

killall -q polybar

if [[ "$HOSTNAME" == "rmotalaptop" ]]; then
    export NETWORK_CARD="wlp0s20f3"
    TOTAL_MONITORS=$(DISPLAY=:0 xrandr -q | grep ' connected' | wc -l)
    if [[ $TOTAL_MONITORS -eq "3" ]]; then
       MONITOR="DP-1" polybar -q main -c "$HOME/.config/polybar/config.ini" &
       MONITOR="DP-3" polybar -q main -c "$HOME/.config/polybar/config.ini" &
    elif [[ $TOTAL_MONITORS -eq "2" ]]; then
   	MONITOR="eDP-1" polybar -q main -c "$HOME/.config/polybar/config.ini" &
        MONITOR="DP-3" polybar -q main -c "$HOME/.config/polybar/config.ini" &
    else
 	MONITOR="eDP-1" polybar -q main -c "$HOME/.config/polybar/config.ini" &
    fi
elif [[ "$HOSTNAME" == "DojoDesktop" ]]; then
    MONITOR="DP-0" polybar -q main -c "$HOME/.config/polybar/config.ini" &
    MONITOR="DP-4" polybar -q main -c "$HOME/.config/polybar/config.ini" &
else
    MONITOR="DP-2" polybar -q main -c "$HOME/.config/polybar/config.ini" &
fi
