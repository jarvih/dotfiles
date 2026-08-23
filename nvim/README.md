# Neovim config

Personal Neovim configuration: Lua, [lazy.nvim](https://github.com/folke/lazy.nvim)
for plugins, one file per plugin.

## Layout

```
init.lua              entry point + two autocommands
lua/config/
  keymap.lua          leader and general mappings (loaded first)
  settings.lua        vim.opt options and the clipboard provider
  lazy.lua            lazy.nvim bootstrap and setup
lua/plugins/*.lua     one spec per plugin, auto-discovered by lazy.nvim
```

`lazy.lua` clones lazy.nvim into `stdpath("data")` on first launch, then loads
`spec = "plugins"`, so dropping a new file into `lua/plugins/` is all that is
needed to add a plugin. `lazy-lock.json` is gitignored, i.e. plugin versions are
not pinned across machines.

`init.lua` also opens netrw when nvim starts with no file arguments, and
restores the last cursor position when reopening a file.

## Settings

- Relative + absolute line numbers, cursorline, `scrolloff` 8, always-on sign
  column, `termguicolors`, dark background
- 4-space indent, `expandtab`, `autoindent`
- Smart-case incremental search
- No swapfile, no backup, no undofile
- `clipboard=unnamedplus` with an explicit `wl-clipboard` provider
  (`wl-copy` / `wl-paste`), since this is a Wayland session

## Keymaps

Leader is `Space`.

| Key | Action |
|-----|--------|
| `<leader>cd` | Open netrw (`:Ex`) |
| `<leader><leader>` | Re-source the current file |
| `<leader>p` (visual) | Paste over selection without clobbering the register |
| `<leader>d` | Delete into the black hole register |
| `J` / `K` (visual) | Move the selected lines down / up and re-indent |
| `<Esc>` | Clear search highlight |
| `<Esc><Esc>` (terminal) | Leave terminal mode |

### Telescope

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fo` | Old files |
| `<leader>fb` | Buffers |
| `<leader>fh` | Help tags |
| `<leader>fq` | Quickfix list |
| `<leader>fg` | Grep for a prompted string |
| `<leader>fs` | Grep for the word under the cursor |
| `<leader>fc` | Grep for the current file's name — find where it is included |
| `<leader>fi` | Find files inside `~/.config/nvim/` |

Inside the picker, `C-j` / `C-k` move the selection and `C-q` sends the results
to the quickfix list.

### Harpoon

| Key | Action |
|-----|--------|
| `<leader>ha` | Add the current file to the list |
| `<C-e>` | Toggle the quick menu |
| `<leader>fl` | Show the list in a Telescope ivy picker |
| `<C-p>` / `<C-n>` | Previous / next file in the list |

### Other

| Key | Action |
|-----|--------|
| `<leader>ac` | Toggle the AI coding panel |
| `<leader>mv` / `<leader>ms` | Toggle markview / open its split preview |
| `M-l`, `M-]`, `M-[` | Accept / next / previous Copilot suggestion |
| `af` / `if` | Treesitter textobject: around / inside a function |

### Completion menu

| Key | Action |
|-----|--------|
| `<Tab>` | Select the next item when the menu is open, otherwise fall through |
| `<CR>` | Confirm the selected item |
| `<C-y>` | Confirm, selecting the first item if none is selected |
| `<C-Space>` | Open the menu |
| `<C-n>` / `<C-p>` | Next / previous item |
| `<C-f>` / `<C-u>` | Scroll the documentation window |

## Plugins

| File | Plugin | Notes |
| ---- | ------ | ----- |
| `colorscheme.lua` | tokyodark.nvim | Matches the Tokyo Dark palette used by sway, waybar and rofi |
| `lualine.lua` | lualine | `tomorrow_night` theme, web-devicons |
| `telescope.lua` | telescope.nvim | Fuzzy finding, see keymaps above |
| `harpoon.lua` | harpoon2 | Per-cwd file list, with a Telescope view |
| `treesitter.lua` | nvim-treesitter | Highlight, indent, autotag, function textobjects; parsers auto-install |
| `lsp.lua` | nvim-lspconfig + mason + conform + fidget | See below |
| `completion.lua` | nvim-cmp + LuaSnip | Lazy-loaded on `InsertEnter`, owns the whole cmp setup |
| `copilot.lua` | copilot.lua | Inline suggestions, panel disabled, enabled for markdown and help |
| `codingagent.lua` | claudecode.nvim / opencode.nvim | See below |
| `markview.lua` | markview.nvim | Inline markdown rendering with hybrid mode in normal mode |
| `fugitive.lua` | vim-fugitive | Git |
| `hotreload.lua` | hotreload.nvim | 500ms poll |

### LSP

Servers are installed through mason, with `lua_ls`, `pylsp` and `gopls` in
`ensure_installed`; a generic handler wires cmp capabilities into every other
server mason installs. Server-specific tweaks:

- **lua_ls** — LuaJIT runtime, `vim` recognised as a global, 2-space formatting
- **pylsp** — its bundled formatters (black, autopep8, yapf) are disabled, since
  conform runs black instead
- **zls** — inlay hints and snippets on, `root_pattern(".git", "build.zig", "zls.json")`,
  and Zig's own autosave formatting turned off

Diagnostics use `virtual_lines` with a rounded float. Two Copilot workarounds
live here: `window/showMessage` from the copilot client is dropped, and the
"Client copilot quit with exit code 143" notification is filtered out.

`lsp.lua` builds the client capabilities from `cmp-nvim-lsp` but does not
configure the completion menu itself — that lives entirely in `completion.lua`.

### Coding agent

`codingagent.lua` loads exactly one of two plugins based on the `AI_TOOL`
environment variable: `opencode` selects sudo-tee/opencode.nvim, anything else
(unset included) selects coder/claudecode.nvim. Set `AI_TOOL=opencode` in the
work shell profile. Both bind `<leader>ac` to toggle the panel, and share a
`QuitPre` autocommand that closes terminal windows when the last normal window
goes away, so `:q` exits cleanly instead of leaving the panel behind.

Claude Code opens in a snacks terminal docked right at 35% width, resuming the
previous session where possible (`claude --continue || claude`). The auto-open-
on-marker-file helper (`CLAUDE.md`, `opencode.json`) is written but currently
commented out in both specs.

## Usage

Symlink or copy this folder to `~/.config/nvim/`. Plugins install themselves on
first launch.
