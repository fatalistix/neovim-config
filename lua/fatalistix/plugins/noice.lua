return {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
        'MunifTanjim/nui.nvim',
        'rcarriga/nvim-notify',
    },
    opts = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        lsp = {
            override = {
                ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                ['vim.lsp.util.stylize_markdown'] = true,
                ['cmp.entry.get_documentation'] = true,
            },
            signature = {
                enabled = false,
            },
        },
        presets = {
            bottom_search = true,
            command_palette = true,
            long_message_to_split = true,
            inc_rename = false,
            lsp_doc_border = false,
        },
    },
    keys = {
        {
            '<leader>snl',
            function()
                require('noice').cmd('last')
            end,
            desc = 'Noice last message',
        },
        {
            '<leader>snh',
            function()
                require('noice').cmd('history')
            end,
            desc = 'Noice history',
        },
        {
            '<leader>sna',
            function()
                require('noice').cmd('all')
            end,
            desc = 'Noice all',
        },
        {
            '<leader>snd',
            function()
                require('noice').cmd('dismiss')
            end,
            desc = 'Dismiss All',
        },
        {
            '<leader>snt',
            function()
                require('noice').cmd('pick')
            end,
            desc = 'Noice Picker (Telescope/FzfLua)',
        },
    },
    config = function(_, opts)
        -- HACK: noice shows messages from before it was enabled,
        -- but this is not ideal when Lazy is installing plugins,
        -- so clear the messages in this case.
        if vim.o.filetype == 'lazy' then
            vim.cmd([[messages clear]])
        end
        require('noice').setup(opts)
    end,
}
