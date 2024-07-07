local setup_vim_illuminate = function()
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
end

local setup_indent_blackline = function()
    local palette = require('no-clown-fiesta.palette')
    local highlights = require('fatalistix.util.ui').rainbowHighlight

    vim.api.nvim_set_hl(0, highlights[1], { fg = palette.red })
    vim.api.nvim_set_hl(0, highlights[2], { fg = palette.yellow })
    vim.api.nvim_set_hl(0, highlights[3], { fg = palette.blue })
    vim.api.nvim_set_hl(0, highlights[4], { fg = palette.orange })
    vim.api.nvim_set_hl(0, highlights[5], { fg = palette.green })
    vim.api.nvim_set_hl(0, highlights[6], { fg = palette.purple })
    vim.api.nvim_set_hl(0, highlights[7], { fg = palette.cyan })
end

-- цветовая схема
-- https://github.com/aktersnurra/no-clown-fiest.nvim
return {
    'aktersnurra/no-clown-fiesta.nvim',
    priority = 1000,
    config = function()
        require('no-clown-fiesta').setup()
        vim.cmd.colorscheme('no-clown-fiesta')

        setup_vim_illuminate()
        setup_indent_blackline()
    end,
}
