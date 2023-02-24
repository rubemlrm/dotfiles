#!/bin/env bash
if [[ "$HOSTNAME" == "rmotalaptop" ]]; then
    xrandr --auto
    TOTAL_MONITORS=$(DISPLAY=:0 xrandr -q | grep ' connected' | wc -l)
    if [[ $TOTAL_MONITORS -eq "3" ]]; then
	echo "setup rmotalaptop 3 monitors"
       xrandr --output eDP-1 --off \
           --output DP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal \
           --output HDMI-1 --off \
           --output DP-2 --off \
           --output DP-3 --mode 1920x1080 --pos 1920x0 --rotate normal \
           --output DP-4 --off
    fi
    if [[ $TOTAL_MONITORS -eq "2" ]]; then
        echo "set rmotalaptop 2 monitors"
	   xrandr --output eDP-1 --primary --mode 1920x1200 --pos 1052x2160 --rotate normal \
           --output DP-1 --off --output HDMI-1 --off
           --output DP-2 --off
           --output DP-3 --mode 3840x2160 --pos 0x0 --rotate normal
           --output DP-4 --off
   fi
elif [[ "$HOSTNAME" == "DojoDesktop" ]]; then
    xrandr --output DP-0 --mode 1920x1080 --pos 4480x0 --rotate normal --output DP-1 --off --output DP-2 --primary --mode 1920x1080 --pos 2560x0 --rotate normal --output DP-3 --off --output HDMI-0 --off --output DP-4 --mode 2560x1440 --pos 0x0 --rotate normal --output DP-5 --off
else
    echo "teste"
fi
