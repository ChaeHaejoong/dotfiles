return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	keys = {
		{ "]c", function() require("gitsigns").next_hunk() end, desc = "Next Git hunk" },
		{ "[c", function() require("gitsigns").prev_hunk() end, desc = "Previous Git hunk" },
		{ "<leader>hs", function() require("gitsigns").stage_hunk() end, desc = "Stage hunk" },
		{ "<leader>hr", function() require("gitsigns").reset_hunk() end, desc = "Reset hunk" },
		{ "<leader>hp", function() require("gitsigns").preview_hunk() end, desc = "Preview hunk" },
		{ "<leader>hb", function() require("gitsigns").blame_line() end, desc = "Blame line" },
		{ "<leader>hd", function() require("gitsigns").diffthis() end, desc = "Diff file" },
	},
	opts = {
		signs = {
			add = { text = "+" },
			change = { text = "~" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
		},
		current_line_blame = false,
	},
}
