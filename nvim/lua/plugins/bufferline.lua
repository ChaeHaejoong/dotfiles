return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	event = "VeryLazy",
	keys = {
		{ "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous buffer" },
		{ "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
		{ "<leader>bp", "<cmd>BufferLinePick<cr>", desc = "Pick buffer" },
		{ "<leader>bP", "<cmd>BufferLinePickClose<cr>", desc = "Pick buffer to close" },
		{ "<leader>bc", "<cmd>bdelete<cr>", desc = "Close current buffer" },
		{ "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "Close other buffers" },
		{ "<leader>bl", "<cmd>BufferLineCloseLeft<cr>", desc = "Close buffers to the left" },
		{ "<leader>br", "<cmd>BufferLineCloseRight<cr>", desc = "Close buffers to the right" },
		{ "<A-h>", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer left" },
		{ "<A-l>", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer right" },
	},
	opts = {
		options = {
			mode = "buffers",
			numbers = "none",
			separator_style = "slant",
			show_buffer_close_icons = true,
			show_close_icon = false,
			always_show_bufferline = true,
			diagnostics = "nvim_lsp",
			diagnostics_indicator = function(_, _, diagnostics)
				local icons = { error = "E", warning = "W", info = "I", hint = "H" }
				local parts = {}
				for name, count in pairs(diagnostics) do
					local icon = icons[string.lower(name)]
					if icon and count > 0 then
						table.insert(parts, icon .. count)
					end
				end

				return table.concat(parts, " ")
			end,
		},
	},
	config = function(_, opts)
		require("bufferline").setup(opts)
	end,
}
