local keymap = vim.keymap.set

-- File save
keymap("n", "<leader>w", "<cmd>write<cr>", { desc = "Save file", silent = true, nowait = true })

-- Window navigation
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")

-- Window resizing
keymap("n", "<A-h>", "<C-w><")
keymap("n", "<A-l>", "<C-w>>")
keymap("n", "<A-j>", "<C-w>-")
keymap("n", "<A-k>", "<C-w>+")
