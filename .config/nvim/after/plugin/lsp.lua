-- .config/nvim/after/plugin/lsp.lua
local lsp = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Setup Mason to automatically install LSP servers
require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = { 
        "lua_ls",       -- Lua
        "ts_ls", -- TypeScript/JavaScript (using correct name)
        "pyright",      -- Python
        "clangd",       -- C/C++
        "jsonls",       -- JSON
        "html",         -- HTML
        "cssls",        -- CSS
        "gopls",        -- Go
        "rust_analyzer" -- Rust
    },
    automatic_installation = true,
})

-- Configure each language server
lsp.lua_ls.setup {
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' } -- Recognize vim as a global
            }
        }
    }
}


-- Note: tsserver is deprecated but still works. Use typescript-language-server in mason install list.

-- Setup other common servers with default config
local servers = { 'pyright', 'clangd', 'jsonls', 'html', 'cssls', 'gopls', 'rust_analyzer' }
for _, server in ipairs(servers) do
    lsp[server].setup {
        capabilities = capabilities,
    }
end

-- Global LSP keymappings
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        local opts = { buffer = ev.buf }

        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<leader>k', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<leader>td', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<leader>f', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end,
})

-- Show diagnostics in a floating window
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- Configure diagnostics display
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        source = 'always',
        border = 'rounded',
    },
})
