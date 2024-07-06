-- цветные и не очень отступы как в ide (области видимости и всякое подобное)
return {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
    main = 'ibl',
    config = function()
        require('ibl').setup()
    end,
}
