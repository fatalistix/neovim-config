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
        { '<leader>cx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics' },
        { '<leader>cX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer diagnostics' },
        { '<leader>cs', '<cmd>Trouble symbols toggle<cr>', desc = 'Symbols' },
        { '<leader>cS', '<cmd>Trouble lsp toggle<cr>', desc = 'LSP references/definitions/...' },
        { '<leader>cL', '<cmd>Trouble loclist toggle<cr>', desc = 'Location list' },
        { '<leader>cQ', '<cmd>Trouble quickfix toggle<cr>', desc = 'Quickfix list' },
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
