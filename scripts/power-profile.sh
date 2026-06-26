#!/bin/bash
while true; do
    profile=$(powerprofilesctl get 2>/dev/null || grep -i "^Profile=" /var/lib/power-profiles-daemon/state.ini | cut -d= -f2 | tr -d '[:space:]')
    case "$profile" in
        performance) echo -n "MAX" ;;
        balanced)    echo -n "BAL" ;;
        power-saver) echo -n "ECO" ;;
        *)           echo -n "???" ;;
    esac > /tmp/i3_power_profile
    sleep 5
done
