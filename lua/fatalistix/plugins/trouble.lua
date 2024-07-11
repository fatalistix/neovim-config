-- улучшенный вывод списка диагностик (список снизу как в ide)
-- https://github.com/folke/trouble.nvim
return {
    'folke/trouble.nvim',
    cmd = 'Trouble',
    opts = {
        win = {
            position = 'right',
            zindex = 1000,
        },
    },
    keys = {
        { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics (Trouble)' },
        { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer diagnostics (Trouble)' },
        { '<leader>cs', '<cmd>Trouble symbols toggle<cr>', desc = 'Symbols (Trouble)' },
        { '<leader>cS', '<cmd>Trouble lsp toggle<cr>', desc = 'LSP references/definitions/... (Trouble)' },
        { '<leader>xL', '<cmd>Trouble loclist toggle<cr>', desc = 'Location List (Trouble)' },
        { '<leader>xQ', '<cmd>Trouble quickfix toggle<cr>', desc = 'Quickfix List (Trouble)' },
        {
            '[q',
            function()
                if require('trouble').is_open() then
                    require('trouble').previous({ skip_groups = true, jump = true })
                else
                    local ok, err = pcall(vim.cmd.cprev)
                    if not ok then
                        vim.notify(err, vim.log.levels.ERROR)
                    end
                end
            end,
            desc = 'Previous trouble/quickfix item',
        },
        {
            ']q',
            function()
                if require('trouble').is_open() then
                    require('trouble').next({ skip_groups = true, jump = true })
                else
                    local ok, err = pcall(vim.cmd.cnext)
                    if not ok then
                        vim.notify(err, vim.log.levels.ERROR)
                    end
                end
            end,
            desc = 'Next trouble/quickfix item',
        },
    },
}
