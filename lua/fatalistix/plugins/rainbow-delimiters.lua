-- rainbow brackets and something else
return {
    'HiPhish/rainbow-delimiters.nvim',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
    },
    opts = {},
    config = function(_, opts)
        require('rainbow-delimiters.setup').setup(opts)

        vim.g.rainbow_delimiters = {
            highlight = require('fatalistix.util.ui').rainbowHighlight,
        }
    end,
}
