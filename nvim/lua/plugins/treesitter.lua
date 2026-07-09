return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    config = function()
        require("nvim-treesitter").setup({
            install_dir = vim.fn.stdpath("data") .. "/site",
        })

        vim.api.nvim_create_autocmd("FileType", {
            pattern = {
                "c",
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
            },
            callback = function(args)
                pcall(vim.treesitter.start, args.buf)
                vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end,
}
