-- цветные и не очень отступы как в ide (области видимости и всякое подобное)
-- colored indentes like in IDEs
-- https://github.com/lukas-reineke/indent-blankline.nvim
return {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
    main = 'ibl',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'HiPhish/rainbow-delimiters.nvim',
    },
    opts = {
        scope = {
            highlight = require('fatalistix.util.ui').rainbowHighlight,
        },
    },
    config = function(_, opts)
        require('ibl').setup(opts)

        local hooks = require('ibl.hooks')
        hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end,
}
