-- древовидное представление каталогов
-- https://github.com/nvim-tree/nvim-tree.lua
return {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    opts = function()
        local on_attach = function(bufnr)
            local api = require('nvim-tree.api')

            local function opts(desc)
                return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
            end

            -- default mappings
            api.config.mappings.default_on_attach(bufnr)
        end

        return {
            on_attach = on_attach,
            actions = {
                open_file = {
                    resize_window = false, -- don't resize window when opening file
                },
            },
        }
    end,
    config = function(_, opts)
        require('nvim-tree').setup(opts)

        -- keys section doesn't work for this plugin
        vim.keymap.set('n', '<leader>e', '<Cmd>NvimTreeToggle<CR>', { desc = 'Open nvim-tree' })
    end,
}
