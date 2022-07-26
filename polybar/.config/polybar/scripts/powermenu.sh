#!/usr/bin/env bash

## Author  : Aditya Shakya
## Mail    : adi1090x@gmail.com
## Github  : @adi1090x
## Twitter : @adi1090x

dir="~/.config/rofi"
uptime=$(uptime -p | sed -e 's/up //g')

rofi_command="rofi -theme $dir/themes/powermenu.rasi"

# Options
shutdown=" Shutdown"
reboot=" Restart"
lock=" Lock"
suspend=" Sleep"
logout=" Logout"

# Variable passed to rofi
options="$lock\n$suspend\n$logout\n$reboot\n$shutdown"

chosen="$(echo -e "$options" | $rofi_command -p "Uptime: $uptime" -dmenu -selected-row 0)"
case $chosen in
    $shutdown)
		systemctl poweroff
        ;;
    $reboot)
		systemctl reboot
        ;;
    $lock)
        sh ~/.config/bspwm/scripts/i3lock-fancy.sh --desktop
        ;;
    $suspend)
		mpc -q pause
		amixer set Master mute
		systemctl suspend
        ;;
    $logout)
		bspc quit
        ;;
esac
