-- Более удобное управление размерами окон
return {
    'mrjones2014/smart-splits.nvim',
    opts = {},
    config = function(_, opts)
        require('smart-splits').setup(opts)

        -- recommended mappings
        -- resizing splits
        -- these keymaps will also accept a range,
        -- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
        vim.keymap.set('n', '<A-h>', require('smart-splits').resize_left, { desc = 'Resize left' })
        vim.keymap.set('n', '<A-j>', require('smart-splits').resize_down, { desc = 'Resize down' })
        vim.keymap.set('n', '<A-k>', require('smart-splits').resize_up, { desc = 'Resize up' })
        vim.keymap.set('n', '<A-l>', require('smart-splits').resize_right, { desc = 'Resize right' })
        -- moving between splits
        vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left, { desc = 'Move cursor left' })
        vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down, { desc = 'Move cursor down' })
        vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up, { desc = 'Move cursor up' })
        vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right, { desc = 'Move cursor right' })
        vim.keymap.set('n', '<C-\\>', require('smart-splits').move_cursor_previous, { desc = 'Move cursor previous' })
        -- swapping buffers between windows
        vim.keymap.set('n', '<leader><leader>h', require('smart-splits').swap_buf_left, { desc = 'Swap buffers left' })
        vim.keymap.set('n', '<leader><leader>j', require('smart-splits').swap_buf_down, { desc = 'Swap buffers down' })
        vim.keymap.set('n', '<leader><leader>k', require('smart-splits').swap_buf_up, { desc = 'Swap buffers up' })
        -- stylua: ignore
        vim.keymap.set('n', '<leader><leader>l', require('smart-splits').swap_buf_right, { desc = 'Swap buffers right' })
    end,
}
