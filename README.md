# dotfiles

Personal configuration files kept in one place and under version control.
A Wayland desktop on Fedora Sway Atomic: sway and niri side by side, sharing
one bar, one launcher and one Tokyo Dark palette.

## Layout

| Folder                        | Purpose                                                     |
| ----------------------------- | ----------------------------------------------------------- |
| [`nvim/`](nvim/README.md)     | Neovim: `init.lua` + Lua modules, lazy.nvim plugin specs     |
| [`sway/`](sway/README.md)     | Sway compositor: `config.d/` snippets and helper scripts     |
| [`niri/`](niri/README.md)     | Niri compositor: per-topic KDL files included from `config.kdl` |
| [`waybar/`](waybar/README.md) | Waybar status bar, shared by both compositors                |
| [`rofi/`](rofi/README.md)     | Rofi launcher, SSH menu and power menu                       |
| [`kanshi/`](kanshi/README.md) | Output profiles for docked and undocked use                  |

Every folder has its own `README.md` with the details.

## Shared pieces

- **Tokyo Dark palette** — `#1a1b2a` / `#22243a` / `#a0a8cd` with blue, red,
  green and yellow accents, repeated in `sway/config.d/30-colors.conf`,
  `waybar/style.css`, `rofi/colors.rasi` and the nvim colorscheme
- **Waybar** — one `config.jsonc` declares both the sway and the niri modules;
  each compositor skips the ones that are not its own
- **Rofi power menu** — `rofi/powermenu/powermenu.sh` checks `$NIRI_SOCKET` to
  decide between `niri msg action quit` and `swaymsg exit`
- **JetBrainsMono Nerd Font** — required by waybar, rofi and nvim for the glyphs

## Usage

Each folder mirrors the structure expected under `~/.config/<name>/`, and is
symlinked into place:

```sh
ln -s ~/.local/dotfiles/<name> ~/.config/<name>
```
