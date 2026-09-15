# Alacritty config

[alacritty](https://github.com/alacritty/alacritty) is a GPU-accelerated
terminal emulator, set up here as a like-for-like replacement for
[`../foot`](../foot/README.md): the same font request and the same
resize behaviour, everything else left at the compiled-in defaults.

| File             | Contents        |
| ---------------- | --------------- |
| `alacritty.toml` | The live config |

## Settings

```toml
[font]
size = 12

[font.normal]
family = "monospace"

[window]
dynamic_padding = true
padding = { x = 0, y = 0 }
```

- **`family = "monospace"`** — no family is pinned; fontconfig resolves
  `monospace` to whatever the system has set. Everything else in these dotfiles
  asks for JetBrainsMono Nerd Font by name, the terminal deliberately does not.
  Same choice as `foot.ini`.
- **`size = 12`** — points, matching foot's `monospace:size=12`.
- **`dynamic_padding = true`** — alacritty's counterpart to foot's
  `resize-by-cells=no`. The grid is still a whole number of cells, but the
  leftover pixels are split evenly around it as padding instead of being left at
  one edge, so a window sized by the compositor stays centred. This matters
  under niri, where columns are resized to proportions of the screen rather than
  to terminal-friendly numbers.
- **`padding = { x = 0, y = 0 }`** — the base padding before the dynamic
  remainder is added; foot's default is likewise none.

foot's `resize-delay-ms=0` has no counterpart: alacritty reflows the grid on
every resize event already, there is no idle timer to shorten.

Nothing else is set, so colors, scrollback, key bindings and the rest come from
alacritty's defaults. In particular the **Tokyo Dark palette used by sway,
waybar, rofi and nvim is not applied here** — the terminal keeps its own default
scheme, exactly as foot does.

## Launched from

| Compositor | Bind              | Command                          |
| ---------- | ----------------- | -------------------------------- |
| niri       | `Mod+Enter`       | `alacritty -e toolbox enter`     |
| niri       | `Mod+Shift+Enter` | `alacritty`                      |

The niri binds name `alacritty` directly (`../niri/binds.kdl`). Sway still goes
through `$term` (`../sway/config.d/40-keybind.conf`), which is not defined in
these dotfiles: it comes from Fedora's `/etc/sway/config`, and on Fedora Sway
Atomic that is foot.

The default bind opens a shell inside the toolbox container rather than on the
host, which is the usual arrangement on an image-based Fedora — the host image
is immutable, so development tooling lives in the container. Where foot takes
the command as trailing arguments (`foot toolbox enter`), alacritty needs
`-e` in front of it.

## Usage

alacritty reads `$XDG_CONFIG_HOME/alacritty/alacritty.toml` (i.e.
`~/.config/alacritty/alacritty.toml`), so symlink this folder into place:

```sh
ln -s ~/.local/dotfiles/alacritty ~/.config/alacritty
```

A different file can be forced with `alacritty --config-file <path>`, and
`alacritty msg config` applies changes to running windows without a restart.
