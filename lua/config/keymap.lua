-- General keybindigs --
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)

-- Paste and keep clipboard content
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- Move selected lines in visual lines usin J,K
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Reload source
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

-- Clear Highlighted search results
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { silent = true })
