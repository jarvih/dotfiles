# dotfiles

Personal configuration files kept in one place and under version control.

## Layout

| Folder    | Purpose                                                     |
| --------- | ----------------------------------------------------------- |
| `nvim/`   | Neovim configuration (`init.lua` + Lua modules)             |
| `sway/`   | Sway window manager config, environment, and helper scripts |
| `niri/`   | Niri window manager config, environment, and helper scripts |
| `waybar/` | Waybar status bar config and styling                        |
| `rofi/`   | Rofi launcher theme/config                                  |

Some subfolders contain their own `README.md` with more detail.

## Usage

Each folder mirrors the structure expected under `~/.config/<name>/`. Symlink
or copy the contents into place.
