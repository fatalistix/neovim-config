-- автозакрывающиеся тэги html
return {
    'windwp/nvim-ts-autotag',
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
    config = function()
        require('nvim-ts-autotag').setup({
            filetypes = { 'html', 'xml' },
        })
    end,
}
