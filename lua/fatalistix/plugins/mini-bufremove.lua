-- Обертка над буфферами nvim
return {
    "echasnovski/mini.bufremove",
    version = '*',
    config = function(_, opts)
        local bufremove = require("mini.bufremove")
        bufremove.setup(opts)

        vim.keymap.set('n', '<leader>bd', function(bufnr)
            bufremove.delete(bufnr, false)
        end, { desc = "Close buffer" })

        vim.keymap.set('n', '<leader>bc', function(bufnr)
            bufremove.delete(bufnr, false)
        end, { desc = "Close buffer" })
    end,
}
