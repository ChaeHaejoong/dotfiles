return {
	"akinsho/toggleterm.nvim",
	version = "*",
	event = "VeryLazy",
	cmd = { "ToggleTerm", "TermExec", "ToggleTermSetName" },
	keys = {
		{
			"<leader>tt",
			function()
				vim.cmd("ToggleTerm")
			end,
			desc = "Toggle terminal",
		},
		{
			"<leader>t1",
			function()
				vim.cmd("1ToggleTerm")
			end,
			desc = "Toggle terminal 1",
		},
		{
			"<leader>t2",
			function()
				vim.cmd("2ToggleTerm")
			end,
			desc = "Toggle terminal 2",
		},
		{
			"<leader>t3",
			function()
				vim.cmd("3ToggleTerm")
			end,
			desc = "Toggle terminal 3",
		},
		{
			"<leader>t4",
			function()
				vim.cmd("4ToggleTerm")
			end,
			desc = "Toggle terminal 4",
		},
		{
			"<leader>t5",
			function()
				vim.cmd("5ToggleTerm")
			end,
			desc = "Toggle terminal 5",
		},
		{
			"<leader>t6",
			function()
				vim.cmd("6ToggleTerm")
			end,
			desc = "Toggle terminal 6",
		},
		{
			"<leader>t7",
			function()
				vim.cmd("7ToggleTerm")
			end,
			desc = "Toggle terminal 7",
		},
		{
			"<leader>t8",
			function()
				vim.cmd("8ToggleTerm")
			end,
			desc = "Toggle terminal 8",
		},
		{
			"<leader>t9",
			function()
				vim.cmd("9ToggleTerm")
			end,
			desc = "Toggle terminal 9",
		},
		{
			"<leader>t0",
			function()
				vim.cmd("10ToggleTerm")
			end,
			desc = "Toggle terminal 10",
		},
		{ "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Floating terminal" },
		{ "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Horizontal terminal" },
		{ "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Vertical terminal" },
	},
	opts = {
		shade_terminals = true,
		start_in_insert = true,
		persist_size = true,
		persist_mode = true,
		hidden = true,
		direction = "float",
		size = function(term)
			if term.direction == "horizontal" then
				return math.floor(vim.o.lines * 0.3)
			end

			if term.direction == "vertical" then
				return math.floor(vim.o.columns * 0.4)
			end

			return 20
		end,
		float_opts = {
			border = "curved",
		},
	},
	config = function(_, opts)
		require("toggleterm").setup(opts)

		local group = vim.api.nvim_create_augroup("ToggleTermKeymaps", { clear = true })

		vim.api.nvim_create_autocmd("TermOpen", {
			group = group,
			pattern = "term://*toggleterm#*",
			callback = function(args)
				local opts = { buffer = args.buf, silent = true }

				vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
				vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
				vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
			end,
		})
	end,
}
