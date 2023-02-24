#!/bin/sh

if [ "$(pgrep -x redshift)" ]; then
    localization=$(curl -s "https://location.services.mozilla.com/v1/geolocate?key=geoclue" | jq -r '"\(.location.lat):\(.location.lng)"')
    temp=$(redshift -l "$localization" -p 2> /dev/null | grep temp | cut -d ":" -f 2 | tr -dc "[:digit:]")
    echo " ${temp}K"
else
    echo ""
fi
