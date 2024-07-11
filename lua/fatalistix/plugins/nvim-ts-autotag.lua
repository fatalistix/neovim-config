-- автозакрывающиеся тэги html
return {
    'windwp/nvim-ts-autotag',
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
    opts = {
        filetypes = { 'html', 'xml' },
    },
}
