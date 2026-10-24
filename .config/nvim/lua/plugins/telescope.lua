return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-live-grep-args.nvim",
			version = "^1.0.0",
		},
	},
	keys = {
		{
			"<leader>sg",
			function()
				require("telescope").extensions.live_grep_args.live_grep_args()
			end,
			desc = "Live grep with arguments",
		},
	},
	config = function()
		local telescope = require("telescope")
		local lga_actions = require("telescope-live-grep-args.actions")

		telescope.setup({
			extensions = {
				live_grep_args = {
					auto_quoting = true,
					mappings = {
						i = {
							["<C-k>"] = lga_actions.quote_prompt(),
							["<C-Space>"] = lga_actions.to_fuzzy_refine,
						},
					},
				},
			},
		})
		telescope.load_extension("live_grep_args")
	end,
}
