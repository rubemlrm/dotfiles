#!/bin/bash

function get_brightness {
    brightnessctl -m | cut -d',' -f4
}

function send_notification {
    dunstify dunstify --replace 1 -t 3000  --icon=daytime-sunset-symbolic.symbolic -u normal "Current Volume: $volume%"
}

case $1 in
    up)
		brightnessctl set +10% > /dev/null
		send_notification
	;;
    down)
		brightnessctl set 10%-  > /dev/null
		send_notification
	;;
esac
