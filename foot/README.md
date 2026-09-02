# Foot config

[foot](https://codeberg.org/dnkl/foot) is the terminal emulator on this desktop:
a Wayland-native, no-server-required VTE alternative that both sway and niri
spawn. The whole configuration is one `foot.ini` — three settings on top of
foot's built-in defaults.

| File           | Contents                                              |
| -------------- | ----------------------------------------------------- |
| `foot.ini`     | The live config                                       |
| `foot.ini.bak` | Copy taken before the resize tweaks were added        |

## Settings

```ini
[main]
font=monospace:size=12

resize-by-cells=no
resize-delay-ms=0
```

- **`font=monospace:size=12`** — no family is pinned; fontconfig resolves
  `monospace` to whatever the system has set. Everything else in these dotfiles
  asks for JetBrainsMono Nerd Font by name, foot deliberately does not.
- **`resize-by-cells=no`** — by default foot rounds a window to a whole number
  of character cells, so a dragged edge snaps in font-sized steps. Off, the
  window takes exactly the size the compositor gives it and the leftover pixels
  become padding. This matters under niri, where columns are resized to
  proportions of the screen rather than to terminal-friendly numbers.
- **`resize-delay-ms=0`** — foot normally waits 100 ms of idle before reflowing
  the grid, to avoid re-wrapping on every frame of an interactive drag. At `0`
  the content follows the drag live, at the cost of doing the work on every
  frame.

Nothing else is set, so colors, padding, scrollback, key bindings and the rest
come from foot's compiled-in defaults. In particular the **Tokyo Dark palette
used by sway, waybar, rofi and nvim is not applied here** — the terminal keeps
foot's own default scheme.

## Launched from

| Compositor | Bind              | Command                    |
| ---------- | ----------------- | -------------------------- |
| niri       | `Mod+Enter`       | `foot toolbox enter`       |
| niri       | `Mod+Shift+Enter` | `foot`                     |
| sway       | `Super+Enter`     | `$term --title ToolBox toolbox enter` |
| sway       | `Super+Shift+Enter` | `$term`                  |

The niri binds name `foot` directly (`../niri/binds.kdl`). The sway binds
(`../sway/config.d/40-keybind.conf`) go through `$term`, which is not defined in
these dotfiles: it comes from Fedora's `/etc/sway/config`, the same file that
supplies `$rofi_cmd`, and on Fedora Sway Atomic it is foot.

The default bind opens a shell inside the toolbox container rather than on the
host, which is the usual arrangement on an image-based Fedora — the host image
is immutable, so development tooling lives in the container.

## Usage

foot reads `$XDG_CONFIG_HOME/foot/foot.ini` (i.e. `~/.config/foot/foot.ini`),
and `~/.config/foot` is symlinked to this folder:

```sh
ln -s ~/.local/dotfiles/foot ~/.config/foot
```

Only `foot.ini` is read; `foot.ini.bak` and this README sit next to it without
effect. A different file can be forced with `foot -c <path>`, and
`foot --print-pid` / `footclient` are available if the server mode is ever
wanted — nothing here uses them.
