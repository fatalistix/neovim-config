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
            '<leader>qS',
            function()
                require('persistence').select()
            end,
            desc = 'Select a session to load',
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
        {
            '<leader>qw',
            function()
                require('persistence').save()
            end,
            desc = 'Save session',
        },
        {
            '<leader>qW',
            function()
                require('persistence').start()
            end,
            desc = 'Start session autosaving',
        },
    },
}
