# Dependencies

Package names are for **Arch Linux** (pacman + AUR). On other distros the
binary names are the same; find the equivalent package. `install.sh` checks
these for you and prints what's missing — it does not install anything.

## Required

The desktop won't look/work right without these:

```sh
sudo pacman -S --needed \
  i3-wm rofi dunst i3status-rust alacritty jq libnotify \
  xorg-xrandr xorg-xinput xorg-xset libpulse brightnessctl \
  playerctl python fzf feh
```

| Package | Used for |
|---|---|
| `i3-wm` | the window manager |
| `rofi` | every menu (launcher, bluetooth, audio, power, …) |
| `dunst` | notifications (volume/brightness/battery OSD) |
| `i3status-rust` | the status bar (`i3status-rs`) |
| `alacritty` | terminal |
| `jq` | JSON parsing in scratchpad/clipboard/theme scripts |
| `libnotify` | `notify-send` |
| `xorg-xrandr` / `xorg-xinput` / `xorg-xset` | display, input, screen-blank |
| `libpulse` | `pactl` volume + sink switching |
| `brightnessctl` | brightness keys |
| `playerctl` | media keys / now-playing |
| `python` | smart-border daemon |
| `fzf` | fuzzy selection in TUI menus |
| `feh` | wallpaper (xwallpaper also supported) |

## Recommended

Enable big chunks of functionality; install what you want:

```sh
sudo pacman -S --needed \
  keyd xdotool xclip maim xss-lock xsecurelock \
  power-profiles-daemon bluez-utils networkmanager \
  network-manager-applet blueman gnome-keyring dex ripgrep btop vim
# AUR:
paru -S clipcat xprintidle xsct
```

| Package | Enables |
|---|---|
| `keyd` | Alt/Win swap, arrow layer, chords (`keyd-install`) |
| `xdotool` | window control / paste helpers |
| `xclip` | clipboard helpers |
| `maim` | screenshots (`$mod+Shift+s`) |
| `xss-lock` + `xsecurelock` | screen locking on idle/suspend |
| `power-profiles-daemon` | power profile cycling (`$mod+b`) |
| `bluez-utils` | bluetooth menu (`$mod+Shift+b`) |
| `networkmanager` + `network-manager-applet` | wifi menu + tray |
| `blueman` | bluetooth tray applet |
| `gnome-keyring` | secret storage |
| `dex` | run XDG autostart entries |
| `clipcat` (AUR) | clipboard history (`$mod+c`) |
| `xprintidle` (AUR) | idle-suspend timing |
| `xsct` (AUR) | night-light color temperature |
| `ripgrep` / `btop` / `vim` | note search / system monitor / editor |

## Optional — the author's own tools

These power `$mod+n`, `$mod+d` and the keyboard menu. If absent, those keys show
an install hint and do nothing else.

- [qnote](https://github.com/shawn-wjh/qnote) — notes (`$mod+n`); set
  `QNOTE_KNOWLEDGE_DIR` (default `~/ai-share/knowledge`).
- [todui](https://github.com/shawn-wjh/todui) — todo TUI (`$mod+d`):
  `cargo install --git https://github.com/shawn-wjh/todui`.
- [viars-tui](https://github.com/shawn-wjh/viars-tui) — VIA keyboard config TUI.
