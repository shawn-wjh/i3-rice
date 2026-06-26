#!/usr/bin/env bash
# install.sh — set up this i3 rice.
#
# What it does:
#   1. Places the repo at ~/.config/i3 (the scripts assume that path).
#   2. Reports any missing dependencies (does NOT install them for you).
#   3. Generates the rofi/dunst/alacritty/i3status/btop configs from the
#      active theme via scripts/theme-set.
#   4. Optionally installs the keyd remap and the optional personal tools.
#
# Re-running is safe. Nothing is installed system-wide without asking.
set -euo pipefail

REPO_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
TARGET="$HOME/.config/i3"
DEFAULT_THEME="Eclipse"

c_bold=$'\e[1m'; c_green=$'\e[32m'; c_yellow=$'\e[33m'; c_red=$'\e[31m'; c_reset=$'\e[0m'
say()  { printf '%s==>%s %s\n' "$c_bold" "$c_reset" "$*"; }
ok()   { printf '  %s✓%s %s\n' "$c_green" "$c_reset" "$*"; }
warn() { printf '  %s!%s %s\n' "$c_yellow" "$c_reset" "$*"; }
err()  { printf '  %s✗%s %s\n' "$c_red" "$c_reset" "$*"; }
ask()  { local r; read -rp "  $1 [y/N] " r; [[ "$r" =~ ^[Yy]$ ]]; }

# ---------------------------------------------------------------------------
# 1. Put the repo at ~/.config/i3
# ---------------------------------------------------------------------------
say "Placing config at $TARGET"
if [[ "$REPO_DIR" == "$TARGET" ]]; then
    ok "Already at $TARGET"
elif [[ -L "$TARGET" && "$(readlink -f "$TARGET")" == "$REPO_DIR" ]]; then
    ok "$TARGET already symlinks here"
else
    if [[ -e "$TARGET" ]]; then
        backup="$TARGET.backup.$(date +%Y%m%d%H%M%S)"
        mv "$TARGET" "$backup"
        warn "Existing $TARGET moved to $backup"
    fi
    mkdir -p "$(dirname "$TARGET")"
    ln -s "$REPO_DIR" "$TARGET"
    ok "Symlinked $TARGET -> $REPO_DIR"
fi

# ---------------------------------------------------------------------------
# 2. Dependency check (report only)
# ---------------------------------------------------------------------------
# "command:package" — package names are for Arch (pacman/AUR).
required=(
    i3:i3-wm rofi:rofi dunst:dunst i3status-rs:i3status-rust alacritty:alacritty
    jq:jq notify-send:libnotify xrandr:xorg-xrandr xinput:xorg-xinput
    xset:xorg-xset pactl:libpulse brightnessctl:brightnessctl playerctl:playerctl
    python3:python fzf:fzf feh:feh
)
recommended=(
    keyd:keyd xdotool:xdotool xclip:xclip maim:maim clipcatd:clipcat
    xss-lock:xss-lock xsecurelock:xsecurelock xprintidle:xprintidle
    powerprofilesctl:power-profiles-daemon bluetoothctl:bluez-utils
    nmcli:networkmanager nm-applet:network-manager-applet blueman-applet:blueman
    gnome-keyring-daemon:gnome-keyring dex:dex xsct:xsct rg:ripgrep btop:btop vim:vim
)

check_group() {
    local label="$1"; shift
    local missing=()
    for pair in "$@"; do
        local cmd="${pair%%:*}" pkg="${pair##*:}"
        command -v "$cmd" >/dev/null 2>&1 || missing+=("$pkg")
    done
    if ((${#missing[@]} == 0)); then
        ok "$label: all present"
    else
        warn "$label missing: ${missing[*]}"
        printf '        install with: sudo pacman -S --needed %s\n' "${missing[*]}"
    fi
}

say "Checking dependencies (nothing is installed for you)"
check_group "Required" "${required[@]}"
check_group "Recommended" "${recommended[@]}"

# ---------------------------------------------------------------------------
# 3. Render theme -> generates rofi/dunst/alacritty/i3status/btop configs
# ---------------------------------------------------------------------------
say "Applying theme '$DEFAULT_THEME' (generates app configs)"
theme="$DEFAULT_THEME"
[[ -f "$TARGET/themes/current/theme.name" ]] && theme="$(cat "$TARGET/themes/current/theme.name")"
if command -v i3 >/dev/null 2>&1 && [[ -n "${DISPLAY:-}" ]]; then
    "$TARGET/scripts/theme-set" "$theme" && ok "Theme applied and services reloaded"
else
    "$TARGET/scripts/theme-set" --render-only "$theme" && \
        ok "Configs generated (run 'theme-set $theme' inside i3 to reload live)"
fi

# ---------------------------------------------------------------------------
# 4. Optional: keyd remap (Alt/Win swap, arrow layer, chords)
# ---------------------------------------------------------------------------
if command -v keyd >/dev/null 2>&1; then
    say "keyd remap"
    if ask "Install keyd config to /etc/keyd? (needs sudo)"; then
        "$TARGET/scripts/keyd-install" && ok "keyd configured"
    else
        warn "Skipped — the Alt/Win swap + arrow layer won't apply"
    fi
fi

# ---------------------------------------------------------------------------
# 5. Optional personal tools (the author's own repos)
# ---------------------------------------------------------------------------
say "Optional personal tools (power \$mod+n notes / \$mod+d todo / keyboard menu)"
install_tool() {
    local name="$1" repo="$2" hint="$3" key="$4"
    command -v "$name" >/dev/null 2>&1 && { ok "$name already installed"; return; }
    if ask "Install $name ($key) from $repo?"; then
        printf '        %s\n' "$hint"
    fi
}
install_tool todui     "github.com/shawn-wjh/todui"     "cargo install --git https://github.com/shawn-wjh/todui" "\$mod+d"
install_tool viars-tui "github.com/shawn-wjh/viars-tui" "cargo install --git https://github.com/shawn-wjh/viars-tui" "keyboard menu"
install_tool qnote     "github.com/shawn-wjh/qnote"     "see https://github.com/shawn-wjh/qnote (also set QNOTE_KNOWLEDGE_DIR)" "\$mod+n"

# ---------------------------------------------------------------------------
say "Done."
cat <<EOF

  Next steps:
    • Log out and pick "i3" in your display manager, or run 'startx' with i3.
    • Already in i3? Reload with: ${c_bold}\$mod+Shift+r${c_reset}  (or 'i3-msg restart')
    • Switch themes:  scripts/theme-set <Ares|Eclipse|Nova|Titan>
    • \$mod is the Super/Windows key. See README.md for the full keybinding tour.
EOF
