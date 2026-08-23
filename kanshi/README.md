# Kanshi config

[kanshi](https://gitlab.freedesktop.org/emersion/kanshi) applies output profiles
automatically as monitors are plugged in and out, on any wlroots compositor
(sway and niri both qualify). Without it, the docked and undocked layouts have
to be set by hand every time.

## Profiles

A profile is picked when its set of connected outputs matches exactly.

| Profile       | Layout                                                          |
| ------------- | --------------------------------------------------------------- |
| `External`    | `DP-1` 3840x2160@59.997Hz at scale 1.25, positioned at `1920,0`, laptop panel off |
| `External2`   | Same, but the dock presents the monitor as `DP-3`                |
| `laptop_only` | `eDP-1` alone, at its preferred mode                             |

`External` and `External2` are the same physical setup: the output name depends
on which port the dock happens to use, so both are declared rather than trying
to match on make/model.

The refresh rate is written as `59.997Hz` rather than `60Hz` because kanshi
matches the mode exactly against what the display reports.

Scale 1.25 on a 4K panel gives a 3072x1728 logical area — sharp text without
everything being tiny.

## Running it

kanshi runs as the systemd user unit `kanshi.service` (`systemctl --user enable
--now kanshi`), not from a compositor autostart, so it survives switching
between sway and niri.

Sway forces a re-evaluation when the lid closes:

```
bindswitch lid:off exec kanshictl reload
```

There is no equivalent bind in the niri config; niri handles the lid itself.

`kanshictl reload` re-reads this file, and `kanshictl switch <profile>` forces a
specific one.

## Usage

Kanshi reads `~/.config/kanshi/config`, and `~/.config/kanshi` is symlinked to
this folder, so the tracked `config` is the one in use. kanshi ignores every
other file in the directory, so this README sitting next to it is harmless.
