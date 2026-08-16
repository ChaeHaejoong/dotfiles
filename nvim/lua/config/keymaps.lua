local keymap = vim.keymap.set

-- Use comma as an alias for the Space leader key.
keymap({ "n", "x" }, ",", "<Space>", { remap = true })

keymap({ "n", "x" }, "<leader>w", "<C-w>", { desc = "Window commands", remap = true })
keymap("n", "<leader>s", "<cmd>write<cr>", { desc = "Save file", silent = true, nowait = true })
keymap("n", "<leader>S", "<cmd>wall<cr>", { desc = "Save all files", silent = true, nowait = true })

-- Window navigation
keymap("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Window resizing
keymap("n", "<A-h>", "<C-w><", { desc = "Decrease window width" })
keymap("n", "<A-l>", "<C-w>>", { desc = "Increase window width" })
keymap("n", "<A-j>", "<C-w>-", { desc = "Decrease window height" })
keymap("n", "<A-k>", "<C-w>+", { desc = "Increase window height" })
