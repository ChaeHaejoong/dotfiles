# Autocomplete and JS Tab Size Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add LSP-backed completion with path and buffer sources, and make JavaScript buffers use a 2-space tab width.

**Architecture:** Add a dedicated completion plugin spec that configures `nvim-cmp` and its sources. Update LSP capabilities so language servers integrate cleanly with completion. Keep filetype-specific indentation isolated in the shared options file via an autocommand.

**Tech Stack:** Neovim Lua, `nvim-cmp`, `cmp-nvim-lsp`, `cmp-buffer`, `cmp-path`, `nvim-lspconfig`

---

### Task 1: Add completion plugin configuration

**Files:**
- Create: `lua/plugins/cmp.lua`
- Modify: `lua/plugins/lsp.lua`

- [ ] **Step 1: Add the new completion spec**

```lua
return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        local cmp = require("cmp")

        cmp.setup({
            completion = {
                completeopt = "menu,menuone,noselect",
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                ["<Tab>"] = cmp.mapping.select_next_item(),
                ["<S-Tab>"] = cmp.mapping.select_prev_item(),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "path" },
                { name = "buffer" },
            }),
        })
    end,
}
```

- [ ] **Step 2: Wire LSP capabilities into the existing LSP config**

```lua
return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        local lspconfig = require("lspconfig")
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        lspconfig.util.default_config.capabilities = vim.tbl_deep_extend(
            "force",
            lspconfig.util.default_config.capabilities or {},
            capabilities
        )

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true }),
            callback = function(args)
                local bufnr = args.buf
                local opts = { buffer = bufnr, silent = true }

                vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
                vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Go to references" }))
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
                vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover documentation" }))
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))
                vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
                vim.keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
                vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Open diagnostic float" }))
                vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, vim.tbl_extend("force", opts, { desc = "Populate location list" }))
                vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, vim.tbl_extend("force", opts, { desc = "Add workspace folder" }))
                vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, vim.tbl_extend("force", opts, { desc = "Remove workspace folder" }))
                vim.keymap.set("n", "<leader>wl", function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, vim.tbl_extend("force", opts, { desc = "List workspace folders" }))
            end,
        })
    end,
}
```

- [ ] **Step 3: Verify the completion config loads**

Run: `nvim --headless -u NONE -c "set rtp+=/home/chaehaejoong/.config/nvim" -c "lua assert(dofile('/home/chaehaejoong/.config/nvim/lua/plugins/cmp.lua'))" -c "lua assert(dofile('/home/chaehaejoong/.config/nvim/lua/plugins/lsp.lua'))" -c "lua dofile('/home/chaehaejoong/.config/nvim/lua/config/options.lua')" -c q`
Expected: Lua files load without syntax or runtime errors.

### Task 2: Make JavaScript buffers use 2-space tabs

**Files:**
- Modify: `lua/config/options.lua`

- [ ] **Step 1: Add a JavaScript filetype autocommand**

```lua
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "javascript", "javascriptreact" },
    callback = function()
        vim.bo.tabstop = 2
        vim.bo.shiftwidth = 2
        vim.bo.softtabstop = 2
    end,
})
```

- [ ] **Step 2: Verify indentation is filetype-specific**

Run: `nvim --headless -u NONE -c "set rtp+=/home/chaehaejoong/.config/nvim" -c "lua dofile('/home/chaehaejoong/.config/nvim/lua/config/options.lua')" -c "edit test.js" -c "set filetype=javascript" -c "verbose set tabstop? shiftwidth? softtabstop?" -c q`
Expected: JavaScript buffers use `tabstop=2`, while other filetypes keep the global defaults.
