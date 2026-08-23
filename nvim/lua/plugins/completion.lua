-- The single place nvim-cmp is configured. lsp.lua only pulls cmp-nvim-lsp in
-- for its capabilities; everything about the completion menu lives here.
return {
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            local cmp = require("cmp")
            local cmp_select = { behavior = cmp.SelectBehavior.Select }

            cmp.setup({
                preselect = cmp.PreselectMode.Item,
                completion = { completeopt = "menu,menuone,noinsert" },
                window = { documentation = cmp.config.window.bordered() },
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<Tab>"]     = cmp.mapping(function(fallback)
                        if cmp.visible() then cmp.select_next_item() else fallback() end
                    end, { "i", "s" }),
                    ["<CR>"]      = cmp.mapping.confirm({ select = false }),
                    ["<C-y>"]     = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-n>"]     = cmp.mapping.select_next_item(cmp_select),
                    ["<C-p>"]     = cmp.mapping.select_prev_item(cmp_select),
                    ["<C-f>"]     = cmp.mapping.scroll_docs(4),
                    ["<C-u>"]     = cmp.mapping.scroll_docs(-4),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "path" },
                }, {
                    { name = "buffer", keyword_length = 3 },
                }),
            })
        end,
    },
}
