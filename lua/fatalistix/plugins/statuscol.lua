-- better statuses line (which is lefter than numbers)
return {
    'luukvbaal/statuscol.nvim',
    opts = function()
        local builtin = require('statuscol.builtin')

        return {
            segments = {
                { text = { builtin.foldfunc }, click = 'v:lua.ScFa' },
                { text = { '%s' }, click = 'v:lua.ScSa' },
                {
                    text = { builtin.lnumfunc, ' ' },
                    condition = { true, builtin.not_empty },
                    click = 'v:lua.ScLa',
                },
            },
        }
    end,
}
