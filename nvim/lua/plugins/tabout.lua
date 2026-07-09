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

        vim.keymap.set("i", "<Tab>", function()
            if vim.fn.pumvisible() == 1 then
                return "<C-n>"
            end

            return "<Plug>(Tabout)"
        end, { expr = true, silent = true })

        vim.keymap.set("i", "<S-Tab>", function()
            if vim.fn.pumvisible() == 1 then
                return "<C-p>"
            end

            return "<Plug>(TaboutBack)"
        end, { expr = true, silent = true })
    end,
}
