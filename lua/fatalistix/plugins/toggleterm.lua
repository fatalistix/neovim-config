return {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {

    },
    config = function(_, opts)
        require('toggleterm').setup(opts)

        vim.keymap.set('n', '<leader>tf', ":ToggleTerm direction=float<cr>", { noremap = true, desc = 'Float terminal' })
        vim.keymap.set('n', '<leader>th', ":ToggleTerm direction=horizontal size=20<cr>", { noremap = true, desc = 'Horizontal terminal' })
        vim.keymap.set('n', '<leader>tv', ":ToggleTerm direction=vertical size=70<cr>", { noremap = true, desc = 'Vertical terminal' })
    end,
}
