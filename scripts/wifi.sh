#!/bin/bash

IFACE=$(nmcli -t -f device,type dev | awk -F: '$2=="wifi"{print $1; exit}')
CURRENT=$(nmcli -t --escape no -f active,ssid dev wifi | awk -F: '$1=="yes"{print $2; exit}')

declare -a LABELS SSIDS
declare -A SEEN

while IFS=: read -r active ssid signal security; do
    [[ -z "$ssid" ]] && continue
    if [[ -n "${SEEN[$ssid]}" ]]; then
        [[ "$active" != "yes" ]] && continue
        # Active entry found after a duplicate — update the existing label
        for i in "${!SSIDS[@]}"; do
            if [[ "${SSIDS[$i]}" == "$ssid" ]]; then
                LABELS[$i]="${LABELS[$i]/  / *}"
                break
            fi
        done
        continue
    fi
    SEEN[$ssid]=1

    if   (( signal >= 75 )); then bars="▂▄▆█"
    elif (( signal >= 50 )); then bars="▂▄▆_"
    elif (( signal >= 25 )); then bars="▂▄__"
    else                          bars="▂___"
    fi

    [[ -n "$security" && "$security" != "--" ]] && lock="  " || lock=""
    [[ "$active" == "yes" ]] && prefix="* " || prefix="  "

    LABELS+=("${prefix}${ssid}  ${bars}${lock}")
    SSIDS+=("$ssid")
done < <(nmcli -t --escape no -f active,ssid,signal,security dev wifi list)

CHOSEN=$(printf '%s\n' "${LABELS[@]}" | rofi -dmenu -i -p "WiFi")
[[ -z "$CHOSEN" ]] && exit 0

SSID=""
for i in "${!LABELS[@]}"; do
    [[ "${LABELS[$i]}" == "$CHOSEN" ]] && SSID="${SSIDS[$i]}" && break
done
[[ -z "$SSID" ]] && exit 1

if [[ "$SSID" == "$CURRENT" ]]; then
    nmcli dev disconnect "$IFACE"
else
    if ! nmcli dev wifi connect "$SSID"; then
        notify-send -a "wifi" -h "string:x-dunst-stack-tag:wifi" -u critical "WiFi" "Failed to connect to $SSID"
    fi
fi
