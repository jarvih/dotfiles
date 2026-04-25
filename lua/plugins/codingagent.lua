-- codingagent.lua
-- Loads either coder/claudecode.nvim or sudo-tee/opencode.nvim depending on
-- the AI_TOOL environment variable. Set AI_TOOL=opencode in your work shell
-- profile; leave it unset (defaults to "claude") elsewhere.
--
-- Shared keybind: <leader>ac  →  toggle panel
-- Auto-open trigger:
--   claude   → CLAUDE.md present in cwd
--   opencode → opencode.json present in cwd

-- ───────────────────────────────────────────────────────────────────────────
-- Returns which coding agent to load.
-- Set AI_TOOL=opencode in your work shell profile (~/.bashrc, ~/.zshrc, or
-- fish: set -x AI_TOOL opencode). Unset means "claude".
-- ───────────────────────────────────────────────────────────────────────────
local function ai_panel_plugin()
  return vim.env.AI_TOOL or "claude"
end

-- Close terminal windows when quitting the last normal window, so vim exits cleanly
local function setup_quit_with_panel()
  vim.api.nvim_create_autocmd("QuitPre", {
    callback = function()
      local normal_wins = vim.tbl_filter(function(w)
        local cfg = vim.api.nvim_win_get_config(w)
        return cfg.relative == "" and vim.bo[vim.api.nvim_win_get_buf(w)].buftype ~= "terminal"
      end, vim.api.nvim_list_wins())
      if #normal_wins <= 1 then
        for _, w in ipairs(vim.api.nvim_list_wins()) do
          if vim.bo[vim.api.nvim_win_get_buf(w)].buftype == "terminal" then
            pcall(vim.api.nvim_win_close, w, true)
          end
        end
      end
    end,
  })
end

-- Shared: auto-open when the project marker file is found in cwd
local function setup_auto_open(marker_file, open_cmd)
  local function maybe_open()
    if vim.fn.filereadable(vim.fn.getcwd() .. "/" .. marker_file) == 1 then
      vim.defer_fn(function()
        vim.cmd(open_cmd)
      end, 500)
    end
  end
  vim.api.nvim_create_autocmd({ "VimEnter", "DirChanged" }, {
    callback = maybe_open,
  })
end

local tool = ai_panel_plugin()

return {
  -- ─────────────────────────────────────────────────────────────────────────
  -- Claude Code  (home / default)
  -- https://github.com/coder/claudecode.nvim
  -- ─────────────────────────────────────────────────────────────────────────
  {
    "coder/claudecode.nvim",
    enabled = tool == "claude",
    dependencies = { "folke/snacks.nvim" },
    opts = {
      terminal = {
        provider = "snacks",
        snacks_win_opts = {
          position = "right",
          width = 0.35,
          height = 1.0,
          border = "rounded",
        },
      },
    },
    keys = {
      { "<leader>ac", "<cmd>ClaudeCodeFocus --continue<cr>", desc = "Toggle Claude Code" },
    },
    config = function(_, opts)
      require("claudecode").setup(opts)
      setup_auto_open("CLAUDE.md", "ClaudeCode")
      setup_quit_with_panel()
    end,
  },

  -- ─────────────────────────────────────────────────────────────────────────
  -- OpenCode  (work)
  -- https://github.com/sudo-tee/opencode.nvim
  -- Requires opencode CLI >= v0.6.3
  -- ─────────────────────────────────────────────────────────────────────────
  {
    "sudo-tee/opencode.nvim",
    enabled = tool == "opencode",
    opts = {},
    keys = {
      { "<leader>ac", "<cmd>OpencodeToggle<cr>", desc = "Toggle OpenCode" },
    },
    config = function(_, opts)
      require("opencode").setup(opts)
      setup_auto_open("opencode.json", "OpencodeOpen")
      setup_quit_with_panel()
    end,
  },
}

