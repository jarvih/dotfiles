# Niri config

Personal [niri](https://github.com/YaLTeR/niri) configuration on Fedora Sway
Atomic, ported from the sway config in `../sway/`. Niri is a scrollable-tiling
Wayland compositor: windows live in a horizontally scrolling strip of columns
instead of a bsp tree.

## Layout of the files

`config.kdl` is the entry point and only holds input, gestures and output
settings; everything else is `include`d. Paths are relative to `config.kdl`, and
niri watches included files too, so live-reload works while editing any of them.

| File               | Contents                                                  |
| ------------------ | --------------------------------------------------------- |
| `config.kdl`       | Entry point, `include`s, keyboard/touchpad/mouse, outputs |
| `binds.kdl`        | All key, mouse and touchpad bindings                       |
| `layout.kdl`       | Gaps, column widths, focus ring, border, shadow, struts, animations |
| `workspaces.kdl`   | Named workspaces that always exist                         |
| `window-rules.kdl` | Per-application window rules                               |
| `startup.kdl`      | Processes spawned at session start                         |
| `misc.kdl`         | Hotkey overlay, CSD preference, screenshot path            |

## Input

- xkb settings are left empty on purpose, so niri picks them up from
  `org.freedesktop.locale1` (`localectl set-x11-keymap`)
- Numlock on at startup
- Touchpad: tap-to-click and natural scroll
- Hot corners disabled (the overview is on `Mod+O` instead)

`Mod` is Super on a TTY session and Alt when niri runs nested in a window.

## Keybindings

Beyond the niri defaults, the notable ones:

| Key | Action |
|-----|--------|
| `Mod+Enter` | Terminal inside toolbox container (`foot toolbox enter`) |
| `Mod+Shift+Enter` | Plain `foot` terminal |
| `Mod+D` | Rofi app launcher (drun) |
| `Super+Alt+L` | Lock screen (swaylock) |
| `Ctrl+Alt+Delete` | Rofi power menu (`~/.config/rofi/powermenu/powermenu.sh`) |
| `Mod+Q` | Close window |
| `Mod+H/J/K/L`, arrows | Focus column left / window down / window up / column right |
| `Mod+Ctrl+` same keys | Move window in that direction |
| `Mod+Shift+` same keys | Focus monitor in that direction |
| `Mod+Shift+Ctrl+` same keys | Move column to that monitor |
| `Mod+U` / `Mod+I`, PgDn/PgUp | Focus workspace down / up |
| `Mod+1`…`Mod+9` | Focus workspace by index |
| `Mod+Ctrl+1`…`9` | Move column to workspace by index |
| `Mod+Tab` | Switch to the previous workspace |
| `Mod+N` | Rename focused workspace via a rofi prompt |
| `Mod+Shift+N` | Clear the runtime workspace name |
| `Mod+O` | Toggle the overview |
| `Mod+R` / `Mod+Shift+R` | Cycle preset column widths forwards / backwards |
| `Mod+F` / `Mod+Shift+F` / `Mod+M` | Maximize column / fullscreen / maximize to screen edges |
| `Mod+V` / `Mod+Shift+V` | Move window to floating / switch focus floating↔tiling |
| `Mod+W` | Toggle tabbed column display |
| `Mod+Comma` / `Mod+Period` | Consume window into column / expel it out |
| `Print`, `Ctrl+Print`, `Alt+Print` | Screenshot area / screen / window |
| `Mod+Shift+P` | Power off the monitors |
| `Mod+Escape` | Toggle the keyboard-shortcuts inhibitor (escape hatch) |
| `Mod+Shift+Escape` | Show the hotkey overlay |
| `Mod+Shift+E` | Quit niri (asks for confirmation) |

Media, volume and brightness keys are bound to `wpctl`, `playerctl` and
`brightnessctl`, and keep working while the session is locked.

## Workspaces

`workspaces.kdl` declares `web`, `term` and `misc`. Declared workspaces always
exist in that order even when empty — the closest niri equivalent of sway's
persistent workspaces — and the waybar `niri/workspaces` module shows the name
instead of the index for them. So `Mod+1` is `web`, `Mod+2` is `term`,
`Mod+3` is `misc`. Niri keeps one empty unnamed workspace after the last one,
which is normal.

`Mod+N` renames the focused workspace at runtime; those names are not persisted
and the declared ones come back on restart.

## Appearance

- **Gaps**: 6px, no struts
- **Default column width**: 50% of the output; presets are 1/3, 1/2, 2/3
- **Focus ring**: 2px, `#7fc8ff` active / `#505050` inactive; the border is off
- **Corners**: 3px radius on all windows, clipped to geometry
- **Animations**: enabled, `slowdown 0.8`
- Screenshots go to `~/Pictures/Screenshots/`

## Window rules

- WezTerm gets an empty `default-column-width` to work around its initial
  configure bug
- Firefox picture-in-picture opens floating (matches host and Flatpak app-ids)
- Microsoft Edge opens maximized — column-maximized, so waybar stays visible.
  The app-id is anchored so the Edge PWAs (`msedge-<id>-Default`) are not
  caught; matching on the title does not work because Edge puts a zero-width
  space in it
- Windows with an empty app-id and title open floating

## Autostart

- `swaybg` — wallpaper from `~/.cache/wallpaper.jpg`, `fill` mode (niri has no
  built-in background)
- `swayidle` — lock after 5 min, blank after 6 min, suspend after 16 min; also
  blanks after 1 min when already locked. Uses `niri msg action
  power-off-monitors`, since there is no `swaymsg` here

Waybar is not spawned here; it runs from the `waybar.service` user unit, see
[`../waybar/README.md`](../waybar/README.md).

Running niri as a session also supports xdg-desktop-autostart, which is easier
for anything shipping a `.desktop` file.
