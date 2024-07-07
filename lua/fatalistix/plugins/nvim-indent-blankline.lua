-- цветные и не очень отступы как в ide (области видимости и всякое подобное)
-- colored indentes like in IDEs
-- https://github.com/lukas-reineke/indent-blankline.nvim
return {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
    main = 'ibl',
    config = function()
        require('ibl').setup()
    end,
}
