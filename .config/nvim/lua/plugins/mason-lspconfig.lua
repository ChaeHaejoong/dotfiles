return {
    "mason-org/mason-lspconfig.nvim",
    opts = {
        ensure_installed = {
            "bashls",
            "lua_ls",
            "pyright",
            "ts_ls",
            "gopls",
            "yamlls",
        },
        automatic_enable = true,
    },
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
}
