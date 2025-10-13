-- .config/nvim/lua/bou/remap.lua
vim.g.mapleader = " "

-- Use nvim-tree instead of netrw
vim.keymap.set("n", "<leader>pv", ":NvimTreeToggle<CR>")


-- LSP mappings (will be set in lsp.lua)
vim.keymap.set('n', '<leader>lf', ':lua vim.lsp.buf.format()<CR>', { desc = 'Format code' })
vim.keymap.set('n', '<leader>lr', ':lua vim.lsp.buf.rename()<CR>', { desc = 'Rename symbol' })

-- Window navigation
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to window below' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to window above' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to window right' })
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to window left' })

-- Set colorscheme
--vim.cmd("colorscheme onedark")
--vim.cmd("colorscheme kanagawa")
vim.cmd("colorscheme rose-pine")
--vim.cmd("colorscheme kanagawa-paper")
