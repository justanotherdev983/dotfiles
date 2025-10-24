require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'rose-pine',
        component_separators = { left = '│', right = '│' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = {
            {
                'mode',
                icon = '󰀘',
                separator = { right = '' },
                padding = { left = 1, right = 2 },
            }
        },
        lualine_b = {
            {
                'branch',
                icon = '',
                separator = { right = '' },
                padding = { left = 2, right = 1 },
            },
            {
                'diff',
                symbols = {
                    added = ' ',
                    modified = ' ',
                    removed = ' '
                },
                diff_color = {
                    added = { fg = '#9ccfd8' },
                    modified = { fg = '#f6c177' },
                    removed = { fg = '#eb6f92' },
                },
                separator = { right = '' },
                padding = { left = 1, right = 1 },
            },
        },
        lualine_c = {
            {
                'diagnostics',
                sources = { 'nvim_diagnostic' },
                symbols = {
                    error = ' ',
                    warn = ' ',
                    info = ' ',
                    hint = '󰌵 '
                },
                diagnostics_color = {
                    error = { fg = '#eb6f92' },
                    warn = { fg = '#f6c177' },
                    info = { fg = '#9ccfd8' },
                    hint = { fg = '#c4a7e7' },
                },
                padding = { left = 2, right = 1 },
            },
            {
                'filename',
                file_status = true,
                newfile_status = true,
                path = 1,
                symbols = {
                    modified = ' 󰷥',
                    readonly = ' ',
                    unnamed = '󰓂 [No Name]',
                    newfile = ' [New]',
                },
                color = { fg = '#e0def4' },
                padding = { left = 1, right = 1 },
            }
        },
        lualine_x = {
            {
                -- LSP server name
                function()
                    local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
                    if #buf_clients == 0 then
                        return ""
                    end
                    local buf_client_names = {}
                    for _, client in pairs(buf_clients) do
                        table.insert(buf_client_names, client.name)
                    end
                    return "󰒓 " .. table.concat(buf_client_names, ", ")
                end,
                color = { fg = '#c4a7e7' },
                separator = { left = '' },
                padding = { left = 1, right = 1 },
            },
            {
                'encoding',
                icon = '󰉿',
                color = { fg = '#9ccfd8' },
                padding = { left = 1, right = 1 },
            },
            {
                'fileformat',
                symbols = {
                    unix = '',
                    dos = '',
                    mac = '',
                },
                color = { fg = '#f6c177' },
                padding = { left = 1, right = 1 },
            },
            {
                'filetype',
                icon_only = false,
                colored = true,
                separator = { left = '' },
                padding = { left = 1, right = 2 },
            }
        },
        lualine_y = {
            {
                'progress',
                icon = '󰦨',
                separator = { left = '' },
                padding = { left = 2, right = 1 },
            }
        },
        lualine_z = {
            {
                'location',
                icon = '',
                separator = { left = '' },
                padding = { left = 1, right = 1 },
            }
        }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
            {
                'filename',
                file_status = true,
                path = 1,
                color = { fg = '#6e6a86' },
            }
        },
        lualine_x = {
            {
                'location',
                color = { fg = '#6e6a86' },
            }
        },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = { 'nvim-tree', 'toggleterm', 'quickfix', 'lazy' }
}
