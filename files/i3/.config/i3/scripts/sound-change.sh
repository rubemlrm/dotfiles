#!/bin/bash

function get_volume {
    pactl get-sink-volume @DEFAULT_SINK@ | cut -d'/' -f2 | grep % | cut -d "%" -f 1
}

function is_mute {
    pactl get-sink-volume @DEFAULT_SINK@ | grep '%' | cut -d '[' -f 2 | cut -d '%' -f 1 | cut -d '/' -f 2
}

function send_notification {
    volume=$(get_volume)
    dunstify dunstify --replace 1 -t 3000  --icon=daytime-sunset-symbolic.symbolic -u normal "Current Volume: $volume%"
}

case $1 in
    up)
		CURRENT_VOLUME=$(get_volume)
		if [[ "$CURRENT_VOLUME" -lt 100 ]]; then
			# Set the volume on (if it was muted)
			pactl set-sink-volume @DEFAULT_SINK@ +5% > /dev/null
		fi
		send_notification
	;;
    down)
		CURRENT_VOLUME=$(get_volume)
		if [[ "$CURRENT_VOLUME" -gt 0 ]]; then
			pactl set-sink-volume @DEFAULT_SINK@ -5% > /dev/null
		fi
		send_notification
	;;
    toggle)
    	# Toggle mute
		pactl set-sink-mute @DEFAULT_SINK@ toggle
		if is_mute ; then
			dunstify -t 3000 -r 2593 -u normal "Mute"
		else
			send_notification
		fi
	;;
	*)
		volume=$(get_volume)
		echo "$volume%"
esac
