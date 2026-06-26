#!/usr/bin/env bash
set -euo pipefail

declare -a LABELS NAMES NOTIFY_NAMES

DEFAULT_NAME=$(pactl get-default-sink 2>/dev/null || true)

sink_name=""
sink_desc=""
sink_available=""

add_sink() {
    if [[ -z "$sink_name" || -z "$sink_desc" ]]; then
        return 0
    fi

    local desc marker
    # Drop the verbose "<chipset> ... Controller " prefix PulseAudio/PipeWire
    # prepend (e.g. "Alder Lake Smart Sound Technology Audio Controller "), leaving
    # the human part ("Speaker + Headphones"). No-op when there's no such prefix.
    desc="$(printf '%s' "$sink_desc" | sed -E 's/.*Controller //')"
    if [[ "$sink_available" == "no" ]]; then
        desc="$desc (unavailable)"
    fi
    marker=" "

    if [[ "$sink_name" == "$DEFAULT_NAME" ]]; then
        marker="*"
    fi

    LABELS+=("$marker $desc")
    NAMES+=("$sink_name")
    NOTIFY_NAMES+=("$desc")
}

while IFS= read -r line; do
    if [[ $line =~ ^Sink\ \#([0-9]+) ]]; then
        add_sink
        sink_name=""
        sink_desc=""
        sink_available=""
    elif [[ $line =~ ^[[:space:]]+Name:\ (.+) ]]; then
        sink_name="${BASH_REMATCH[1]}"
    elif [[ $line =~ ^[[:space:]]+Description:\ (.+) ]]; then
        sink_desc="${BASH_REMATCH[1]}"
    elif [[ $line =~ ^[[:space:]]+\[Out\].*\ not\ available\) ]]; then
        sink_available="no"
    fi
done < <(pactl list sinks)
add_sink

[[ ${#LABELS[@]} -gt 0 ]] || exit 1

CHOSEN=$(printf '%s\n' "${LABELS[@]}" | "$HOME/.config/i3/scripts/menu-select" "Audio Output" || true)
[[ -z "$CHOSEN" ]] && exit 0

SINK=""
notify_name=""
for i in "${!LABELS[@]}"; do
    if [[ "${LABELS[$i]}" == "$CHOSEN" ]]; then
        SINK="${NAMES[$i]}"
        notify_name="${NOTIFY_NAMES[$i]}"
        break
    fi
done
[[ -n "$SINK" ]] || exit 1

pactl set-default-sink "$SINK"

pactl list sink-inputs short | awk '{print $1}' | while read -r id; do
    [[ -n "$id" ]] && pactl move-sink-input "$id" "$SINK"
done

notify-send -a "audio" -t 2000 \
    -h "string:x-dunst-stack-tag:audio" \
    "Audio Output" "$notify_name"
