return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		local cmp = require("cmp")
		local has_luasnip, luasnip = pcall(require, "luasnip")

		local function has_words_before()
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			if col == 0 then
				return false
			end

			local current_line = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1] or ""
			return current_line:sub(col, col):match("%s") == nil
		end

		local function jump_snippet(direction)
			if has_luasnip then
				if direction > 0 and luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
					return true
				end

				if direction < 0 and luasnip.jumpable(direction) then
					luasnip.jump(direction)
					return true
				end
			end

			if vim.snippet and vim.snippet.active({ direction = direction }) then
				vim.snippet.jump(direction)
				return true
			end

			return false
		end

		cmp.setup({
			snippet = {
				expand = function(args)
					vim.snippet.expand(args.body)
				end,
			},
			completion = {
				completeopt = "menu,menuone,noselect",
			},
			mapping = cmp.mapping.preset.insert({
				["<C-Space>"] = cmp.mapping.complete(),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<C-j>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif jump_snippet(1) then
						return
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<C-k>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif jump_snippet(-1) then
						return
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "path" },
				{ name = "buffer" },
			}),
		})
	end,
}
