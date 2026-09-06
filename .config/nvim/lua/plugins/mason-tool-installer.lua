return {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
    },
    opts = {
        ensure_installed = {
            "prettier",
        },
        run_on_start = true,
    },
}
