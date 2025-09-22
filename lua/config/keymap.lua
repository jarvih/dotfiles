-- General keybindigs --
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)

-- Paste and keep clipboard content
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
