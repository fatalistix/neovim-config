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

local setup_lualine = function()
    local palette = require('no-clown-fiesta.palette')
end

-- highlight NotifyERRORBorder guifg=#8A1F1F
-- highlight NotifyWARNBorder guifg=#79491D
-- highlight NotifyINFOBorder guifg=#4F6752
-- highlight NotifyDEBUGBorder guifg=#8B8B8B
-- highlight NotifyTRACEBorder guifg=#4F3552
-- highlight NotifyERRORIcon guifg=#F70067
-- highlight NotifyWARNIcon guifg=#F79000
-- highlight NotifyINFOIcon guifg=#A9FF68
-- highlight NotifyDEBUGIcon guifg=#8B8B8B
-- highlight NotifyTRACEIcon guifg=#D484FF
-- highlight NotifyERRORTitle  guifg=#F70067
-- highlight NotifyWARNTitle guifg=#F79000
-- highlight NotifyINFOTitle guifg=#A9FF68
-- highlight NotifyDEBUGTitle  guifg=#8B8B8B
-- highlight NotifyTRACETitle  guifg=#D484FF
-- highlight link NotifyERRORBody Normal
-- highlight link NotifyWARNBody Normal
-- highlight link NotifyINFOBody Normal
-- highlight link NotifyDEBUGBody Normal
-- highlight link NotifyTRACEBody Normal
local setup_nvim_notify = function()
    local palette = require('no-clown-fiesta.palette')

    -- border
    vim.api.nvim_set_hl(0, 'NotifyERRORBorder', { fg = palette.red })
    vim.api.nvim_set_hl(0, 'NotifyWARNBorder', { fg = palette.yellow })
    vim.api.nvim_set_hl(0, 'NotifyINFOBorder', { fg = palette.green })
    vim.api.nvim_set_hl(0, 'NotifyDEBUGBorder', { fg = palette.gray })
    vim.api.nvim_set_hl(0, 'NotifyTRACEBorder', { fg = palette.blue })

    -- icon
    vim.api.nvim_set_hl(0, 'NotifyERRORIcon', { fg = palette.red })
    vim.api.nvim_set_hl(0, 'NotifyWARNIcon', { fg = palette.yellow })
    vim.api.nvim_set_hl(0, 'NotifyINFOIcon', { fg = palette.green })
    vim.api.nvim_set_hl(0, 'NotifyDEBUGIcon', { fg = palette.hint })
    vim.api.nvim_set_hl(0, 'NotifyTRACEIcon', { fg = palette.blue })

    -- title
    vim.api.nvim_set_hl(0, 'NotifyERRORTitle', { fg = palette.red })
    vim.api.nvim_set_hl(0, 'NotifyWARNTitle', { fg = palette.yellow })
    vim.api.nvim_set_hl(0, 'NotifyINFOTitle', { fg = palette.green })
    vim.api.nvim_set_hl(0, 'NotifyDEBUGTitle', { fg = palette.hint })
    vim.api.nvim_set_hl(0, 'NotifyTRACETitle', { fg = palette.blue })
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
        setup_lualine()
        setup_nvim_notify()
    end,
}
