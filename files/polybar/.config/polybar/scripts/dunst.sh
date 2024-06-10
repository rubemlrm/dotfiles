#!/bin/sh

readonly command="$1"
readonly maxDisplayNumber="$2"

display_history() {
    history=$(dunstctl history)

    if [ "$maxDisplayNumber" != "" ] ; then
        maxNumber=$maxDisplayNumber
    else
        maxNumber=$(echo "$history" | jq .'data[0] | length')
    fi

    for (( i=0; i< "$maxNumber"; $((i+1)) ))
    do
        id=$(echo "$history" | jq ."data[0][$i].id.data")
        dunstctl history-pop "$id"
    done
}

close_history() {
    dunstctl close-all
}


case "$command" in
    --display-history)
        display_history "$maxDisplayNumber"
    ;;

    --close-history)
        close_history
    ;;
    --toggle)
        dunstctl set-paused toggle
        ;;
    *)
        if [ "$(dunstctl is-paused)" = "true" ]; then
            echo ""
        else
            echo ""
        fi
        ;;
esac
