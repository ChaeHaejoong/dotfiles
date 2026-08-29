return {
	"okuuva/auto-save.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		enabled = true,
		noautocmd = true,
		trigger_events = {
			immediate_save = { "BufLeave", "FocusLost", "QuitPre", "VimSuspend" },
			defer_save = { "InsertLeave", "TextChanged" },
			cancel_deferred_save = { "InsertEnter" },
		},
		debounce_delay = 0,
		condition = function(buf)
			local buftype = vim.bo[buf].buftype
			local filetype = vim.bo[buf].filetype

			if buftype ~= "" and buftype ~= "acwrite" then
				return false
			end

			if filetype == "toggleterm" then
				return false
			end

			return vim.bo[buf].modifiable and vim.bo[buf].modified
		end,
	},
}
