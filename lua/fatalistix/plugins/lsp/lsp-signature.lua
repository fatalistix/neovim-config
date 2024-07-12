-- https://github.com/ray-x/lsp_signature.nvim
-- Отвечает за подсказки в сигнатуре функции
return {
    'ray-x/lsp_signature.nvim',
    event = 'VeryLazy',
    opts = {
        floating_window = true,
        hint_prefix = '',
    },
    config = function(_, opts)
        local lsp_signature = require('lsp_signature')
        lsp_signature.setup(opts)

        vim.keymap.set('n', '<Leader>k', function()
            lsp_signature.toggle_float_win()
        end, { silent = true, noremap = true, desc = 'Toggle signature' })

        vim.keymap.set({ 'n', 'i' }, '<C-s>', function()
            lsp_signature.toggle_float_win()
        end, { silent = true, noremap = true, desc = 'Toggle signature' })
    end,
}
