return {
    "greggh/claude-code.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim", -- Required for git operations
    },
    config = function()

        require("claude-code").setup({
            -- Terminal window settings
            window = {
                split_ratio = 0.3,      -- Window size (height/width)
                position = "botright",  -- Position: "botright", "topleft", etc.
                enter_insert = true,    -- Auto-enter insert mode
                hide_numbers = true,    -- Hide line numbers
                hide_signcolumn = true, -- Hide sign column
            },
            -- File refresh settings
            refresh = {
                enable = true,           -- Enable file change detection
                updatetime = 100,        -- updatetime value when active (ms)
                timer_interval = 1000,   -- File check interval (ms)
                show_notifications = true, -- Show reload notifications
            },
            -- Git project settings
            git = {
                use_git_root = true,     -- Set CWD to git root
            },
            -- Command settings
            command = "claude",        -- Command to launch Claude Code
            -- Command variants
            command_variants = {
                -- Conversation management
                continue = "--continue", -- Resume recent conversation
                resume = "--resume",     -- Show conversation picker

                -- Output options
                verbose = "--verbose",   -- Enable verbose logging
            },
            -- Keymaps
            keymaps = {
                toggle = {
                    normal = "<C-,>",       -- Normal mode toggle key
                    terminal = "<C-,>",     -- Terminal mode toggle key
                    variants = {
                        continue = "<leader>cC", -- Continue conversation key
                        verbose = "<leader>cV",  -- Verbose mode key
                    },
                },
                window_navigation = true, -- Enable window nav keys
                scrolling = true,         -- Enable page scroll keys
            }
        })

    end
}
