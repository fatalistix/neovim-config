-- git integration in files
-- https://github.com/lewis6991/gitsigns.nvim
return {
    'lewis6991/gitsigns.nvim',
    opts = {
        ---@param bufnr number?
        on_attach = function(bufnr)
            local gitsigns = require('gitsigns')

            vim.keymap.set('n', ']c', function()
                gitsigns.nav_hunk('next')
            end, { desc = 'Next hunk' })

            vim.keymap.set('n', '[c', function()
                gitsigns.nav_hunk('prev')
            end, { desc = 'Prev hunk' })

            vim.keymap.set('n', '<leader>ghs', gitsigns.stage_hunk, { desc = 'Stage hunk' })
            vim.keymap.set('n', '<leader>ghr', gitsigns.reset_hunk, { desc = 'Reset hunk' })
            vim.keymap.set('n', '<leader>ghu', gitsigns.undo_stage_hunk, { desc = 'Unstage hunk' })
            vim.keymap.set('n', '<leader>ghp', gitsigns.preview_hunk, { desc = 'Preview hunk' })
            vim.keymap.set('n', '<leader>gBs', gitsigns.stage_buffer, { desc = 'Stage buffer' })
            vim.keymap.set('n', '<leader>gBr', gitsigns.reset_buffer, { desc = 'Reset buffer' })
            vim.keymap.set('n', '<leader>gbl', function()
                gitsigns.blame_line({ full = true })
            end, { desc = 'Blame line' })
            vim.keymap.set(
                'n',
                '<leader>gbt',
                gitsigns.toggle_current_line_blame,
                { desc = 'Toggle current line blame' }
            )
            vim.keymap.set('n', '<leader>gdt', gitsigns.diffthis, { desc = 'Show diff' })
            vim.keymap.set('n', '<leader>gdc', function()
                gitsigns.diffthis('~')
            end, { desc = 'Show diff' })
            vim.keymap.set('n', '<leader>gdd', gitsigns.toggle_deleted, { desc = 'Toggle deleted' })

            -- Text object
            vim.keymap.set({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')

            -- For virtual mode
            vim.keymap.set('v', '<leader>ghs', function()
                gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
            end, { desc = 'Stage hunk' })
            vim.keymap.set('v', '<leader>ghr', function()
                gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
            end, { desc = 'Reset hunk' })
        end,
    },
}
