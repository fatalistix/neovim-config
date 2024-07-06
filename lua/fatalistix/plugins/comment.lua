-- комментарии
-- https://github.com/numToStr/Comment.nvim
return {
    'numToStr/Comment.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    lazy = false,
    config = function()
        require('Comment').setup()
        local api = require('Comment.api')
        vim.keymap.set('n', '<leader>/', function()
            api.toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1)
        end, { desc = 'Toggle comment line' })
        vim.keymap.set(
            'v',
            '<leader>/',
            "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
            { desc = 'Toggle comment for selection' }
        )
    end,
}
