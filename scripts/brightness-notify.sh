#!/bin/bash
# Usage: brightness-notify.sh [up|down] [step%]

STEP="${2:-10}"
case "$1" in
    up)   brightnessctl set +${STEP}% ;;
    down) brightnessctl set ${STEP}%- ;;
esac

BRIGHTNESS=$(brightnessctl info | grep -oP '\(\K\d+(?=%)')

notify-send -a "brightness" -t 1500 \
    -h "int:value:$BRIGHTNESS" \
    -h "string:x-dunst-stack-tag:brightness" \
    $' Brightness' "${BRIGHTNESS}%"
