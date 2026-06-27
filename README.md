# i3 rice

A complete, themed [i3](https://i3wm.org/) desktop for X11 — window manager,
launcher, notifications, status bar, terminal and lock screen all driven from a
single repo with a built-in theming engine.

Switch the whole desktop's color scheme (i3 + rofi + dunst + alacritty + i3status
+ btop + Firefox + VS Code) with one command. Everything that can be is
auto-detected, so it aims to work on a fresh machine with minimal editing.

> Built on Arch Linux. The look/feel is portable; a few helper scripts
> (package menu, keyd remap) are Arch-specific — see
> [What won't work out of the box](#what-wont-work-out-of-the-box-for-you).

## Screenshots

<img width="5760" height="3234" alt="image" src="https://github.com/user-attachments/assets/fefe1959-3bc7-45cf-99b9-0838094514c6" />
<img width="5760" height="3234" alt="image" src="https://github.com/user-attachments/assets/9bbc6fd9-67e3-4323-9f50-0fa3a962f40a" />
<img width="5760" height="3234" alt="image" src="https://github.com/user-attachments/assets/9b4d0f85-6750-483e-bad6-e456f7a2fa84" />
<img width="5760" height="3234" alt="image" src="https://github.com/user-attachments/assets/6dbc090e-202b-440c-8b53-25982c16b0a4" />

## Features

- **One-command theming** — `scripts/theme-set <theme>` renders every app's
  config from a single `colors.toml` per theme and reloads everything live.
  Four themes included (`Ares`, `Eclipse`, `Nova`, `Titan`), each with wallpapers.
- **rofi-powered menus** for app launch, clipboard history, bluetooth, wifi,
  audio sink switching, package install/remove, settings, and power.
- **Numbered scratchpads** — `$mod+F1`…`$mod+F13` toggle 13 independent
  scratchpad slots; `$mod+Shift+-` opens a slot menu.
- **Smart borders** — borders auto-hide when a workspace has a single window.
- **Auto display & input handling** — monitors detected via xrandr; per-device
  input settings (touchpad, mouse) saved and restored.
- **Status bar** (i3status-rust) with volume/battery/wifi/cpu/mem progress bars,
  now-playing, and current power profile.
- **Lock + idle suspend**, brightness/volume/media keys with on-screen notifications.
- **Optional keyd remap** — Alt/Win swap, an arrow-key navigation layer and chords.

## Install

```sh
git clone https://github.com/shawn-wjh/i3-rice ~/.config/i3
~/.config/i3/install.sh
```

`install.sh` will:

1. Put the repo at `~/.config/i3` (required — scripts assume that path).
2. **Report** missing dependencies (it never installs system packages for you).
3. Generate all app configs by applying the default theme.
4. Optionally install the keyd remap and the optional personal tools.

Then log out and choose **i3** in your display manager (or `exec i3` from your
`~/.xinitrc`). Inside i3, reload with `$mod+Shift+r`.

See [PACKAGES.md](PACKAGES.md) for the full dependency list with package names.

## Keybindings

`$mod` is the **Super/Windows** key. Focus uses `j k l ;` (left/down/up/right).

| Keys | Action |
|---|---|
| `$mod+Return` | Terminal (alacritty) |
| `$mod+Space` | App launcher (rofi drun) |
| `$mod+q` | Close window |
| `$mod+j/k/l/;` | Focus left/down/up/right (arrows also work) |
| `$mod+Shift+<dir>` | Move window |
| `$mod+f` | Fullscreen · `$mod+s/t/e` stacking/tabbed/split |
| `$mod+Shift+v` | Toggle floating · `$mod+v` focus tiling/floating |
| `$mod+r` | Resize mode |
| `$mod+1…0` | Switch workspace · `$mod+Shift+1…0` move to workspace |
| `$mod+c` | Clipboard history (clipcat) |
| `$mod+Shift+s` | Screenshot |
| `$mod+o` | Audio output switcher |
| `$mod+Shift+b` / `$mod+Shift+w` | Bluetooth / WiFi menu |
| `$mod+b` | Cycle power profile |
| `$mod+,` | Settings menu |
| `$mod+Ctrl+Space` | Next wallpaper |
| `$mod+i` / `$mod+Shift+i` | Install / remove package (Arch) |
| `$mod+p` | VS Code workspace switcher |
| `$mod+F1…F13` | Toggle scratchpad slot 1–13 · `$mod+Shift+-` slot menu |
| `$mod+Escape` | System mode: **l**ock / **s**uspend / **r**eboot / **q** poweroff / **e**xit i3 |
| `$mod+Shift+Space` | Launch mode: **f**irefox / **c**ode / **s**potify / **q**bittorrent / **t**hunar |
| `$mod+n` / `$mod+d` | Notes (qnote) / Todo (todui) — _optional tools, see below_ |

## Themes

```sh
scripts/theme-set Ares        # switch + reload everything live
scripts/theme-set --render-only Nova   # regenerate configs without reloading
```

A theme lives in `themes/<Name>/` and only needs a `colors.toml` (plus optional
`backgrounds/`, `vscode.json`, `btop.theme`, `neovim.lua`). Templates in
`themes/templates/*.tpl` define how each app's config is rendered from those
colors — edit a template once and every theme picks it up. To add a theme, copy
an existing folder and change `colors.toml`.

## Customization

- **Launch-mode apps** (`$mod+Shift+Space`) are in `configurations/modes.conf`
  (firefox/code/spotify/qbittorrent/thunar) — change to your apps.
- **Hardware overrides** via environment variables (export before i3 starts):
  - `BATTERY` — battery name under `/sys/class/power_supply` (auto-detected).
  - `TODUI_BIN`, `QNOTE_BIN`, `VIARS_TUI_BIN` — paths to the optional tools.
  - WiFi interface in the status bar auto-detects; pin it by setting
    `device` in `themes/templates/i3status.toml.tpl` if you prefer.
- **Default theme** applied by the installer: `Eclipse` (edit `DEFAULT_THEME` in
  `install.sh`).

## What won't work out of the box for you

This is a real daily-driver config, so a few pieces are environment-specific.
None of them break the desktop — they degrade gracefully — but be aware:

- **Arch-only helpers.** The package menu (`$mod+i`), `pkg-*` scripts and
  `keyd-install` assume `pacman`/AUR. On other distros, ignore or adapt them.
- **Optional personal tools.** `$mod+n` (notes), `$mod+d` (todo) and the keyboard
  menu use the author's own programs
  ([qnote](https://github.com/shawn-wjh/qnote),
  [todui](https://github.com/shawn-wjh/todui),
  [viars-tui](https://github.com/shawn-wjh/viars-tui)). If not installed, those
  keys just show an install hint. qnote also needs a knowledge directory
  (`QNOTE_KNOWLEDGE_DIR`, default `~/ai-share/knowledge`).
- **Display profiles.** `autorandr` profiles are tied to specific monitors and
  are **not** shipped; generate your own with `autorandr --save <name>`. The
  default `display-apply` script auto-arranges connected outputs without them.
- **Hardware bits are auto-detected** (battery, touchpad, wifi, audio sink), but
  exotic hardware may need a tweak — see [Customization](#customization).
- **KDE/Qt theming.** Autostart sets a Breeze/qt6ct look and launches a few KDE
  applets (`kmix`, keyring); these are optional and safe to remove from
  `configurations/autostart.conf`.

## Credits

- Wallpapers under `themes/*/backgrounds/` ship with the repo (space imagery).
- Built around i3, rofi, dunst, alacritty, i3status-rust, btop and friends.
