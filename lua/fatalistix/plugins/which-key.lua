-- wichkey - показывает подсказки по mappings
-- https://github.com/folke/which-key.nvim
return {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
        plugins = { spelling = true },
        defaults = {
            mode = { 'n', 'v' },
            [']'] = { name = '+next' },
            ['['] = { name = '+prev' },
            ['g'] = { name = '+goto' },
            ['z'] = { name = '+folds' },
            ['<leader>'] = { name = '+special mappings' },
            ['<leader>a'] = { name = '+aerial (symbols)' },
            ['<leader>b'] = { name = '+buffers' },
            ['<leader>c'] = { name = '+code' },
            ['<leader>d'] = { name = '+debug' },
            ['<leader>f'] = { name = '+files' },
            ['<leader>g'] = { name = '+git' },
            ['<leader>h'] = { name = '+harpoon (marks)' },
            ['<leader>n'] = { name = '+neotest' },
            ['<leader>q'] = { name = '+session' },
            ['<leader>s'] = { name = '+search/replace' },
            ['<leader>sr'] = { name = '+multiple replace (spectre)' },
            ['<leader>sn'] = { name = '+noice' },
            ['<leader>t'] = { name = '+terminal' },
            ['<leader>u'] = { name = '+ui' },
            ['<leader>w'] = { name = '+windows' },
            ['<leader><leader>'] = { name = '+move buffers' },
            ['<leader><Tab>'] = { name = '+tabs' },
        },
    },
    config = function(_, opts)
        local wk = require('which-key')
        wk.setup(opts)
        wk.register(opts.defaults)
    end,
}
