-- Hide some blocks of code by using dropdown arrows like in ide
return {
    'kevinhwang91/nvim-ufo',
    dependencies = {
        'kevinhwang91/promise-async',
        'luukvbaal/statuscol.nvim',
    },
    event = 'BufRead',
    keys = {
        {
            'zR',
            function()
                require('ufo').openAllFolds()
            end,
            desc = 'Open all folds',
        },
        {
            'zM',
            function()
                require('ufo').closeAllFolds()
            end,
            desc = 'Close all folds',
        },
        {
            'zr',
            function()
                require('ufo').openFoldsExceptKinds()
            end,
            desc = 'Open folds except kinds',
        },
        {
            'zm',
            function()
                require('ufo').closeFoldsWith()
            end,
            desc = 'Fold more',
        },
        {
            'zp',
            function()
                local winid = require('ufo').peekFoldedLinesUnderCursor()
                if not winid then
                    vim.lsp.buf.hover()
                end
            end,
            desc = 'Peek fold',
        },
    },
    config = function()
        require('ufo').setup({
            close_fold_kinds_for_ft = {
                default = { 'imports', 'comment' },
                json = { 'array' },
                c = { 'comment', 'region' },
            },
            preview = {
                mappings = {
                    scrollB = '<C-B>',
                    scrollF = '<C-F>',
                    scrollU = '<C-U>',
                    scrollD = '<C-D>',
                },
            },
        })
    end,
}
