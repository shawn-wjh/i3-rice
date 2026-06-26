#!/bin/bash
NOTIFIED_LOW=0
NOTIFIED_CRITICAL=0

# Auto-detect the first battery (BAT0, BAT1, macsmc-battery, ...). Override with
# $BATTERY (the basename under /sys/class/power_supply).
BATTERY="${BATTERY:-$(for b in /sys/class/power_supply/*/capacity; do
    [ -e "$b" ] || continue
    d=$(dirname "$b")
    [ "$(cat "$d/type" 2>/dev/null)" = "Battery" ] && { basename "$d"; break; }
done)}"

# No battery (e.g. desktop): nothing to watch.
[ -n "$BATTERY" ] && [ -r "/sys/class/power_supply/$BATTERY/capacity" ] || exit 0

while true; do
    LEVEL=$(cat "/sys/class/power_supply/$BATTERY/capacity")
    STATUS=$(cat "/sys/class/power_supply/$BATTERY/status")

    if [ "$STATUS" = "Discharging" ]; then
        if [ "$LEVEL" -le 10 ] && [ "$NOTIFIED_CRITICAL" -eq 0 ]; then
            rofi -e "Battery Critical — ${LEVEL}% remaining" &
            NOTIFIED_CRITICAL=1
        elif [ "$LEVEL" -le 20 ] && [ "$NOTIFIED_LOW" -eq 0 ]; then
            rofi -e "Battery Low — ${LEVEL}% remaining" &
            NOTIFIED_LOW=1
        fi
    else
        NOTIFIED_LOW=0
        NOTIFIED_CRITICAL=0
    fi

    sleep 5
done
