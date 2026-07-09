return {
    "abecodes/tabout.nvim",
    event = "InsertCharPre",
    priority = 1000,
    dependencies = {
        "hrsh7th/nvim-cmp",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("tabout").setup({
            tabkey = "",
            backwards_tabkey = "",
            act_as_tab = true,
            act_as_shift_tab = false,
            default_tab = "<C-t>",
            default_shift_tab = "<C-d>",
            enable_backwards = true,
            completion = false,
            tabouts = {
                { open = "'", close = "'" },
                { open = '"', close = '"' },
                { open = "`", close = "`" },
                { open = "(", close = ")" },
                { open = "[", close = "]" },
                { open = "{", close = "}" },
            },
            ignore_beginning = true,
            exclude = {},
        })
    end,
}
