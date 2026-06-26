#!/bin/bash

declare -a LABELS ACTIONS
LABELS+=("  WiFi")
ACTIONS+=("$HOME/.config/i3/scripts/wifi.sh")
LABELS+=("  Bluetooth")
ACTIONS+=("$HOME/.config/i3/scripts/bluetooth.sh")
LABELS+=("  Audio Output")
ACTIONS+=("$HOME/.config/i3/scripts/sink-switch.sh")
LABELS+=("  Packages")
ACTIONS+=("$HOME/.config/i3/scripts/pkg-menu")
LABELS+=("  Applications")
ACTIONS+=("$HOME/.config/i3/scripts/appmenu-tui")
LABELS+=("  Theme")
ACTIONS+=("$HOME/.config/i3/scripts/theme-menu")
LABELS+=("  Input")
ACTIONS+=("$HOME/.config/i3/scripts/input-menu")
LABELS+=("  Keyboard")
ACTIONS+=("$HOME/.config/i3/scripts/viars-tui")

CHOSEN=$(printf '%s\n' "${LABELS[@]}" | rofi -dmenu -i -p "Settings")
[[ -z "$CHOSEN" ]] && exit 0

for i in "${!LABELS[@]}"; do
    if [[ "${LABELS[$i]}" == "$CHOSEN" ]]; then
        exec bash "${ACTIONS[$i]}"
    fi
done
