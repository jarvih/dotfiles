# Rofi config

Personal [rofi](https://github.com/davatorium/rofi) (Wayland fork) configuration
on Fedora Sway Atomic. Used as the app launcher, SSH launcher and power menu
under both sway and niri.

| File                   | Contents                                            |
| ---------------------- | --------------------------------------------------- |
| `config.rasi`          | Default config + theme: the drun app launcher        |
| `colors.rasi`          | Shared Tokyo Dark palette, imported by every theme   |
| `ssh.rasi`             | Standalone theme for the `ssh` modi                  |
| `powermenu/powermenu.sh` | Power menu script (menu + confirmation)            |
| `powermenu/menu.rasi`  | Theme for the power menu itself                      |
| `powermenu/confirm.rasi` | Theme for the yes/no confirmation dialog           |

Every theme starts with `@import "~/.config/rofi/colors.rasi"`, so the four
colors are defined in exactly one place.

## Palette

| Name             | Value     | Used for                        |
| ---------------- | --------- | ------------------------------- |
| `background`     | `#1a1b2a` | Window background               |
| `background-alt` | `#22243a` | Input bar, selected element      |
| `foreground`     | `#a0a8cd` | Text                            |
| `highlight`      | `#7199ee` | Borders, selection in the menus  |

Same Tokyo Dark colors as `../sway/config.d/30-colors.conf` and
`../waybar/style.css`.

## App launcher — `config.rasi`

`rofi -show drun`, the default config, so no `-theme` argument is needed.

- 720px window, 12px radius, 2px highlight border
- Icon grid: 6 columns × 4 lines, 48px Papirus-Dark icons, name only
  (`drun-display-format: "{name}"`)
- Search bar on top with a "Search apps..." placeholder, scrollbar hidden
- JetBrainsMono Nerd Font Mono 10, dropping to 8 for the element labels

Bound to `Mod+D` in niri, and to `Super+d` / `Alt+Space` in sway.

## SSH launcher — `ssh.rasi`

`rofi -show ssh -theme ~/.config/rofi/ssh.rasi`, bound to `Super+s` in sway.
A self-contained theme, not a variation of the launcher: narrower (520px), a
single column of 10 rows, no icons, larger 14pt font, "Search hosts..."
placeholder. Hosts come from rofi's own `ssh` modi, i.e. `~/.ssh/config` and
`~/.ssh/known_hosts`.

## Power menu — `powermenu/`

`powermenu.sh`, bound to `Ctrl+Alt+Delete` in both compositors. It feeds six
Pango-markup entries to `rofi -dmenu`, each a large Nerd Font glyph over a
label: Lock, Exit, Suspend, Hibernate, Reboot, Shutdown. The prompt shows the
current uptime.

- `menu.rasi` — 1300×700 overlay on a transparent window, 3×2 grid of
  translucent rounded cards, hover-select with mouse-click to accept. The menu
  is launched with `-no-config`, so `config.rasi` does not bleed into it
- `confirm.rasi` — small 320px yes/no dialog, shown for every action except
  Lock, which fires `swaylock -f` directly

Exit is compositor-aware: it uses `$NIRI_SOCKET` to decide between
`niri msg action quit --skip-confirmation` and `swaymsg exit`. The
`--skip-confirmation` is deliberate — the script already asked, so niri's own
Enter prompt would be a second confirmation for the same action.

## Usage

`~/.config/rofi` is symlinked to this folder. Note that sway invokes the
launcher through a `$rofi_cmd` variable that is not defined in these dotfiles;
it comes from the distro-provided sway config.
