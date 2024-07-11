-- treesitter plugin (подсветка текста)
-- https://github.com/nvim-treesitter/nvim-treesitter
return {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPre', 'BufNewFile' },
    build = ':TSUpdate',
    opts = {
        highlight = { enable = true },
        indent = { enable = true },
    },
}
