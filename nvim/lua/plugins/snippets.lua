-- Snippet management configuration for nvim
-- UltiSnips/LuaSnip integration

return {
    {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets", "honza/vim-snippets" },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })
            require("luasnip").filetype_extend("javascript", { "javascriptreact", "typescriptreact" })
            require("luasnip").filetype_extend("python", { "python" })
            require("luasnip").filetype_extend("swift", { "swift" })
        end,
    },

    -- Friendly snippets collection
    {
        "rafamadriz/friendly-snippets",
        event = "InsertEnter",
        dependencies = { "hrsh7th/nvim-cmp" },
    },

    -- Custom snippet files (in ~/.config/nvim/snippets/)
    -- Create: ~/.config/nvim/snippets/
    -- Files: python.snippets, javascript.snippets, shell.snippets, etc.
}
