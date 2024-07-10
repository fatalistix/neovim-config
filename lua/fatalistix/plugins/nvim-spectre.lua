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
            '<leader>srt',
            function()
                require('spectre').toggle()
            end,
            desc = 'Toggle search and replace in multiple files',
            mode = 'n',
        },
        {
            '<leader>srw',
            function()
                require('spectre').open_visual({ select_word = true })
            end,
            desc = 'Search current word',
            mode = 'n',
        },
        {
            '<leader>srw',
            function()
                require('spectre').open_visual()
            end,
            desc = 'Search current word',
            mode = 'v',
        },
        {
            '<leader>srp',
            function()
                require('spectre').open_file_search({ select_word = true })
            end,
            desc = 'Search on current file',
            mode = 'n',
        },
    },
}
