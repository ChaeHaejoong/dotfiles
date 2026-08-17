return {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    keys = {
        {
            "<leader>n",
            "<cmd>Neotree toggle<cr>",
            desc = "Toggle file explorer",
        },
    },
    opts = {
        enable_git_status = true,
        git_status_async = true,
        enable_refresh_on_write = true,
        filesystem = {
            -- Watch the filesystem directly so changes made outside Neovim
            -- (for example, by shell commands or git) appear automatically.
            use_libuv_file_watcher = true,
            follow_current_file = {
                enabled = true,
                leave_dirs_open = false,
            },
        },
        default_component_configs = {
            indent = {
                expander_collapsed = "",
                expander_expanded = "",
            },
            icon = {
                folder_closed = "",
                folder_open = "",
                folder_empty = "󰜌",
                default = "*",
                highlight = "NeoTreeFileIcon",
            },
            git_status = {
                symbols = {
                    added = "A",
                    modified = "M",
                    deleted = "D",
                    renamed = "R",
                    untracked = "?",
                    ignored = "I",
                    unstaged = "U",
                    staged = "S",
                    conflict = "X",
                },
            },
        },
    },
    config = function(_, opts)
        require("neo-tree").setup(opts)
    end,
}
