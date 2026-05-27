-- Numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Search
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.incsearch = true

vim.opt.cursorline = true

-- Tabs
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.autoindent = true
vim.opt.expandtab = true

-- Appearance
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.background = "dark"
vim.opt.scrolloff = 8

-- Undo dir settings
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = false

-- Use system clipboard by default (equivalent to: set clipboard=unnamedplus)
vim.opt.clipboard = "unnamedplus"

-- Wayland clipboard provider using wl-clipboard
vim.g.clipboard = {
  name = "wl-clipboard",
  copy = {
    ["+"] = "wl-copy",
    ["*"] = "wl-copy",
  },
  paste = {
    ["+"] = "wl-paste --no-newline",
    ["*"] = "wl-paste --no-newline",
  },
  cache_enabled = 0,
}

