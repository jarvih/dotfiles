# Sway config

Personal sway configuration on Fedora Sway Atomic.

## Input

- Finnish keyboard layout (`fi`)
- Touchpad: tap-to-click, natural scroll, disable-while-typing/trackpointing enabled
- `focus_follows_mouse` disabled

## Keybindings

| Key | Action |
|-----|--------|
| `Super+Enter` | Terminal inside toolbox container |
| `Super+Shift+Enter` | Plain terminal |
| `Super+d` | Rofi app launcher (drun) |
| `Alt+Space` | Rofi app launcher (drun) |
| `Super+Shift+d` | Default sway menu |
| `Super+s` | Rofi SSH launcher |
| `Super+Tab` | Rofi window switcher |
| `Alt+Tab` | Focus next window |
| `Super+l` | Lock screen |
| `Super+n` | Toggle swaync notification center |
| `Ctrl+Super+←/→` | Previous / next workspace |
| `Ctrl+Super+Shift+←/→` | Move window to previous / next workspace |
| `Print` | Copy screen area to clipboard (grimshot) |
| `Alt+Print` | Save active window screenshot |
| `Ctrl+Print` | Save selected area screenshot |

## Appearance

- **Theme**: Tokyo Dark
- **Gaps**: 5px inner, `smart_gaps off`
- **Bar**: Waybar at the bottom
  - Workspaces 1–4 always visible, scratchpad indicator
  - Modules: mode · scratchpad · workspaces · network · audio · battery · clock · tray

## Window rules

- Marks browser windows (Firefox, Chromium, Brave, Edge) and inhibits idle when fullscreen
- Firefox screensharing indicator forced to floating
- Edge hover card / link preview popups forced to floating and not focused
- Outlook PWA floating at 1200×800

## Autostart

- `swaync` — notification daemon
