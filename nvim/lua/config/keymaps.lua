local keymap = vim.keymap.set

keymap("n", "<leader>w", "<cmd>write<cr>", { desc = "Save file", silent = true, nowait = true })
keymap("n", "<leader>W", "<cmd>wall<cr>", { desc = "Save all files", silent = true, nowait = true })
