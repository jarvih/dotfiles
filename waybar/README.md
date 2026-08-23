# Waybar config

Personal [Waybar](https://github.com/Alexays/Waybar) configuration on Fedora
Sway Atomic. One config serves both compositors: it declares the sway and the
niri modules side by side, and each compositor silently skips the modules that
are not its own, so no per-compositor copy is needed.

| File           | Contents                                  |
| -------------- | ----------------------------------------- |
| `config.jsonc` | Bar geometry and module configuration     |
| `style.css`    | GTK stylesheet (Tokyo Dark palette)       |

Under niri the bar is spawned from `../niri/startup.kdl`.

## Bar

Bottom of the screen, `layer: top`, 32px high, 2px module spacing.

| Position | Modules |
| -------- | ------- |
| Left     | `sway/mode` |
| Center   | `group/center`: `sway/scratchpad`, `sway/workspaces`, `niri/workspaces` |
| Right    | `network`, `pulseaudio`, `battery`, `clock`, `tray` |

The center group is a single rounded pill holding whichever workspace module the
running compositor provides.

## Modules

- **sway/workspaces** — all outputs, scroll disabled, workspaces 1–4 always
  present
- **niri/workspaces** — all outputs, `format: {value}`, which is the workspace
  name, or its index when the workspace is unnamed (see `../niri/workspaces.kdl`)
- **sway/scratchpad** — hidden while empty, tooltip shows `{app}: {title}`
- **sway/mode** — shown only while a sway binding mode is active
- **clock** — `dd.mm. HH:MM`, tooltip shows a month calendar
- **battery** — percentage with a Nerd Font icon ramp, `format-alt` (click)
  shows remaining time, warning at 30% and critical at 15%
- **network** — SSID over wifi, IP over ethernet, tooltip adds interface,
  CIDR, gateway and signal strength
- **pulseaudio** — volume percentage, click opens `pavucontrol`
- **tray** — 16px icons

## Appearance

- **Theme**: Tokyo Dark — the same palette as `../sway/config.d/30-colors.conf`
  (`#1a1b2a` bg, `#22243a` module bg, `#a0a8cd` fg, `#7199ee` blue,
  `#d4a959` yellow, `#ee6d85` red, `#95d3af` green, `#38a89d` cyan)
- **Font**: JetBrainsMono Nerd Font 13px — the module formats use Nerd Font
  glyphs, so a Nerd Font is required or the icons render as boxes
- The bar window itself is transparent; each module draws its own rounded
  `#22243a` pill, so the bar reads as floating chips over the wallpaper
- `#workspaces` rules are shared by the sway and niri modules, since both use
  that widget id: dim by default, blue with an underline when focused, red when
  urgent
- The scratchpad indicator and an active sway mode are red-on-dark, to stand out
  from the rest of the bar

## Usage

`~/.config/waybar` is a symlink to this folder.
