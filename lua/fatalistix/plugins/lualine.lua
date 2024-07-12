-- статусбар, аналог vim-airline, но написан на lua
-- statusbar, written in lua
-- https://github.com/nvim-lualine/lualine.nvim
return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    opts = {
        options = {
            icons_enabled = true,
            -- component_separators = { left = '', right = '' },
            component_separators = { left = '', right = '' },
            -- section_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
            disabled_filetypes = {
                statusline = {},
                winbar = {},
            },
            ignore_focus = {},
            always_divide_middle = true,
            globalstatus = false,
            refresh = {
                statusline = 1000,
                tabline = 1000,
                winbar = 1000,
            },
        },
        sections = {
            lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
            lualine_b = { 'branch' },
            lualine_c = { 'diff', 'diagnostics', 'aerial' },
            lualine_x = { 'filename' },
            lualine_y = { 'encoding', 'filetype' },
            lualine_z = { { 'location', separator = { right = '' }, left_padding = 2 } },
        },
        inactive_sections = {
            lualine_a = { { 'filename', separator = { left = '', right = '' }, right_padding = 2 } },
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = { { 'location', separator = { left = '', right = '' }, left_padding = 2 } },
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = { 'aerial', 'lazy', 'nvim-dap-ui', 'nvim-tree', 'toggleterm', 'trouble' },
    },
}
