#!/bin/env bash

if [[ "$HOSTNAME" == "DojoLaptop" ]]; then
    xrandr --auto
	   xrandr --output eDP-1 --primary --mode 1920x1080 --rotate normal \
           --output DP-1 --off --output HDMI-1 --off \
           --output DP-2 --off \
           --output DP-3 --off \
           --output DP-4 --off
fi 

if [[ "$HOSTNAME" == "DojoDesktop" ]]; then
    xrandr --output DP-0 --primary --mode 1920x1080 --pos 1920x0 --rotate normal \          --output DP-1 --off \ 
          --output DP-2 --mode 1920x1080 --pos 0x0 --rotate normal \ 
          --output DP-3 --off --output HDMI-0 --off \ 
          --output DP-4 --off --output DP-5 --off
else
    echo "dummy"
fi
