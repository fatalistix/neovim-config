-- search/replace in multiple files
-- https://github.com/nvim-pack/nvim-spectre
return {
    'nvim-pack/nvim-spectre',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    build = false,
    cmd = 'Spectre',
    opts = { open_cmd = 'noswapfile vnew' },
    keys = {
        {
            '<leader>sr',
            function()
                require('spectre').open()
            end,
            desc = 'Replace in files (Sprectre)',
        },
    },
}
