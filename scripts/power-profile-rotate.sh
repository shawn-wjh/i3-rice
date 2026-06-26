#!/bin/bash
current=$(powerprofilesctl get 2>/dev/null || grep -i "^Profile=" /var/lib/power-profiles-daemon/state.ini | cut -d= -f2 | tr -d '[:space:]')

case "$current" in
    performance) next="balanced" ;;
    balanced)    next="power-saver" ;;
    power-saver) next="performance" ;;
    *)           next="balanced" ;;
esac

powerprofilesctl set "$next"
notify-send -a "power-profile" -h string:x-dunst-stack-tag:power-profile "Power Profile" "$next"
