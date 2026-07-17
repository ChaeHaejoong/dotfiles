vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.hidden = true
vim.opt.shell = "fish"
vim.opt.ttimeoutlen = 10
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.updatetime = 250
vim.opt.clipboard = "unnamedplus"

if vim.fn.executable("fcitx5-remote") == 1 then
    local im_group = vim.api.nvim_create_augroup("ForceEnglishInput", { clear = true })

    local function force_english_input()
        vim.fn.system({ "fcitx5-remote", "-c" })
    end

    vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
        group = im_group,
        callback = force_english_input,
    })
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	callback = function()
		vim.bo.tabstop = 2
		vim.bo.shiftwidth = 2
		vim.bo.softtabstop = 2
	end,
})

vim.g.mapleader = " "
vim.g.maplocalleader = " "
