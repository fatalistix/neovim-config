-- комментарии
-- https://github.com/numToStr/Comment.nvim
return {
    'numToStr/Comment.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = true -- runs require('Comment').setup()
}
