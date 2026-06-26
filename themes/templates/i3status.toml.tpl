icons_format = "{icon}"

[theme]
theme = "plain"

[theme.overrides]
idle_bg = "{{ background }}"
idle_fg = "{{ foreground }}"
info_bg = "{{ background }}"
info_fg = "{{ foreground }}"
good_bg = "{{ background }}"
good_fg = "{{ highlight }}"
warning_bg = "{{ background }}"
warning_fg = "{{ muted }}"
critical_bg = "{{ urgent }}"
critical_fg = "{{ urgent }}"
separator = "|"
separator_bg = "{{ background }}"
separator_fg = "{{ dim }}"

[icons]
icons = "awesome4"

[icons.overrides]
volume_muted = "\uf026 \uf00d ░░░░░░░░░░░░"
volume = [
    "\uf026 ░░░░░░░░░░░░",
    "\uf026 ▒░░░░░░░░░░░",
    "\uf027 █▒░░░░░░░░░░",
    "\uf027 ██▒░░░░░░░░░",
    "\uf027 ███▒░░░░░░░░",
    "\uf027 ████▒░░░░░░░",
    "\uf028 █████▒░░░░░░",
    "\uf028 ██████▒░░░░░",
    "\uf028 ███████▒░░░░",
    "\uf028 ████████▒░░░",
    "\uf028 █████████▒░░",
    "\uf028 ██████████▒░",
    "\uf028 ████████████",
]
bat_not_available = "\uf244 ░░░░░░░░░░░░"
bat_charging = [
    "\uf1e6 ░░░░░░░░░░░░",
    "\uf1e6 ▒░░░░░░░░░░░",
    "\uf1e6 █▒░░░░░░░░░░",
    "\uf1e6 ██▒░░░░░░░░░",
    "\uf1e6 ███▒░░░░░░░░",
    "\uf1e6 ████▒░░░░░░░",
    "\uf1e6 █████▒░░░░░░",
    "\uf1e6 ██████▒░░░░░",
    "\uf1e6 ███████▒░░░░",
    "\uf1e6 ████████▒░░░",
    "\uf1e6 █████████▒░░",
    "\uf1e6 ██████████▒░",
    "\uf1e6 ████████████",
]
bat = [
    "\uf244 ░░░░░░░░░░░░",
    "\uf244 ▒░░░░░░░░░░░",
    "\uf243 █▒░░░░░░░░░░",
    "\uf243 ██▒░░░░░░░░░",
    "\uf242 ███▒░░░░░░░░",
    "\uf242 ████▒░░░░░░░",
    "\uf241 █████▒░░░░░░",
    "\uf241 ██████▒░░░░░",
    "\uf241 ███████▒░░░░",
    "\uf240 ████████▒░░░",
    "\uf240 █████████▒░░",
    "\uf240 ██████████▒░",
    "\uf240 ████████████",
]

[[block]]
block = "custom"
command = "cat {{ HOME }}/.config/i3/.cache/scratchpad-slots 2>/dev/null || true"
format = " $text.pango-str() "
hide_when_empty = true
watch_files = ["{{ HOME }}/.config/i3/.cache/scratchpad-slots"]
interval = "once"

[[block]]
block = "music"
format = " $icon {$combo.str(max_w:32) |}"

[[block]]
block = "net"
# device omitted -> i3status-rust auto-detects the default interface.
# To pin a specific one, set e.g. device = "^wlan0$" (see `ip link`).
format = " $icon {$ssid $signal_strength.eng(w:2)|down} "
inactive_format = " $icon down "
missing_format = " $icon down "

[[block]]
block = "sound"
driver = "auto"
format = " $icon "

[[block]]
block = "cpu"
format = " $icon $utilization.eng(w:2) "
interval = 1
warning_cpu = 80
critical_cpu = 90

[[block]]
block = "memory"
format = " $icon $mem_used.eng(w:3,u:B,p:Gi) "
format_alt = " $icon $mem_used_percents.eng(w:2) "
interval = 5
warning_mem = 80
critical_mem = 95

[[block]]
block = "battery"
driver = "sysfs"
# Rendered from the first detected battery; falls back to BAT0. Missing battery
# (desktops) is hidden via missing_format below.
device = "{{ BATTERY }}"
format = " $icon "
full_format = " $icon "
charging_format = " $icon "
not_charging_format = " $icon "
empty_format = " $icon "
missing_format = ""
interval = 30
warning = 30
critical = 15

[[block]]
block = "custom"
command = "cat /tmp/i3_power_profile 2>/dev/null || true"
format = " \uf0e7 $text.pango-str() "
hide_when_empty = true
watch_files = ["/tmp/i3_power_profile"]
interval = "once"

[[block]]
block = "time"
format = " $timestamp.datetime(f:'%a %b %d   %H:%M') "
interval = 5
