local keymap = vim.keymap.set

keymap({ "n", "x" }, "<leader>w", "<C-w>", { desc = "Window commands", remap = true })
keymap("n", "<leader>s", "<cmd>write<cr>", { desc = "Save file", silent = true, nowait = true })
keymap("n", "<leader>S", "<cmd>wall<cr>", { desc = "Save all files", silent = true, nowait = true })
