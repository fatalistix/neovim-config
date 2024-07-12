-- Simple session manager for nvim
-- https://github.com/folke/persistence.nvim
return {
    'folke/persistence.nvim',
    event = 'BufReadPre',
    opts = {
        options = vim.opt.sessionoptions:get(),
    },
    keys = {
        {
            '<leader>qs',
            function()
                require('persistence').load()
            end,
            desc = 'Restore session',
        },
        {
            '<leader>ql',
            function()
                require('persistence').load({ last = true })
            end,
            desc = 'Restore last session',
        },
        {
            '<leader>qd',
            function()
                require('persistence').stop()
            end,
            desc = "Don't save current session",
        },
    },
}
