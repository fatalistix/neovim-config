-- разрисовки в коде
-- https://github.com/norcalli/nvim-colorizer.lua
return {
    'norcalli/nvim-colorizer.lua',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
        require('colorizer').setup({
            user_default_options = {
                names = true,
            },
        })
    end,
}
