#!/bin/bash
# Usage: volume-notify.sh [up|down|mute]

STEP="${2:-10}"
case "$1" in
    up)   pactl set-sink-volume @DEFAULT_SINK@ +${STEP}% ;;
    down) pactl set-sink-volume @DEFAULT_SINK@ -${STEP}% ;;
    mute) pactl set-sink-mute @DEFAULT_SINK@ toggle ;;
esac

VOL=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+(?=%)' | head -1)
ICON=$(pactl get-sink-mute @DEFAULT_SINK@ | grep -q yes && echo $'\uf026' || echo $'\uf028')

notify-send -a "volume" -t 1500 \
    -h "int:value:$VOL" \
    -h "string:x-dunst-stack-tag:volume" \
    "$ICON Volume" "${VOL}%"
