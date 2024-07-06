-- цветовая схема
-- https://github.com/aktersnurra/no-clown-fiest.nvim
return {
    'aktersnurra/no-clown-fiesta.nvim',
    dependencies = {
        'RRethy/vim-illuminate',
    },
    priority = 1000,
    config = function()
        require('no-clown-fiesta').setup()
        vim.cmd.colorscheme('no-clown-fiesta')

        local palette = require('no-clown-fiesta.palette')

        local highlights = {
            IlluminatedWord = { bg = palette.accent },
            IlluminatedCurWord = { bg = palette.accent },
            IlluminatedWordText = { bg = palette.accent },
            IlluminatedWordRead = { bg = palette.accent },
            IlluminatedWordWrite = { bg = palette.accent },
        }

        for group, value in pairs(highlights) do
            vim.api.nvim_set_hl(0, group, value)
        end
    end,
}
