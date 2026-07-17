return {
	"okuuva/auto-save.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"stevearc/conform.nvim",
	},
	init = function()
		local group = vim.api.nvim_create_augroup("AutoSaveFormat", { clear = true })

		vim.api.nvim_create_autocmd("User", {
			pattern = "AutoSaveWritePre",
			group = group,
			callback = function(opts)
				local buf = opts.data and opts.data.saved_buffer or opts.buf
				if not buf or not vim.api.nvim_buf_is_valid(buf) or vim.bo[buf].buftype ~= "" then
					return
				end

				require("conform").format({
					bufnr = buf,
					async = false,
					timeout_ms = 2000,
					lsp_format = "fallback",
				})
			end,
		})
	end,
	opts = {
		enabled = true,
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
