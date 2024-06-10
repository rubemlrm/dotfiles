#!/bin/sh

vpn="$(nmcli -t -f name,type connection show --order name --active 2>/dev/null | grep vpn | head -1 | cut -d ':' -f 1)"
openfortivpn=$(pgrep -a openfortivpn$ | head -n 1 | awk '{print $NF }' | rev | cut -d '/' -f 1 | rev)

if [ -n "$vpn" ]; then
	echo ""
elif [ -n "$openfortivpn" ]; then
     echo ""
else
	echo ""
fi
