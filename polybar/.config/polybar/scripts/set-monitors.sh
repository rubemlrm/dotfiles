#!/usr/bin/env bash

killall -q polybar

if [[ "$HOSTNAME" == "DojoDesktop" ]]; then
    MONITOR="DP-0" polybar -q main -c "$HOME/.config/polybar/config.ini" &
    MONITOR="DP-4" polybar -q main -c "$HOME/.config/polybar/config.ini" &
else
    MONITOR="DP-2" polybar -q main -c "$HOME/.config/polybar/config.ini" &
fi
