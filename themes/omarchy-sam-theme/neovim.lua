return {
    {
        "bjarneo/aether.nvim",
        branch = "v2",
        name = "aether",
        priority = 1000,
        opts = {
            transparent = false,
            colors = {
                -- Background colors
                bg = "#00090c",
                bg_dark = "#00090c",
                bg_highlight = "#18afca",

                -- Foreground colors
                -- fg: Object properties, builtin types, builtin variables, member access, default text
                fg = "#ffffff",
                -- fg_dark: Inactive elements, statusline, secondary text
                fg_dark = "#ffffff",
                -- comment: Line highlight, gutter elements, disabled states
                comment = "#18afca",

                -- Accent colors
                -- red: Errors, diagnostics, tags, deletions, breakpoints
                red = "#ff2a37",
                -- orange: Constants, numbers, current line number, git modifications
                orange = "#ff99a2",
                -- yellow: Types, classes, constructors, warnings, numbers, booleans
                yellow = "#ff4a59",
                -- green: Comments, strings, success states, git additions
                green = "#c3f9e9",
                -- cyan: Parameters, regex, preprocessor, hints, properties
                cyan = "#51ded1",
                -- blue: Functions, keywords, directories, links, info diagnostics
                blue = "#887bd3",
                -- purple: Storage keywords, special keywords, identifiers, namespaces
                purple = "#db89b9",
                -- magenta: Function declarations, exception handling, tags
                magenta = "#ffffff",
            },
        },
        config = function(_, opts)
            require("aether").setup(opts)
            vim.cmd.colorscheme("aether")

            -- Enable hot reload
            require("aether.hotreload").setup()
        end,
    },
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "aether",
        },
    },
}
