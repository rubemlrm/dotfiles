#!/bin/env bash

if [[ "$HOSTNAME" == "DojoDesktop" ]]; then
    xrandr --output DP-0 --primary --mode 1920x1080 --pos 0x0 --rotate normal \
        --output DP-1 --off \
        --output DP-2 --off \
        --output DP-3 --off \
        --output HDMI-0 --off \
        --output DP-4 --mode 1920x1080 --pos 1920x0 --rotate normal \
        --output DP-5 --off
else
    echo "dummy"
fi
