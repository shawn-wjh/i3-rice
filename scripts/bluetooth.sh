#!/bin/bash

declare -A CONNECTED
while IFS= read -r line; do
    [[ "$line" =~ ^Device\ ([0-9A-F:]+)\  ]] && CONNECTED["${BASH_REMATCH[1]}"]=1
done < <(bluetoothctl devices Connected)

declare -a LABELS MACS
LABELS+=("  Scan")
MACS+=("__SCAN__")

while IFS= read -r line; do
    [[ "$line" =~ ^Device\ ([0-9A-F:]+)\ (.+)$ ]] || continue
    mac="${BASH_REMATCH[1]}"
    name="${BASH_REMATCH[2]}"
    [[ "${CONNECTED[$mac]}" == 1 ]] && LABELS+=("* $name") || LABELS+=("  $name")
    MACS+=("$mac")
done < <(bluetoothctl devices)

CHOSEN=$(printf '%s\n' "${LABELS[@]}" | rofi -dmenu -i -p "Bluetooth")
[[ -z "$CHOSEN" ]] && exit 0

MAC=""
for i in "${!LABELS[@]}"; do
    [[ "${LABELS[$i]}" == "$CHOSEN" ]] && MAC="${MACS[$i]}" && break
done
[[ -z "$MAC" ]] && exit 1

if [[ "$MAC" == "__SCAN__" ]]; then
    notify-send -a "bluetooth" -t 5500 -h "string:x-dunst-stack-tag:bluetooth" "Bluetooth" "Scanning for 5 seconds..."
    bluetoothctl --timeout 5 scan on
    exec "$0"
fi

device_name="${CHOSEN:2}"

if [[ "${CONNECTED[$MAC]}" == 1 ]]; then
    bluetoothctl disconnect "$MAC"
else
    bluetoothctl connect "$MAC" || \
        notify-send -a "bluetooth" -t 2000 -h "string:x-dunst-stack-tag:bluetooth" "Bluetooth" "Failed to connect to $device_name"
fi