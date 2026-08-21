return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    config = function()
        local parser_languages = {
            "c",
            "cpp",
            "go",
            "css",
            "html",
            "javascript",
            "json",
            "lua",
            "markdown",
            "query",
            "tsx",
            "typescript",
            "vim",
        }

        local filetypes = {
            "c",
            "cpp",
            "go",
            "css",
            "html",
            "javascript",
            "json",
            "lua",
            "markdown",
            "query",
            "typescript",
            "typescriptreact",
            "tsx",
            "vim",
        }

        require("nvim-treesitter").setup({
            install_dir = vim.fn.stdpath("data") .. "/site",
        })

        require("nvim-treesitter").install(parser_languages)

        vim.api.nvim_create_autocmd("FileType", {
            pattern = filetypes,
            callback = function(args)
                pcall(vim.treesitter.start, args.buf)
                vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end,
}
