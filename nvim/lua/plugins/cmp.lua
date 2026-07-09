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
        local has_tabout, tabout = pcall(require, "tabout")

        local closing_chars = {
            ["'"] = true,
            ['"'] = true,
            ["`"] = true,
            [")"] = true,
            ["]"] = true,
            ["}"] = true,
        }

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

        local function next_char()
            local col = vim.api.nvim_win_get_cursor(0)[2]
            local current_line = vim.api.nvim_get_current_line()
            return current_line:sub(col + 1, col + 1)
        end

        local function tabout_forward()
            if has_tabout then
                tabout.tabout()
                return
            end
        end

        local function tabout_backward()
            if has_tabout then
                tabout.taboutBack()
                return
            end
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
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif jump_snippet(1) then
                        return
                    elseif closing_chars[next_char()] then
                        tabout_forward()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        tabout_forward()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif jump_snippet(-1) then
                        return
                    else
                        tabout_backward()
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
