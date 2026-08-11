return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "ConformInfo" },
    opts = {
        formatters_by_ft = {
            javascript = { "prettier" },
            javascriptreact = { "prettier" },
            typescript = { "prettier" },
            typescriptreact = { "prettier" },
            json = { "prettier" },
            jsonc = { "prettier" },
            css = { "prettier" },
            scss = { "prettier" },
            html = { "prettier" },
            markdown = { "prettier" },
            lua = { "stylua" },
            c = { "clang-format" },
            cpp = { "clang-format" },
        },
        format_on_save = function(bufnr)
            local filetype = vim.bo[bufnr].filetype
            if filetype == "lua" or filetype == "javascript" or filetype == "javascriptreact"
                or filetype == "typescript" or filetype == "typescriptreact"
                or filetype == "json" or filetype == "jsonc"
                or filetype == "css" or filetype == "scss"
                or filetype == "html" or filetype == "markdown"
                or filetype == "c" or filetype == "cpp" then
                return {
                    timeout_ms = 2000,
                    lsp_format = "fallback",
                }
            end
        end,
    },
}
