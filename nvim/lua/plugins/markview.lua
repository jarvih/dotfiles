-- ~/.config/nvim/lua/plugins/markview.lua
-- Feature-rich inline markdown rendering for Neovim.
-- https://github.com/OXY2DEV/markview.nvim

return {
  "OXY2DEV/markview.nvim",
  lazy = false, -- recommended by the author; can also do ft = { "markdown" }
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons", -- or "echasnovski/mini.icons"
  },
  opts = {
    preview = {
      -- Filetypes to enable previews for.
      -- markview also supports html, latex, typst, yaml out of the box.
      filetypes = { "markdown", "codecompanion" },
      -- Buftypes to ignore (keeps it from messing with help buffers etc.)
      ignore_buftypes = { "nofile" },

      -- Modes where preview is shown.
      modes = { "n", "no", "c" },
      -- "Hybrid" modes show preview but reveal raw markdown on the current line.
      -- This is the killer feature — keep "n" here so you see source while editing.
      hybrid_modes = { "n" },

      -- Debounce in ms; lower = snappier, higher = less CPU on big files.
      debounce = 50,

      -- Draw the preview character-by-character (false) or line-by-line (true).
      linewise_hybrid_mode = false,
    },

    markdown = {
      headings = {
        enable = true,
        shift_width = 0,
        -- "simple" | "label" | "icon"
        heading_1 = { style = "icon", icon = "󰉫 ", hl = "MarkviewHeading1" },
        heading_2 = { style = "icon", icon = "󰉬 ", hl = "MarkviewHeading2" },
        heading_3 = { style = "icon", icon = "󰉭 ", hl = "MarkviewHeading3" },
        heading_4 = { style = "icon", icon = "󰉮 ", hl = "MarkviewHeading4" },
        heading_5 = { style = "icon", icon = "󰉯 ", hl = "MarkviewHeading5" },
        heading_6 = { style = "icon", icon = "󰉰 ", hl = "MarkviewHeading6" },
      },

      code_blocks = {
        enable = true,
        -- "simple" | "language" | "minimal"
        style = "language",
        icons = "internal", -- use built-in language icons
        sign = true,
        min_width = 60,
        pad_amount = 2,
      },

      list_items = {
        enable = true,
        marker_minus = { text = "●" },
        marker_plus  = { text = "◆" },
        marker_star  = { text = "○" },
      },

      block_quotes = {
        enable = true,
        -- Obsidian-style callouts work out of the box: > [!note], > [!warning], etc.
      },

      tables = {
        enable = true,
        -- "none" | "single" | "double" | "rounded"
        style = "single",
      },

      checkboxes = {
        enable = true,
        checked   = { text = "󰱒", hl = "MarkviewCheckboxChecked" },
        unchecked = { text = "󰄱", hl = "MarkviewCheckboxUnchecked" },
      },
    },

    markdown_inline = {
      -- Inline code, links, images, footnotes, etc. all configured here.
      -- Defaults are good; tweak if needed.
    },
  },

  keys = {
    { "<leader>mv", "<cmd>Markview Toggle<cr>", desc = "Toggle markview" },
    { "<leader>ms", "<cmd>Markview splitToggle<cr>", desc = "Markview split preview" },
  },
}
